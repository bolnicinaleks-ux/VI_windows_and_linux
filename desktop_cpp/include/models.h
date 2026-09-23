#ifndef MODELS_H
#define MODELS_H

#include <QString>
#include <QDateTime>
#include <QMetaType>

struct TaskItem {
    int id{0};
    QString title;
    bool done{false};
    QString dueAt;
    QString source{"manual"};
};
Q_DECLARE_METATYPE(TaskItem)

struct MetricItem {
    double cpuPercent{0.0};
    double ramPercent{0.0};
    double diskPercent{0.0};
    qint64 uptimeSeconds{0};
    QString timestamp;
};
Q_DECLARE_METATYPE(MetricItem)

struct MemoryItem {
    QString key;
    QString value;
    QString category;
};
Q_DECLARE_METATYPE(MemoryItem)

struct ChatMessage {
    QString sender; // "user" or "vi"
    QString text;
    QString modelUsed;
    int tokens{0};
    QString timestamp;
};
Q_DECLARE_METATYPE(ChatMessage)

#endif // MODELS_H
