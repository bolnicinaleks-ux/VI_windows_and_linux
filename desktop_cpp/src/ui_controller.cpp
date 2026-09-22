#include "ui_controller.h"
#include <QDateTime>
#include <QDebug>

UIController::UIController(QObject *parent)
    : QObject(parent),
      m_apiClient(new ApiClient(this)),
      m_pollTimer(new QTimer(this))
{
    loadSettings();

    connect(m_apiClient, &ApiClient::statusReceived, this, &UIController::onStatusReceived);
    connect(m_apiClient, &ApiClient::chatResponseReceived, this, &UIController::onChatResponseReceived);
    connect(m_apiClient, &ApiClient::tasksReceived, this, &UIController::onTasksReceived);
    connect(m_apiClient, &ApiClient::metricsReceived, this, &UIController::onMetricsReceived);
    connect(m_apiClient, &ApiClient::memoryReceived, this, &UIController::onMemoryReceived);
    connect(m_apiClient, &ApiClient::errorOccurred, this, &UIController::onErrorOccurred);

    connect(m_pollTimer, &QTimer::timeout, this, &UIController::refreshData);
    m_pollTimer->start(5000); // Poll every 5 seconds

    refreshData();
}

void UIController::loadSettings() {
    QSettings settings("ViOrg", "ViDesktop");
    m_serverUrl = settings.value("serverUrl", "http://localhost:8000").toString();
    m_apiKey = settings.value("apiKey", "").toString();

    m_apiClient->setBaseUrl(m_serverUrl);
    m_apiClient->setApiKey(m_apiKey);
}

void UIController::saveSettings(const QString &url, const QString &key) {
    setServerUrl(url);
    setApiKey(key);

    QSettings settings("ViOrg", "ViDesktop");
    settings.setValue("serverUrl", m_serverUrl);
    settings.setValue("apiKey", m_apiKey);

    refreshData();
}

void UIController::setServerUrl(const QString &url) {
    if (m_serverUrl != url) {
        m_serverUrl = url;
        m_apiClient->setBaseUrl(m_serverUrl);
        emit serverUrlChanged();
    }
}

void UIController::setApiKey(const QString &key) {
    if (m_apiKey != key) {
        m_apiKey = key;
        m_apiClient->setApiKey(m_apiKey);
        emit apiKeyChanged();
    }
}

void UIController::sendMessage(const QString &message, const QString &forceModel) {
    if (message.trimmed().isEmpty()) return;

    appendChatMessage("user", message);

    m_isThinking = true;
    emit thinkingChanged();

    m_apiClient->sendMessage(message, forceModel);
}

void UIController::addTask(const QString &title, const QString &dueAt) {
    if (title.trimmed().isEmpty()) return;
    m_apiClient->addTask(title, dueAt);
}

void UIController::toggleTaskDone(int taskId) {
    m_apiClient->toggleTaskDone(taskId);
}

void UIController::refreshData() {
    m_apiClient->checkStatus();
    m_apiClient->fetchTasks();
    m_apiClient->fetchMetrics();
    m_apiClient->fetchMemory();
}

void UIController::clearChatHistory() {
    m_chatHistory.clear();
    emit chatHistoryChanged();
}

void UIController::appendChatMessage(const QString &sender, const QString &text, const QString &modelUsed, int tokens) {
    QVariantMap msg;
    msg["sender"] = sender;
    msg["text"] = text;
    msg["modelUsed"] = modelUsed;
    msg["tokens"] = tokens;
    msg["timestamp"] = QDateTime::currentDateTime().toString("hh:mm");

    m_chatHistory.append(msg);
    emit chatHistoryChanged();
}

void UIController::onStatusReceived(bool isOnline, const QString &version, double cpu, double ram, double disk, qint64 uptime) {
    m_isOnline = isOnline;
    m_serverVersion = version;
    m_cpuUsage = cpu;
    m_ramUsage = ram;
    m_diskUsage = disk;
    m_serverUptime = uptime;

    emit statusChanged();
}

void UIController::onChatResponseReceived(const QString &response, const QString &modelUsed, int tokens) {
    m_isThinking = false;
    emit thinkingChanged();

    appendChatMessage("vi", response, modelUsed, tokens);
}

void UIController::onTasksReceived(const QList<TaskItem> &taskList) {
    m_tasks.clear();
    for (const auto &item : taskList) {
        QVariantMap map;
        map["id"] = item.id;
        map["title"] = item.title;
        map["done"] = item.done;
        map["dueAt"] = item.dueAt;
        map["source"] = item.source;
        m_tasks.append(map);
    }
    emit tasksChanged();
}

void UIController::onMetricsReceived(double cpu, double ram, double disk, qint64 uptime) {
    m_cpuUsage = cpu;
    m_ramUsage = ram;
    m_diskUsage = disk;
    m_serverUptime = uptime;
    emit statusChanged();
}

void UIController::onMemoryReceived(const QList<MemoryItem> &memList) {
    m_memoryItems.clear();
    for (const auto &item : memList) {
        QVariantMap map;
        map["key"] = item.key;
        map["value"] = item.value;
        map["category"] = item.category;
        m_memoryItems.append(map);
    }
    emit memoryItemsChanged();
}

void UIController::onErrorOccurred(const QString &errorMessage) {
    m_isThinking = false;
    emit thinkingChanged();

    emit notificationReceived("Ошибка", errorMessage);
}
