#pragma once

#include "../includes/geode.hpp"

class InterferencesManager {
protected:
    InterferencesManager() = default;
    InterferencesManager(const InterferencesManager&) = delete;
    InterferencesManager(InterferencesManager&&) = delete;

    InterferencesManager& operator=(const InterferencesManager&) = delete;
    InterferencesManager& operator=(InterferencesManager&&) = delete;
    
    bool m_initialized = false;
    std::unordered_map<std::string, bool> m_interferenceStates = {};
    bool m_isEnabled = false; // Is currently disabling interferences
    
    Result<> saveState();
    Result<> loadState();

    void handleInterference(
        const std::string& id,
        bool disableInterference,
        std::function<bool()> isEnabledFn,
        std::function<void(bool)> setEnabledFn
    );

public:
    bool init();

    void toggle(bool enable);

    bool shouldRecordGameplay();
    // TODO: Find a better place for this
    static bool isLevelEligible(GJGameLevel *level);

    static InterferencesManager& get() {
        static InterferencesManager instance;
        return instance;
    }
};