#ifndef DATASTORAGE_H
#define DATASTORAGE_H

#include <shared_mutex>
#include <vector>

namespace inner {
namespace relationship {

class Central;
class Peripheral;

/**
 * @brief The Central class
 *
 * Central creates Peripheral instance,
 * and Central is core of Peripheral instances.
 */
class Central {
private:
    friend Peripheral;

    std::vector<Peripheral*> m_pAccessors;
    std::shared_ptr<std::shared_mutex> m_pMutex;

private:
    explicit Central();

    // notify storage dead to Peripheral.
    virtual ~Central();

private:
    // notify from Peripheral.
    void onDestructPeripheral(Peripheral* pInstance);

protected:
    // create new Peripheral.
    Peripheral* createPeripheral();

};

/**
 * @brief The Peripheral class
 *
 * Peripheral
 */
class Peripheral {
protected:
    friend Central;

    Central* m_pCentral = nullptr;
    std::shared_ptr<std::shared_mutex> m_pMutex;

    // created from storage.
    explicit Peripheral(Central* pCentral, std::shared_mutex* pMutex);

protected:
    // notify Peripheral dead to storage.
    virtual ~Peripheral();

private:
    // notify from Central.
    void onDestructCentral();


protected:
    virtual Central* do_getCentral() = 0;

public:
    Central *getCentral() { do_getCentral(); };

};


} // namespace relationship
} // namespace inner


namespace LogData {

class LogAccessor final : inner::relationship::Peripheral {
    explicit LogAccessor();
    virtual ~LogAccessor();
};

class LogStorage final : inner::relationship::Central {
public:
    explicit LogStorage();
    virtual ~LogStorage();

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
