#include "DataStorage.h"
#include <QSettings>
#include <QCoreApplication>

DataStorage::DataStorage(QObject *parent){
    QSettings settings;
    m_records = settings.value("m_records").value<QVariantList>();
    m_subjects = settings.value("m_subjects").value<QVariantList>();
    m_categories = settings.value("m_categories").value<QStringList>();

    /* on change organize name, execute those by new name * /
    QCoreApplication::setOrganizationName(ORGANIZATION_NAME);
    QCoreApplication::setOrganizationDomain(ORGANIZATION_DOMAIN);
    QCoreApplication::setApplicationName(APPLICATION_NAME);
    QSettings settingsTemp;
    settingsTemp.setValue("m_records", m_records);
    settingsTemp.setValue("m_subjects", m_subjects);
    settingsTemp.setValue("m_categories", m_categories);
    // */

    connect(this, &DataStorage::recordsChanged, this, [=]() {
        QSettings settings;
        settings.setValue("m_records", m_records);
    });
    connect(this, &DataStorage::subjectsChanged, this, [=]() {
        QSettings settings;
        settings.setValue("m_subjects", m_subjects);
    });
    connect(this, &DataStorage::categoriesChanged, this, [=]() {
        QSettings settings;
        settings.setValue("m_categories", m_categories);
    });
}

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

bool DataStorage::addRecord(const QVariantMap &record) {

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

bool DataStorage::removeRecord(const QVariantMap &record)
{
    m_records.removeAll(record);
    emit recordsChanged();
    return true;
}

bool DataStorage::removeSubject(const QVariantMap &subject)
{
    m_subjects.removeAll(subject);
    emit subjectsChanged();
    return true;
}

bool DataStorage::removeCategory(const QString &category)
{
    m_categories.removeAll(category);
    emit categoriesChanged();
    return true;
}

bool DataStorage::removeRecord(int index)
{
    m_records.removeAt(index);
    emit recordsChanged();
    return true;
}

bool DataStorage::removeSubject(int index)
{
    m_subjects.removeAt(index);
    emit subjectsChanged();
    return true;
}

bool DataStorage::removeCategory(int index)
{
    m_categories.removeAt(index);
    emit categoriesChanged();
    return true;
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

