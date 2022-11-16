#ifndef DATASTORAGE_H
#define DATASTORAGE_H

#include <QObject>
#include <QVariant>

#include <string>
#include <vector>
#include <cstdint>
#include <Optional>

//namespace details {
//struct Subject {
//    QString name;
//    QString category;
//};
//struct Date {
//    uint year;
//    uint month;
//    uint day;
//    uint hour;
//    uint min;
//};
//struct Record {
//    Subject subject;
//    Date startDate;
//    Date endDate;
//};
//}

#include <QDebug>

#define ORGANIZATION_NAME "Kusunoki-19"
#define ORGANIZATION_DOMAIN "Kusunoki-19"
#define APPLICATION_NAME "LogMemoApp"

class DataStorage : public QObject {
    Q_OBJECT
public:
    explicit DataStorage(QObject* parent = nullptr);;
    virtual ~DataStorage(){};

    Q_PROPERTY(QVariantList records READ records NOTIFY recordsChanged)
    Q_PROPERTY(QVariantList subjects READ subjects NOTIFY subjectsChanged)
    Q_PROPERTY(QStringList categories READ categories NOTIFY categoriesChanged)

    const QVariantList &records() const;
    const QVariantList &subjects() const;
    const QStringList &categories() const;

    Q_INVOKABLE bool addRecord(const QVariantMap& record);
    Q_INVOKABLE bool addSubject(const QVariantMap& subject);
    Q_INVOKABLE bool addCategory(const QString& category);

    Q_INVOKABLE bool removeRecord(const QVariantMap& record);
    Q_INVOKABLE bool removeSubject(const QVariantMap& subject);
    Q_INVOKABLE bool removeCategory(const QString& category);
    Q_INVOKABLE bool removeRecord(int index);
    Q_INVOKABLE bool removeSubject(int index);
    Q_INVOKABLE bool removeCategory(int index);

signals:
    void recordsChanged();
    void subjectsChanged();
    void categoriesChanged();

private:
    QVariantList m_records;
    QVariantList m_subjects;
    QStringList m_categories;
};

namespace details {

bool tryAddRecord (QVariantList& records, const QVariantMap& record);
bool tryAddSubject (QVariantList& subjects, const QVariantMap& subject);
bool tryAddCategory (QStringList& categories, const QString& category);

}


#endif // DATASTORAGE_H
