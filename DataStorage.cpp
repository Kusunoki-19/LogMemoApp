#include "DataStorage.h"

namespace inner {
namespace relationship {

// class Central ----------------------------
Central::Central() { }

Central::~Central()
{
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    for (auto pAccessor : m_pAccessors) {
        if (!pAccessor) {
            continue;
        }
        pAccessor->onDestructCentral();
    }
}

Peripheral* Central::createPeripheral()
{
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    auto pPeripheral = new Peripheral(this, m_pMutex.get());
    m_pAccessors.emplace_back(pPeripheral);
    return pPeripheral;
}

void Central::onDestructPeripheral(Peripheral* pInstance)
{
    std::lock_guard<std::shared_mutex> m_lock(*m_pMutex);
    m_pAccessors.erase(std::remove(m_pAccessors.begin(), m_pAccessors.end(), pInstance), m_pAccessors.end());
}

// class Peripheral ---------------------------
Peripheral::Peripheral(Central* pCentral, std::shared_mutex* pMutex)
    : m_pCentral(pCentral), m_pMutex(pMutex)
{
}

Peripheral::~Peripheral()
{
    if (m_pCentral) {
        m_pCentral->onDestructPeripheral(this);
    }
}

void Peripheral::onDestructCentral()
{
    m_pCentral = nullptr;
}

Central *Peripheral::getCentral()
{
    return m_pCentral;
}




} // namespace relationship.
} // namespace inner.


namespace LogData {

} // namespace LogData
