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

class DataStorage : public QObject {
    Q_OBJECT
public:
    explicit DataStorage(QObject* parent = nullptr);
    Q_PROPERTY(QVariantList subjects READ subjects NOTIFY subjectsChanged)
    Q_PROPERTY(QVariantList records READ records NOTIFY recordsChanged)


    Q_INVOKABLE bool addRecord(const QVariantMap& subject, const QVariantMap& startDate, const QVariantMap& endDate) {
        m_subjects.emplaceBack(QVariantMap{{"subject" , subject}, {"startDate",  startDate} ,{"endDate",  endDate}});
        return true;
    }

    QVariantList m_subjects;
    QVariantList m_records;
};


#endif // DATASTORAGE_H
