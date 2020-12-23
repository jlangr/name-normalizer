#ifndef NAME_NORMALIZER_H
#define NAME_NORMALIZER_H

#include <string>
#include <exception>
#include <sstream>
#include <iostream>
#include <numeric>

#include "StringUtil.h"

namespace name_util {
  class InvalidNameException : public std::exception {};

  std::string lastName(const std::vector<std::string>& parts) {
    return parts.back();
  }

  std::string firstName(const std::vector<std::string>& parts) {
    return parts.front();
  }

  std::string initial(const std::string& name) {
    if (1 == name.length()) return name;

    std::stringstream s;
    s << name[0] << ".";
    return s.str();
  }

  std::string middleInitials(const std::vector<std::string>& parts) {
    std::string initials;
    return std::accumulate(parts.begin() + 1, parts.end() - 1, initials,
        [&](const std::string& buffer, const std::string& part) { 
        return buffer + " " + initial(part); 
     });
  }

  std::string suffixless(const std::string& name) {
    auto i{name.find(',')};
    if (i == std::string::npos) return name;
    return name.substr(0, i);
  }

  std::string suffix(const std::string& name) {
    auto i{name.find(',')};
    if (i == std::string::npos) return "";
    return name.substr(i);
  }

  void throwOnExcessiveCommas(const std::string& name) {
    if (2 == std::count(name.begin(), name.end(), ','))
      throw InvalidNameException();
  }

  std::string normalize(const std::string& name) {
      throwOnExcessiveCommas(name);
      auto parts{stringutil::split(stringutil::trim(suffixless(name)), ' ')};
      if (1 == parts.size())
        return name;

      std::stringstream s;
      s << lastName(parts) << ", " << firstName(parts) << middleInitials(parts) << suffix(name);
      return s.str();
  }
}

#endif
