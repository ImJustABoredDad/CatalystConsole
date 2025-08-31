-- Premake configuration for C++ Console Application Template
-- Supports Windows and Linux builds

-- Load dependency helper (optional - only needed when adding external libraries)
-- local deps = require("deps")

workspace "Catalyst - Console"
    location "../../build"
    configurations { "Debug", "Release" }
    platforms { "x64", "x86" }
    
    -- Set default configuration
    defaultplatform "x64"
    
    -- C++ standard
    cppdialect "C++23"
    
    -- Output directories
    targetdir "../../build/bin/%{cfg.buildcfg}/%{cfg.platform}"
    objdir "../../build/obj/%{cfg.buildcfg}/%{cfg.platform}"
    
    -- Common compiler flags
    filter "configurations:Debug"
        defines { "DEBUG", "_DEBUG" }
        symbols "On"
        optimize "Off"
        
    filter "configurations:Release"
        defines { "NDEBUG" }
        symbols "Off"
        optimize "On"
        
    -- Platform-specific settings
    filter "system:windows"
        defines { "WIN32", "_WIN32", "_WIN32_WINNT=0x0601" }
        
    filter "system:linux"
        defines { "LINUX", "_LINUX" }
        
    -- Common project settings
    filter {}
        warnings "Extra"
        flags { "MultiProcessorCompile" }
        
    -- Smart parallel build optimization
    -- Auto-detect CPU cores and optimize build performance
    local function get_optimal_job_count()
        local cpu_cores = os.getenv("NUMBER_OF_PROCESSORS")
        if cpu_cores then
            local cores = tonumber(cpu_cores)
            -- Use cores - 1 for stability, minimum 1, maximum 8
            return math.max(1, math.min(cores - 1, 8))
        end
        -- Fallback for Linux or if detection fails
        return 2
    end
    
    -- Store optimal job count for build scripts
    _OPTIMAL_JOBS = get_optimal_job_count()

project "Catalyst - Console"
    kind "ConsoleApp"
    language "C++"
    
    -- Source files
    files { 
        "../../src/**.cpp",
        "../../src/**.h",
        "../../src/**.hpp"
    }
    
    -- Include directories
    includedirs { 
        "../../src"
    }
    
    -- DEPENDENCY EXAMPLES (uncomment and modify as needed):
    -- 
    -- 1. Add a simple library (automatically finds common locations):
    -- deps.add_library("boost", { name = "boost_system" })
    -- 
    -- 2. Add a library with custom search paths:
    -- deps.add_library("mysql", {
    --     name = "mysqlclient",
    --     find_paths = { "C:/mysql/include", "/usr/include/mysql" },
    --     lib_paths = { "C:/mysql/lib", "/usr/lib" }
    -- })
    -- 
    -- 3. Add a header-only library:
    -- deps.add_header_only("json", { "C:/json/include", "/usr/include/json" })
    -- 
    -- 4. Add a library only when needed (conditional):
    -- if os.getenv("NEED_MYSQL") then
    --     deps.add_library("mysql", { name = "mysqlclient" })
    -- end
    -- 
    -- 5. Print dependency configuration (for debugging):
    -- deps.print_config()
    
    -- Platform-specific libraries
    filter "system:windows"
        systemversion "latest"
        
    filter "system:linux"
        links { "pthread" }
        
    -- Platform-specific parallel build optimizations
    filter "system:windows"
        -- MSVC parallel compilation (already handled by MultiProcessorCompile flag)
        buildoptions { "/MP" }  -- Explicit parallel flag
        
    filter "system:linux"
        -- GCC/Clang parallel compilation
        buildoptions { "-j" .. _OPTIMAL_JOBS }
        
    -- Platform-specific settings
    filter "platforms:x64"
        defines { "PLATFORM_X64" }
        
    filter "platforms:x86"
        defines { "PLATFORM_X86" }
        
    -- Debug configuration
    filter "configurations:Debug"
        defines { "DEBUG", "_DEBUG" }
        
    -- Release configuration  
    filter "configurations:Release"
        defines { "NDEBUG" }
