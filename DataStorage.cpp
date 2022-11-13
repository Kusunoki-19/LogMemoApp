#include "DataStorage.h"

const QVariantList &DataStorage::subjects() const
{
    return m_subjects;
}

const QVariantList &DataStorage::records() const
{
    return m_records;
}
