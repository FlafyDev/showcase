#pragma once

#include "../includes/geode.hpp"
#include "../recorder/recorder.hpp"
#include "../tasks/report_crash_log.hpp"

class CrashLogManager {
protected:
    CrashLogManager() = default;
    CrashLogManager(const CrashLogManager&) = delete;
    CrashLogManager(CrashLogManager&&) = delete;

    CrashLogManager& operator=(const CrashLogManager&) = delete;
    CrashLogManager& operator=(CrashLogManager&&) = delete;
    
    bool m_initialized = false;

    EventListener<ReportCrashLogTask> m_reportCrashLogListener;

public:
    bool init();

    void reportLatestCrashLog();

    static CrashLogManager& get() {
        static CrashLogManager instance;
        return instance;
    }
};

