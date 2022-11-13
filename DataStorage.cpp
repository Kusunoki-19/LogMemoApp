#include "DataStorage.h"

DataCell::DataCell(QObject* parent)
    : m_type(DataCell::DataType::Invalid)
    , m_byteSize(0)
    , m_value(QVariant())
    , QObject(parent)
{
}

DataCell::DataCell(DataType type, quint32 byteSize, QVariant value, QObject* parent)
    : m_type(type)
    , m_byteSize(byteSize)
    , m_value(value)
    , QObject(parent)
{
}

DataCell::DataCell(const DataCell& other)
{
    m_type = other.m_type;
    m_byteSize = other.m_byteSize;
    m_value = other.m_value;
}

DataCell& DataCell::operator=(const DataCell& other)
{
    if (this == &other) {
        return *this;
    } else {
        this->m_type = other.m_type;
        this->m_byteSize = other.m_byteSize;
        this->m_value = other.m_value;
        return *this;
    }
}

bool DataCell::operator==(const DataCell& other) const
{
    if ((this->m_type == other.m_type) && (this->m_byteSize == other.m_byteSize)
        && (this->m_value == other.m_value)) {
        return true;
    } else {
        return false;
    }
}

bool DataCell::operator!=(const DataCell& other) const { return !((*this) == other); }

DataCell::~DataCell() { }

DataCell::DataType DataCell::type() const { return m_type; }

void DataCell::setType(DataType newType)
{
    if (m_type == newType)
        return;
    m_type = newType;
    emit typeChanged();
}

quint32 DataCell::byteSize() const { return m_byteSize; }

void DataCell::setByteSize(quint32 newByteSize)
{
    if (m_byteSize == newByteSize)
        return;
    m_byteSize = newByteSize;
    emit byteSizeChanged();
}

const QVariant& DataCell::value() const { return m_value; }

void DataCell::setValue(const QVariant& newValue)
{
    if (m_value == newValue)
        return;
    m_value = newValue;
    emit valueChanged();
}


//----------------------------------------------------------------
Subject::Subject(QObject* parent)
    : m_category(DataCell())
    , m_name(DataCell())
    , QObject(parent)
{
}

Subject::Subject(DataCell category, DataCell name, QObject* parent)
    : m_category(category)
    , m_name(name)
    , QObject(parent)
{
}

Subject::Subject(const Subject &other) : m_category(other.m_category), m_name(other.m_name)
{
}

Subject &Subject::operator=(const Subject &other)
{
    if (this == &other) {
        return *this;
    } else {
        this->m_category = other.m_category;
        this->m_name = other.m_name;
        return *this;
    }
}

bool Subject::operator==(const Subject &other) const
{
    if ((m_category == other.m_category) && (m_name == other.m_name)) {
        return true;
    }
    else {
        return false;
    }
}

bool Subject::operator!=(const Subject &other) const
{
    return !(*this == other);
}


Subject::~Subject() { }

const DataCell& Subject::category() const { return m_category; }

void Subject::setCategory(const DataCell& newCategory)
{
    if (m_category == newCategory)
        return;
    m_category = newCategory;
    emit categoryChanged();
}

const DataCell& Subject::name() const { return m_name; }

void Subject::setName(const DataCell& newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

//----------------------------------------------------------------
LogRecord::LogRecord(QObject* parent) { }

LogRecord::LogRecord(DataCell subject, DataCell startDate, DataCell endDate, QObject* parent)
    : m_subject(subject)
    , m_startDate(startDate)
    , m_endDate(endDate)
    , QObject(parent)
{
}

LogRecord::LogRecord(const LogRecord &other) : m_subject(other.m_subject), m_startDate(other.m_startDate), m_endDate(other.m_endDate)
{
}

LogRecord::~LogRecord() { }

const DataCell& LogRecord::subject() const { return m_subject; }

void LogRecord::setSubject(const DataCell& newSubject)
{
    if (m_subject == newSubject)
        return;
    m_subject = newSubject;
    emit subjectChanged();
}

const DataCell& LogRecord::startDate() const { return m_startDate; }

void LogRecord::setStartDate(const DataCell& newStartDate)
{
    if (m_startDate == newStartDate)
        return;
    m_startDate = newStartDate;
    emit startDateChanged();
}

const DataCell& LogRecord::endDate() const { return m_endDate; }

void LogRecord::setEndDate(const DataCell& newEndDate)
{
    if (m_endDate == newEndDate)
        return;
    m_endDate = newEndDate;
    emit endDateChanged();
}

LogRecord &LogRecord::operator=(const LogRecord &other)
{
    if (this == &other) {
        return *this;
    } else {
        this->m_subject = other.m_subject;
        this->m_startDate = other.m_startDate;
        this->m_endDate = other.m_endDate;
        return *this;
    }
}

bool LogRecord::operator==(const LogRecord &other) const
{
    if ((m_subject == other.m_subject) && (m_startDate == other.m_startDate) && (m_endDate == other.m_endDate)) {
        return true;
    }
    else {
        return false;
    }

}

bool LogRecord::operator!=(const LogRecord &other) const
{
    return !(*this == other);
}

//----------------------------------------------------------------
DataStorage::DataStorage(QObject* parent) {
    Subject subject (
        DataCell{
            DataCell::DataType::String,
            20,
            QVariant("test subject category"),
        },
        DataCell{
            DataCell::DataType::String,
            20,
            QVariant("test subject name"),
        }
    );
    m_subjects.append(subject);
}

const QList<Subject> &DataStorage::subjects() const
{
    return m_subjects;
}

void DataStorage::setSubjects(const QList<Subject> &newSubjects)
{
    if (m_subjects == newSubjects)
        return;
    m_subjects = newSubjects;
    emit subjectsChanged();
}

const QList<LogRecord> &DataStorage::records() const
{
    return m_records;
}

void DataStorage::setRecords(const QList<LogRecord> &newRecords)
{
    if (m_records == newRecords)
        return;
    m_records = newRecords;
    emit recordsChanged();
}
