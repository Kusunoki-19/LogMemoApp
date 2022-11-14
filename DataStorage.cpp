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

