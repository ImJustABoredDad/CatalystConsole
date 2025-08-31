#pragma once

#include <string>
#include <expected>

namespace Utilities
{
    // C++23 std::expected for error handling
    template<typename T>
    using Result = std::expected<T, std::string>;
    
    // File operations using std::expected
    Result<std::string> ReadFile(const std::string& filename);
    Result<void> WriteFile(const std::string& filename, const std::string& content);
}
