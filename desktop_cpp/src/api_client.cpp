#include "api_client.h"
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>

ApiClient::ApiClient(QObject *parent)
    : QObject(parent),
      m_networkManager(new QNetworkAccessManager(this))
{
}

void ApiClient::setBaseUrl(const QString &url) {
    m_baseUrl = url;
    if (m_baseUrl.endsWith('/')) {
        m_baseUrl.chop(1);
    }
}

void ApiClient::setApiKey(const QString &key) {
    m_apiKey = key;
}

QNetworkRequest ApiClient::createRequest(const QString &endpoint) const {
    QUrl url(m_baseUrl + endpoint);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    if (!m_apiKey.isEmpty()) {
        request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());
    }

    return request;
}

void ApiClient::checkStatus() {
    QNetworkRequest request = createRequest("/status");
    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            if (doc.isObject()) {
                QJsonObject obj = doc.object();
                QString version = obj.value("version").toString("0.6.0");
                double cpu = obj.value("cpu").toDouble(0.0);
                double ram = obj.value("ram").toDouble(0.0);
                double disk = obj.value("disk").toDouble(0.0);
                qint64 uptime = static_cast<qint64>(obj.value("uptime").toDouble(0));

                emit statusReceived(true, version, cpu, ram, disk, uptime);
                return;
            }
        }
        emit statusReceived(false, "0.6.0", 0.0, 0.0, 0.0, 0);
    });
}

void ApiClient::sendMessage(const QString &message, const QString &forceModel) {
    QNetworkRequest request = createRequest("/chat");
    QJsonObject json;
    json["message"] = message;
    if (!forceModel.isEmpty() && forceModel != "Auto") {
        json["force_model"] = forceModel.toLower();
    }

    QNetworkReply *reply = m_networkManager->post(request, QJsonDocument(json).toJson());

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            if (doc.isObject()) {
                QJsonObject obj = doc.object();
                QString response = obj.value("response").toString();
                QString modelUsed = obj.value("model_used").toString("qwen3");
                int tokens = obj.value("tokens").toInt(0);

                emit chatResponseReceived(response, modelUsed, tokens);
                return;
            }
        }
        emit errorOccurred(QString("Ошибка чата: %1").arg(reply->errorString()));
    });
}

void ApiClient::fetchTasks() {
    QNetworkRequest request = createRequest("/tasks");
    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            if (doc.isArray()) {
                QList<TaskItem> tasks;
                QJsonArray arr = doc.array();
                for (const QJsonValue &val : arr) {
                    if (val.isObject()) {
                        QJsonObject obj = val.toObject();
                        TaskItem item;
                        item.id = obj.value("id").toInt();
                        item.title = obj.value("title").toString();
                        item.done = obj.value("done").toInt(0) == 1 || obj.value("done").toBool(false);
                        item.dueAt = obj.value("due_at").toString();
                        item.source = obj.value("source").toString("manual");
                        tasks.append(item);
                    }
                }
                emit tasksReceived(tasks);
                return;
            }
        }
    });
}

void ApiClient::addTask(const QString &title, const QString &dueAt) {
    QNetworkRequest request = createRequest("/tasks");
    QJsonObject json;
    json["title"] = title;
    if (!dueAt.isEmpty()) {
        json["due_at"] = dueAt;
    }

    QNetworkReply *reply = m_networkManager->post(request, QJsonDocument(json).toJson());

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        bool ok = (reply->error() == QNetworkReply::NoError);
        emit taskAdded(ok);
        if (ok) {
            fetchTasks();
        } else {
            emit errorOccurred("Не удалось добавить задачу");
        }
    });
}

void ApiClient::toggleTaskDone(int taskId) {
    QNetworkRequest request = createRequest(QString("/tasks/%1/done").arg(taskId));
    QNetworkReply *reply = m_networkManager->sendCustomRequest(request, "PATCH");

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        bool ok = (reply->error() == QNetworkReply::NoError);
        emit taskToggled(ok);
        if (ok) {
            fetchTasks();
        }
    });
}

void ApiClient::fetchMetrics() {
    QNetworkRequest request = createRequest("/metrics/system");
    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            if (doc.isObject()) {
                QJsonObject obj = doc.object();
                double cpu = obj.value("cpu_percent").toDouble(0.0);
                double ram = obj.value("ram_percent").toDouble(0.0);
                double disk = obj.value("disk_percent").toDouble(0.0);
                qint64 uptime = static_cast<qint64>(obj.value("uptime").toDouble(0));

                emit metricsReceived(cpu, ram, disk, uptime);
            }
        }
    });
}

void ApiClient::fetchMemory() {
    QNetworkRequest request = createRequest("/memory");
    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        reply->deleteLater();
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            if (doc.isArray()) {
                QList<MemoryItem> memoryItems;
                QJsonArray arr = doc.array();
                for (const QJsonValue &val : arr) {
                    if (val.isObject()) {
                        QJsonObject obj = val.toObject();
                        MemoryItem item;
                        item.key = obj.value("key").toString();
                        item.value = obj.value("value").toString();
                        item.category = obj.value("category").toString("general");
                        memoryItems.append(item);
                    }
                }
                emit memoryReceived(memoryItems);
            }
        }
    });
}
