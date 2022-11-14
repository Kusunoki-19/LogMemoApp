#include "DataStorage.h"

const QVariantList &DataStorage::records() const
{
    return m_records;
}

const QVariantList &DataStorage::subjects() const
{
    return m_subjects;
}

const QStringList &DataStorage::categories() const
{
    return m_categories;
}

bool DataStorage::addRecord(const QVariantMap &subject, const QVariantMap &startDate, const QVariantMap &endDate) {
    QVariantMap record {{"subject" , subject}, {"startDate",  startDate} ,{"endDate",  endDate}};

    if (details::tryAddRecord(m_records, record)) {
        emit recordsChanged();
        return true;
    }
    else {
        return false;
    }
}

bool DataStorage::addSubject(const QVariantMap &subject)
{
    if (details::tryAddSubject(m_subjects, subject)) {
        emit subjectsChanged();
        return true;
    }
    else {
        return false;
    }
}

bool DataStorage::addCategory(const QString &category)
{
    if (details::tryAddCategory(m_categories, category)) {
        emit categoriesChanged();
        return true;
    }
    else {
        return false;
    }
}

bool details::tryAddRecord(QVariantList &records, const QVariantMap &record)
{
    if (records.contains(record)) {
        return false;
    }

    records.push_back(record);
    return true;
}

bool details::tryAddSubject(QVariantList &subjects, const QVariantMap &subject)
{
    if (subjects.contains(subject)) {
        return false;
    }

    subjects.push_back(subject);
    return true;
}

bool details::tryAddCategory(QStringList &categories, const QString &category)
{
    if (categories.contains(category)) {
        return false;
    }

    categories.push_back(category);
    return true;
}

