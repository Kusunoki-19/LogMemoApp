#ifndef DATASTORAGESERVICE_H
#define DATASTORAGESERVICE_H

#include <QObject>
#include <QVariant>
#include <QVariantMap>
#include <DataStorage.h>

class DataStorageService : QObject {
    explicit DataStorageService(QObject* parent = nullptr)
        : QObject(parent)
    {
    }
    virtual ~DataStorageService() { }
    Q_PROPERTY(QList<QVariantMap> subjects READ subjects NOTIFY subjectsChanged)
    Q_PROPERTY(QList<QVariantMap> records READ records NOTIFY recordsChanged)

public:
    const QList<QVariantMap>& subjects() const;
    const QList<QVariantMap>& records() const;

signals:
    void subjectsChanged();
    void recordsChanged();

private:
    QList<QVariantMap> m_subjects;
    QList<QVariantMap> m_records;
};

#endif // DATASTORAGESERVICE_H
