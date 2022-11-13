#ifndef DATASTORAGE_H
#define DATASTORAGE_H

#include <QObject>
#include <QVariant>
#include <memory>

#include <shared_mutex>
#include <vector>

class DataStorageAPI : QObject {
  explicit DataStorageAPI(QObject *parent = nullptr) : QObject(parent) {}
  virtual ~DataStorageAPI() {}
  Q_PROPERTY(QList<QVariantMap> subjects READ subjects NOTIFY subjectsChanged)
  Q_PROPERTY(QList<QVariantMap> records READ records NOTIFY recordsChanged)

public:
  const QList<QVariantMap> &subjects() const;
  const QList<QVariantMap> &records() const;

signals:
  void subjectsChanged();
  void recordsChanged();

private:
  QList<QVariantMap> m_subjects;
  QList<QVariantMap> m_records;
};

class DataStorage final {
  explicit DataStorage() {}

  // Access Logics -----------------------------------------------------------
public:
  class Operator final {
    friend DataStorage; // For construction from Storage, allow access.
    explicit Operator(DataStorage *pStorage) : m_pStorage(pStorage) {}
    virtual ~Operator() {}

    void onDestructDataStorage() {
      if (!m_pStorage) {
        return;
      }
      std::lock_guard<std::shared_mutex> m_lock(*m_pStorage->m_pMutex);
      m_pStorage = nullptr;
    }

  public:
    // access APIs

  private:
    DataStorage *m_pStorage = nullptr;
  };

  Operator *createOperator() {
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    auto pOperator = new Operator(this);
    m_pOperators.emplace_back(pOperator);
    return pOperator;
  }

private:
  void onDestructOperator(Operator *pInstance) {
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    m_pOperators.erase(std::remove(m_pOperators.begin(), m_pOperators.end(), pInstance), m_pOperators.end());
  }

public:
  virtual ~DataStorage() {
    for (auto pOperator : m_pOperators) {
      if (!pOperator) {
        continue;
      }
      pOperator->onDestructDataStorage();
    }
  }

private:
  std::shared_ptr<std::shared_mutex> m_pMutex;
  std::vector<Operator *> m_pOperators;

  // Data Structures ---------------------------------------------------------
public:
  struct Subject {
    std::string name;
    std::string category;
  };

  struct RecordTime {
    std::uint16_t year;
    std::uint16_t month;
    std::uint16_t day;
    std::uint16_t hour;
    std::uint16_t min;
  };

  struct Record {
    Subject subject;
    RecordTime startTime;
    RecordTime endTime;
  };

  void addSubject(const Subject &subject) {
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    m_subjects.emplace_back(subject);
  }

private:
  std::vector<Subject> m_subjects;
  std::vector<Record> m_records;
};

#endif // DATASTORAGE_H
