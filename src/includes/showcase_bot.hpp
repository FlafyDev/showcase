#pragma once
#include "geode.hpp"
#include <gdr/gdr.hpp>

struct ShowcaseBotReplay : public gdr::Replay<ShowcaseBotReplay, gdr::Input<>> {
  uint32_t levelVersion;
  std::string gdVersion;
  std::string modVersion;

  ShowcaseBotReplay() : Replay("ShowcaseBot", 3) {}

  void saveExtension(binary_writer &writer) const override {
    writer << levelVersion;
    writer << gdVersion;
    writer << modVersion;
  }
};
