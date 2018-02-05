#ifndef STRING_UTIL_H
#define STRING_UTIL_H

#include <string>
#include <vector>
#include <algorithm>
#include <cctype>

namespace stringutil {
    // See http://stackoverflow.com/questions/236129/split-a-string-in-c
    inline std::vector<std::string> split(const std::string& text, char sep) {
        std::vector<std::string> tokens;
        size_t start = 0, end = 0;
        while ((end = text.find(sep, start)) != std::string::npos) {
            tokens.push_back(text.substr(start, end - start));
            start = end + 1;
        }
        tokens.push_back(text.substr(start));
        return tokens;
    }

    // See http://stackoverflow.com/questions/216823/whats-the-best-way-to-trim-stdstring
    inline std::string trim(const std::string &s) {
//        auto isSpace = [](int i){ return std::isspace(i); };
        auto frontOfWhitespace = std::find_if_not(s.begin(), s.end(), isspace);
        return std::string(
            frontOfWhitespace,
            std::find_if_not(
                s.rbegin(),
                std::string::const_reverse_iterator(frontOfWhitespace), isspace).base());
    }
}

#endif
