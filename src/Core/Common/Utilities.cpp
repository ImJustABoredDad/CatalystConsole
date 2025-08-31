#include "Utilities.h"
#include <fstream>
#include <sstream>

namespace Utilities
{
    Result<std::string> ReadFile(const std::string& filename)
    {
        std::ifstream file(filename);
        if (!file.is_open())
        {
            return std::unexpected("Failed to open file: " + std::string(filename));
        }
        
        std::ostringstream buffer;
        buffer << file.rdbuf();
        
        if (file.fail() && !file.eof())
        {
            return std::unexpected("Error reading file: " + std::string(filename));
        }
        
        return buffer.str();
    }
    
    Result<void> WriteFile(const std::string& filename, const std::string& content)
    {
        std::ofstream file(filename);
        if (!file.is_open())
        {
            return std::unexpected("Failed to create file: " + std::string(filename));
        }
        
        file << content;
        
        if (file.fail())
        {
            return std::unexpected("Error writing to file: " + std::string(filename));
        }
        
        return {};
    }
}
