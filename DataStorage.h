#ifndef DATASTORAGE_H
#define DATASTORAGE_H

#include <QObject>
#include <QVariant>

#include <string>
#include <vector>
#include <cstdint>
#include <Optional>



namespace details {

struct Subject {
    QString name;
    QString category;
};

struct Date {
    uint year;
    uint month;
    uint day;
    uint hour;
    uint min;
};

struct Record {
    Subject subject;
    Date startDate;
    Date endDate;
};



/*
std::optional<Date> dateObjFromVariantMap(const QVariantMap& date) {
    if (date.contains("year") && date.contains("month") && date.contains("day") && date.contains("hour") && date.contains("min")) {
        bool isConvertOK = false;

        uint year =  date["year"].toUInt(&isConvertOK);
        if (!isConvertOK) return std::nullopt;

        uint month =  date["month"].toUInt(&isConvertOK);
        if (!isConvertOK) return std::nullopt;

        uint day =  date["day"].toUInt(&isConvertOK);
        if (!isConvertOK) return std::nullopt;

        uint hour =  date["hour"].toUInt(&isConvertOK);
        if (!isConvertOK) return std::nullopt;

        uint min =  date["min"].toUInt(&isConvertOK);
        if (!isConvertOK) return std::nullopt;

        return Date {
            year, month, day, hour, min
        };
    }
    else {
        return std::nullopt;
    }
}
*/

}

#include <QDebug>

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

    Q_INVOKABLE bool addRecord(const QVariantMap& subject, const QVariantMap& startDate, const QVariantMap& endDate);
    Q_INVOKABLE bool addSubject(const QVariantMap& subject);
    Q_INVOKABLE bool addCategory(const QString& category);

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
