-- Simple Dependency Helper for C++ Console Application Template
-- This module provides a simple way to add external libraries without hardcoding paths
-- 
-- USAGE EXAMPLES:
-- 
-- 1. Add a simple library (automatically finds common locations):
--    deps.add_library("boost", { name = "boost_system" })
-- 
-- 2. Add a library with custom search paths:
--    deps.add_library("mysql", {
--        name = "mysqlclient",
--        find_paths = { "C:/mysql/include", "/usr/include/mysql" },
--        lib_paths = { "C:/mysql/lib", "/usr/lib" }
--    })
-- 
-- 3. Add a header-only library:
--    deps.add_header_only("json", { "C:/json/include", "/usr/include/json" })
-- 
-- 4. Add a library only when needed (conditional):
--    if os.getenv("NEED_MYSQL") then
--        deps.add_library("mysql", { name = "mysqlclient" })
--    end

local deps = {}

-- Common library search paths for different platforms
local common_paths = {
    windows = {
        include = { "C:/Program Files", "C:/Program Files (x86)", "C:/libs" },
        lib = { "C:/Program Files", "C:/Program Files (x86)", "C:/libs" }
    },
    linux = {
        include = { "/usr/include", "/usr/local/include", "/opt" },
        lib = { "/usr/lib", "/usr/local/lib", "/opt" }
    }
}

-- Get platform-specific common paths
function deps.get_common_paths()
    if os.target() == "windows" then
        return common_paths.windows
    else
        return common_paths.linux
    end
end

-- Add a library with automatic path detection
function deps.add_library(name, options)
    options = options or {}
    
    -- Set default values
    local lib_name = options.name or name
    local find_paths = options.find_paths or {}
    local lib_paths = options.lib_paths or {}
    
    -- Add common paths to search
    local common = deps.get_common_paths()
    for _, path in ipairs(common.include) do
        table.insert(find_paths, path .. "/" .. name .. "/include")
        table.insert(find_paths, path .. "/" .. name)
    end
    
    for _, path in ipairs(common.lib) do
        table.insert(lib_paths, path .. "/" .. name .. "/lib")
        table.insert(lib_paths, path .. "/" .. name)
    end
    
    -- Add include directories
    includedirs(find_paths)
    
    -- Add library directories
    libdirs(lib_paths)
    
    -- Link the library
    links(lib_name)
    
    -- Print what we're doing (for debugging)
    print("Added library: " .. name .. " (" .. lib_name .. ")")
    print("  Include paths: " .. table.concat(find_paths, ", "))
    print("  Library paths: " .. table.concat(lib_paths, ", "))
end

-- Add a header-only library
function deps.add_header_only(name, paths)
    paths = paths or {}
    
    -- Add common paths
    local common = deps.get_common_paths()
    for _, path in ipairs(common.include) do
        table.insert(paths, path .. "/" .. name .. "/include")
        table.insert(paths, path .. "/" .. name)
    end
    
    -- Add include directories
    includedirs(paths)
    
    print("Added header-only library: " .. name)
    print("  Include paths: " .. table.concat(paths, ", "))
end

-- Add a library only if environment variable is set
function deps.add_if_needed(env_var, name, options)
    if os.getenv(env_var) then
        deps.add_library(name, options)
        return true
    end
    return false
end

-- Add a header-only library only if environment variable is set
function deps.add_header_if_needed(env_var, name, paths)
    if os.getenv(env_var) then
        deps.add_header_only(name, paths)
        return true
    end
    return false
end

-- Print current dependency configuration
function deps.print_config()
    print("=== Dependency Configuration ===")
    print("Platform: " .. os.target())
    print("Common paths:")
    local common = deps.get_common_paths()
    print("  Include: " .. table.concat(common.include, ", "))
    print("  Library: " .. table.concat(common.lib, ", "))
    print("================================")
end

return deps
