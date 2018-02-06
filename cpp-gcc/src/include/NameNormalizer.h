#ifndef NAME_NORMALIZER_H
#define NAME_NORMALIZER_H

#include <string>
#include <exception>

#include "StringUtil.h"

namespace name_util {
  class InvalidNameException : public std::exception {};

  std::string normalize(const std::string& name) {
      return "wha?";
  }
}

#endif
