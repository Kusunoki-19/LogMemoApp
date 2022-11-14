#include "DataStorage.h"

const QVariantList &DataStorage::subjects() const
{
    return m_subjects;
}

const QStringList &DataStorage::categories() const
{
    return m_categories;
}

const QVariantList &DataStorage::records() const
{
    return m_records;
}

bool DataStorage::addSubject(const QVariantMap &subject)
{
    if (m_subjects.contains(subject)) {
        return false;
    }

    m_subjects.push_back(subject);
    emit subjectsChanged();
    return true;
}

bool DataStorage::addCategory(const QString &category)
{
    if (m_categories.contains(category)) {
        return false;
    }

    m_categories.push_back(category);
    emit categoriesChanged();
    return true;
}

bool DataStorage::addRecord(const QVariantMap &subject, const QVariantMap &startDate, const QVariantMap &endDate) {
    m_subjects.push_back(subject);
    m_categories.push_back(subject["category"].toString());
    m_records.push_back(QVariantMap{{"subject" , subject}, {"startDate",  startDate} ,{"endDate",  endDate}});
    emit subjectsChanged();
    emit categoriesChanged();
    emit recordsChanged();

    return true;
}


bool details::tryAddSubject(QVariantList &subjects, const QVariantMap &subject)
{

}

bool details::tryAddCategory(QVariantList &categories, const QString &category)
{

}

bool details::tryAddRecord(QVariantList &records, const QVariantMap &record)
{

}
