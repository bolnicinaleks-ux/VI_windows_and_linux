#ifndef API_CLIENT_H
#define API_CLIENT_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QUrl>
#include "models.h"

class ApiClient : public QObject {
    Q_OBJECT

public:
    explicit ApiClient(QObject *parent = nullptr);
    ~ApiClient() override = default;

    void setBaseUrl(const QString &url);
    QString baseUrl() const { return m_baseUrl; }

    void setApiKey(const QString &key);
    QString apiKey() const { return m_apiKey; }

    void checkStatus();
    void sendMessage(const QString &message, const QString &forceModel = QString());
    void fetchTasks();
    void addTask(const QString &title, const QString &dueAt = QString());
    void toggleTaskDone(int taskId);
    void fetchMetrics();
    void fetchMemory();

signals:
    void statusReceived(bool isOnline, const QString &version, double cpu, double ram, double disk, qint64 uptime);
    void chatResponseReceived(const QString &response, const QString &modelUsed, int tokens);
    void tasksReceived(const QList<TaskItem> &tasks);
    void taskAdded(bool success);
    void taskToggled(bool success);
    void metricsReceived(double cpu, double ram, double disk, qint64 uptime);
    void memoryReceived(const QList<MemoryItem> &memoryItems);
    void errorOccurred(const QString &errorMessage);

private:
    QNetworkRequest createRequest(const QString &endpoint) const;

    QNetworkAccessManager *m_networkManager{nullptr};
    QString m_baseUrl{"http://localhost:8000"};
    QString m_apiKey;
};

#endif // API_CLIENT_H
