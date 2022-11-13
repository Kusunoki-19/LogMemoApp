#include "DataStorageService.h"

const QList<QVariantMap> &DataStorageService::subjects() const
{
    return m_subjects;
}

const QList<QVariantMap> &DataStorageService::records() const
{
    return m_records;
}
