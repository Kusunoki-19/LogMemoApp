#ifndef DATASTORAGE_H
#define DATASTORAGE_H

#include <QObject>
#include <QVariant>
#include <memory>

/**
 * @brief The DataCell class
 *
 * Contanis type infomation property and real value property.
 */
class DataCell : public QObject {
    Q_OBJECT

public:
    enum DataType { Invalid, Int, String };
    Q_ENUM(DataType)

    explicit DataCell(QObject* parent = nullptr);
    explicit DataCell(DataType type, quint32 byteSize, QVariant value, QObject* parent = nullptr);
    explicit DataCell(const DataCell& other);
    void swap(DataCell& dataCell);
    DataCell& operator=(const DataCell& other);
    bool operator==(const DataCell& other) const;
    bool operator!=(const DataCell& other) const;
    virtual ~DataCell();

    Q_PROPERTY(DataType type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(quint32 byteSize READ byteSize WRITE setByteSize NOTIFY byteSizeChanged)
    Q_PROPERTY(QVariant value READ value WRITE setValue NOTIFY valueChanged)

    DataType type() const;
    void setType(DataType newType);

    quint32 byteSize() const;
    void setByteSize(quint32 newByteSize);

    const QVariant& value() const;
    void setValue(const QVariant& newValue);

    template<typename T> 
    bool setData(const T &data) {
        return false;
    };

    template <>
    bool setData(const std::string &data) {
        m_type = DataType::String;
        m_byteSize = data.size();
        m_value = QVariant(data.c_str());
        emit typeChanged();
        emit byteSizeChanged();
        emit valueChanged();
        return true;
    };

    template <>
    bool setData(const std::int64_t &data) {
        m_type = DataType::Int;
        m_byteSize = sizeof(data);
        m_value = QVariant(data);
        emit typeChanged();
        emit byteSizeChanged();
        emit valueChanged();
        return true;
    };

    void clearData() {
        m_type = DataType::Invalid;
        m_byteSize = 0;
        m_value = QVariant();
        emit typeChanged();
        emit byteSizeChanged();
        emit valueChanged();
    };

signals:

    void valueChanged();
    void typeChanged();
    void byteSizeChanged();

private:
    quint32 m_byteSize;
    DataType m_type;
    QVariant m_value;
};

/**
 * @brief The Subject class
 *
 * subject for log content.
 */
class Subject : public QObject {
    Q_OBJECT

public:
    explicit Subject(QObject* parent = nullptr);
    explicit Subject(DataCell category, DataCell name, QObject* parent = nullptr);
    explicit Subject(const Subject& other);
    Subject &operator=(const Subject& other);
    bool operator==(const Subject& other) const;
    bool operator!=(const Subject& other) const;

    virtual ~Subject();

    Q_PROPERTY(DataCell category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(DataCell name READ name WRITE setName NOTIFY nameChanged)

    const DataCell& category() const;
    void setCategory(const DataCell& newCategory);

    const DataCell& name() const;
    void setName(const DataCell& newName);


signals:
    void categoryChanged();
    void nameChanged();

private:
    DataCell m_category;
    DataCell m_name;
};


/**
 * @brief The LogRecord class
 *
 * a single unit of Log data.
 */
class LogRecord : public QObject {
    Q_OBJECT

public:
    explicit LogRecord(QObject* parent = nullptr);
    explicit LogRecord(DataCell subject, DataCell startDate, DataCell endDate, QObject* parent = nullptr);
    explicit LogRecord(const LogRecord& other);
    LogRecord &operator=(const LogRecord& other);
    bool operator==(const LogRecord& other) const;
    bool operator!=(const LogRecord& other) const;

    virtual ~LogRecord();
    Q_PROPERTY(DataCell subject READ subject WRITE setSubject NOTIFY subjectChanged)
    Q_PROPERTY(DataCell startDate READ startDate WRITE setStartDate NOTIFY startDateChanged)
    Q_PROPERTY(DataCell endDate READ endDate WRITE setEndDate NOTIFY endDateChanged)

    const DataCell& subject() const;
    void setSubject(const DataCell& newSubject);

    const DataCell& startDate() const;
    void setStartDate(const DataCell& newStartDate);

    const DataCell& endDate() const;
    void setEndDate(const DataCell& newEndDate);

signals:
    void subjectChanged();
    void startDateChanged();
    void endDateChanged();

private:
    DataCell m_subject;
    DataCell m_startDate;
    DataCell m_endDate;
};

/**
 * @brief The DataStorage class
 */
class DataStorage : public QObject {
    Q_OBJECT
public:
    explicit DataStorage(QObject* parent = nullptr);
    Q_PROPERTY(QList<Subject> subjects READ subjects WRITE setSubjects NOTIFY subjectsChanged)
    Q_PROPERTY(QList<LogRecord> records READ records WRITE setRecords NOTIFY recordsChanged)


    const QList<Subject> &subjects() const;
    void setSubjects(const QList<Subject> &newSubjects);

    const QList<LogRecord> &records() const;
    void setRecords(const QList<LogRecord> &newRecords);

signals:
    void subjectsChanged();
    void recordsChanged();

private:
    QList<Subject> m_subjects;
    QList<LogRecord> m_records;
};

#endif // DATASTORAGE_H
