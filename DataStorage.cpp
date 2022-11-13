#include "DataStorage.h"

namespace LogData {

// class Accessor ---------------------------
Accessor::Accessor(Storage* pStorage)
    : m_pStorage(pStorage)
{
}

Accessor::~Accessor()
{
    if (m_pStorage) {
        m_pStorage->onDestructAccessor(this);
    }
}

void Accessor::onDestructStorage() { m_pStorage = nullptr; }


// class Storage ----------------------------
Storage::Storage() { }

Storage::~Storage()
{
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    for (auto pAccessor : m_pAccessors) {
        if (!pAccessor) {
            continue;
        }
        pAccessor->onDestructStorage();
    }
}

Accessor* Storage::createAccessor()
{
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    auto pAccessor = new Accessor(this);
    m_pAccessors.emplace_back(pAccessor);
    return pAccessor;
}

void Storage::onDestructAccessor(Accessor* pInstance)
{
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    m_pAccessors.erase(std::remove(m_pAccessors.begin(), m_pAccessors.end(), pInstance), m_pAccessors.end());
}

} // namespace LogData
