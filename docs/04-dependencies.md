# Dependency Management Guide - C++ Console Application Template

## Overview

The template includes a **smart dependency helper** that automatically finds libraries without hardcoding paths. This makes your project **open-source friendly** and **easy to set up** on different machines.

---

## Quick Start

### Add a Library in 3 Steps
1. **Uncomment** the example in `scripts/premake/config.lua`
2. **Modify** the library name and options
3. **Regenerate** project files with `.\build.ps1`

```lua
-- In scripts/premake/config.lua, uncomment and modify:
deps.add_library("boost", { name = "boost_system" })
```

---

## Basic Usage

### Simple Library Addition
```lua
-- Automatically finds common library locations
deps.add_library("boost", { name = "boost_system" })
deps.add_library("mysql", { name = "mysqlclient" })
deps.add_library("openssl", { name = "ssl" })
```

### Header-Only Libraries
```lua
-- No compilation needed, just include paths
deps.add_header_only("json", { "C:/json/include", "/usr/include/json" })
deps.add_header_only("spdlog", { "C:/spdlog/include", "/usr/include/spdlog" })
```

### Custom Search Paths
```lua
-- Specify custom locations when needed
deps.add_library("custom_lib", {
    name = "custom",
    find_paths = { "C:/custom/include", "/opt/custom/include" },
    lib_paths = { "C:/custom/lib", "/opt/custom/lib" }
})
```

---

## How It Works

### Automatic Path Detection
The dependency helper searches these common locations:

#### Windows
- `C:/Program Files/[library_name]/include`
- `C:/Program Files/[library_name]/lib`
- `C:/Program Files (x86)/[library_name]/include`
- `C:/Program Files (x86)/[library_name]/lib`
- `C:/libs/[library_name]/include`
- `C:/libs/[library_name]/lib`

#### Linux
- `/usr/include/[library_name]`
- `/usr/local/include/[library_name]`
- `/opt/[library_name]/include`
- `/usr/lib/[library_name]`
- `/usr/local/lib/[library_name]`
- `/opt/[library_name]/lib`

### What Happens When You Call `deps.add_library()`
1. **Searches common paths** automatically
2. **Adds include directories** to your project
3. **Adds library directories** to your project
4. **Links the library** to your executable
5. **Prints what it found** (for debugging)

---

## Common Library Examples

### Boost Libraries
```lua
-- Add multiple Boost components
deps.add_library("boost", { name = "boost_system" })
deps.add_library("boost", { name = "boost_filesystem" })
deps.add_library("boost", { name = "boost_thread" })
deps.add_library("boost", { name = "boost_regex" })
```

### Database Libraries
```lua
-- MySQL
deps.add_library("mysql", { name = "mysqlclient" })

-- PostgreSQL
deps.add_library("postgresql", { name = "pq" })

-- SQLite (header-only)
deps.add_header_only("sqlite", { "C:/sqlite/include", "/usr/include/sqlite3" })
```

### Network Libraries
```lua
-- OpenSSL
deps.add_library("openssl", { name = "ssl" })
deps.add_library("openssl", { name = "crypto" })

-- cURL
deps.add_library("curl", { name = "libcurl" })

-- ZeroMQ
deps.add_library("zeromq", { name = "zmq" })
```

### JSON and Data Processing
```lua
-- RapidJSON (header-only)
deps.add_header_only("rapidjson", { "C:/rapidjson/include", "/usr/include/rapidjson" })

-- nlohmann/json (header-only)
deps.add_header_only("nlohmann", { "C:/json/include", "/usr/include/nlohmann" })

-- YAML-cpp
deps.add_library("yaml-cpp", { name = "yaml-cpp" })
```

### Logging and Utilities
```lua
-- spdlog (header-only)
deps.add_header_only("spdlog", { "C:/spdlog/include", "/usr/include/spdlog" })

-- fmt (header-only)
deps.add_header_only("fmt", { "C:/fmt/include", "/usr/include/fmt" })

-- CLI11 (header-only)
deps.add_header_only("CLI11", { "C:/CLI11/include", "/usr/include/CLI11" })
```

---

## Conditional Dependencies

### Environment-Based Dependencies
```lua
-- Only add MySQL if environment variable is set
if os.getenv("NEED_MYSQL") then
    deps.add_library("mysql", { name = "mysqlclient" })
end

-- Different libraries for different environments
if os.getenv("CI_BUILD") then
    deps.add_library("gtest", { name = "gtest" })
    deps.add_library("gmock", { name = "gmock" })
end
```

### Platform-Specific Dependencies
```lua
-- Windows-specific libraries
filter "system:windows"
    deps.add_library("winhttp", { name = "winhttp" })

-- Linux-specific libraries
filter "system:linux"
    deps.add_library("pthread", { name = "pthread" })
```

---

## Manual Dependency Management

### If You Prefer Manual Control
```lua
-- Add include directories manually
includedirs { 
    "src",
    "C:/external/include",
    "/usr/local/include",
    "third_party/boost/include"
}

-- Add library directories manually
libdirs { 
    "C:/external/lib",
    "/usr/local/lib",
    "third_party/boost/lib"
}

-- Link libraries manually
links { "external_lib", "boost_system", "boost_filesystem" }
```

### When to Use Manual Management
- **Custom build systems** that don't fit the helper
- **Complex dependency chains** that need special handling
- **Platform-specific** libraries with unique requirements
- **Debugging** dependency issues

---

## Troubleshooting Dependencies

### Common Issues

#### 1. "Library not found"
```bash
# Check what paths the helper is searching
deps.print_config()

# Verify the library is installed
# Windows: Check Program Files, Program Files (x86)
# Linux: Check /usr/include, /usr/local/include
```

#### 2. "Linker errors"
- **Check library names** - Some libraries have different names on different platforms
- **Verify library files** - `.lib` files on Windows, `.a` or `.so` files on Linux
- **Check architecture** - Make sure you're using x64 libraries for x64 builds

#### 3. "Include path issues"
- **Verify header locations** - Check that include directories actually contain the headers
- **Check file permissions** - Make sure the directories are readable
- **Verify library installation** - Some libraries need to be built from source

### Debugging Commands
```lua
-- Print current dependency configuration
deps.print_config()

-- Check what libraries are being added
-- The helper prints this information automatically
```

---

## Advanced Dependency Scenarios

### Multiple Library Versions
```lua
-- Use environment variables to select versions
local boost_version = os.getenv("BOOST_VERSION") or "1.82"
deps.add_library("boost", { 
    name = "boost_system",
    find_paths = { "C:/boost/" .. boost_version .. "/include" },
    lib_paths = { "C:/boost/" .. boost_version .. "/lib" }
})
```

### Custom Build Configurations
```lua
-- Different dependencies for different build types
filter "configurations:Debug"
    deps.add_library("debug_lib", { name = "debug_support" })

filter "configurations:Release"
    deps.add_library("release_lib", { name = "release_optimizer" })
```

### Third-Party Package Managers
```lua
-- vcpkg integration example
local vcpkg_root = os.getenv("VCPKG_ROOT")
if vcpkg_root then
    deps.add_library("boost", { 
        name = "boost_system",
        find_paths = { vcpkg_root .. "/installed/x64-windows/include" },
        lib_paths = { vcpkg_root .. "/installed/x64-windows/lib" }
    })
end
```

---

## Related Documentation

- **[SETUP.md](SETUP.md)** - Installation and setup instructions
- **[USAGE.md](USAGE.md)** - How to use and customize the template
- **[STRUCTURE.md](STRUCTURE.md)** - Understanding the project organization
