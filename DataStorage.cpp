#include "DataStorage.h"

const QVariantList &DataStorage::subjects() const
{
    return m_subjects;
}

const QVariantList &DataStorage::categories() const
{
    return m_categories;
}

const QVariantList &DataStorage::records() const
{
    return m_records;
}

bool DataStorage::addSubject(const QVariantMap &subject)
{
    m_subjects.push_back(subject);
    emit subjectsChanged();
    return true;
}

bool DataStorage::addRecord(const QVariantMap &subject, const QVariantMap &startDate, const QVariantMap &endDate) {
    m_subjects.push_back(subject);
    m_categories.push_back(subject["category"]);
    m_records.push_back(QVariantMap{{"subject" , subject}, {"startDate",  startDate} ,{"endDate",  endDate}});
    emit subjectsChanged();
    emit categoriesChanged();
    emit recordsChanged();

    return true;
}

