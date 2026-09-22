#ifndef UI_CONTROLLER_H
#define UI_CONTROLLER_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>
#include <QTimer>
#include <QSettings>
#include "api_client.h"

class UIController : public QObject {
    Q_OBJECT

    Q_PROPERTY(bool isOnline READ isOnline NOTIFY statusChanged)
    Q_PROPERTY(QString serverVersion READ serverVersion NOTIFY statusChanged)
    Q_PROPERTY(double cpuUsage READ cpuUsage NOTIFY statusChanged)
    Q_PROPERTY(double ramUsage READ ramUsage NOTIFY statusChanged)
    Q_PROPERTY(double diskUsage READ diskUsage NOTIFY statusChanged)
    Q_PROPERTY(qint64 serverUptime READ serverUptime NOTIFY statusChanged)

    Q_PROPERTY(QString serverUrl READ serverUrl WRITE setServerUrl NOTIFY serverUrlChanged)
    Q_PROPERTY(QString apiKey READ apiKey WRITE setApiKey NOTIFY apiKeyChanged)

    Q_PROPERTY(QVariantList chatHistory READ chatHistory NOTIFY chatHistoryChanged)
    Q_PROPERTY(QVariantList tasks READ tasks NOTIFY tasksChanged)
    Q_PROPERTY(QVariantList memoryItems READ memoryItems NOTIFY memoryItemsChanged)
    Q_PROPERTY(bool isThinking READ isThinking NOTIFY thinkingChanged)

public:
    explicit UIController(QObject *parent = nullptr);
    ~UIController() override = default;

    bool isOnline() const { return m_isOnline; }
    QString serverVersion() const { return m_serverVersion; }
    double cpuUsage() const { return m_cpuUsage; }
    double ramUsage() const { return m_ramUsage; }
    double diskUsage() const { return m_diskUsage; }
    qint64 serverUptime() const { return m_serverUptime; }

    QString serverUrl() const { return m_serverUrl; }
    void setServerUrl(const QString &url);

    QString apiKey() const { return m_apiKey; }
    void setApiKey(const QString &key);

    QVariantList chatHistory() const { return m_chatHistory; }
    QVariantList tasks() const { return m_tasks; }
    QVariantList memoryItems() const { return m_memoryItems; }
    bool isThinking() const { return m_isThinking; }

    Q_INVOKABLE void sendMessage(const QString &message, const QString &forceModel = QString());
    Q_INVOKABLE void addTask(const QString &title, const QString &dueAt = QString());
    Q_INVOKABLE void toggleTaskDone(int taskId);
    Q_INVOKABLE void refreshData();
    Q_INVOKABLE void saveSettings(const QString &url, const QString &key);
    Q_INVOKABLE void clearChatHistory();

signals:
    void statusChanged();
    void serverUrlChanged();
    void apiKeyChanged();
    void chatHistoryChanged();
    void tasksChanged();
    void memoryItemsChanged();
    void thinkingChanged();
    void notificationReceived(const QString &title, const QString &message);

private slots:
    void onStatusReceived(bool isOnline, const QString &version, double cpu, double ram, double disk, qint64 uptime);
    void onChatResponseReceived(const QString &response, const QString &modelUsed, int tokens);
    void onTasksReceived(const QList<TaskItem> &taskList);
    void onMetricsReceived(double cpu, double ram, double disk, qint64 uptime);
    void onMemoryReceived(const QList<MemoryItem> &memList);
    void onErrorOccurred(const QString &errorMessage);

private:
    void loadSettings();
    void appendChatMessage(const QString &sender, const QString &text, const QString &modelUsed = QString(), int tokens = 0);

    ApiClient *m_apiClient{nullptr};
    QTimer *m_pollTimer{nullptr};

    bool m_isOnline{false};
    QString m_serverVersion{"0.6.0"};
    double m_cpuUsage{0.0};
    double m_ramUsage{0.0};
    double m_diskUsage{0.0};
    qint64 m_serverUptime{0};

    QString m_serverUrl{"http://localhost:8000"};
    QString m_apiKey{""};

    QVariantList m_chatHistory;
    QVariantList m_tasks;
    QVariantList m_memoryItems;
    bool m_isThinking{false};
};

#endif // UI_CONTROLLER_H
