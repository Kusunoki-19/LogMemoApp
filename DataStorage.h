#ifndef DATASTORAGE_H
#define DATASTORAGE_H

#include <memory>
#include <shared_mutex>
#include <vector>

namespace LogData {

class Accessor;
class Storage;

class Accessor final {
    friend Storage;

    Accessor(Storage* pStorage);
    virtual ~Accessor();

    void onDestructStorage();

public:
    // access APIs

private:
    Storage* m_pStorage = nullptr;
};

class Storage final {
    friend Accessor;
    explicit Storage();
    virtual ~Storage();

public:
    Accessor* createAccessor();

private:
    void onDestructAccessor(Accessor* pInstance);

    std::shared_ptr<std::shared_mutex> m_pMutex;
    std::vector<Accessor*> m_pAccessors;

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

private:
    std::vector<Subject> m_subjects;
    std::vector<Record> m_records;
};

} // namespace LogData

#endif // DATASTORAGE_H
