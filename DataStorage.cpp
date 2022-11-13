#include "DataStorage.h"

const QList<QVariantMap> &DataStorageAPI::subjects() const
{
    return m_subjects;
}

const QList<QVariantMap> &DataStorageAPI::records() const
{
    return m_records;
}
