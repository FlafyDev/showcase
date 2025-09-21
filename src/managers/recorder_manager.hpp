#pragma once

#include "../includes/geode.hpp"
#include "../recorder/recorder.hpp"

class RecorderManager {
protected:
    RecorderManager() = default;
    RecorderManager(const RecorderManager&) = delete;
    RecorderManager(RecorderManager&&) = delete;

    RecorderManager& operator=(const RecorderManager&) = delete;
    RecorderManager& operator=(RecorderManager&&) = delete;
    
    bool m_initialized = false;
    std::unique_ptr<IRecorder> m_recorder;

public:
    bool init();

    std::optional<std::reference_wrapper<IRecorder>> getRecorder() const;

    static RecorderManager& get() {
        static RecorderManager instance;
        return instance;
    }
};
