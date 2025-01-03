# -----------------------------------------------------------------------------
# Preliminary Settings
# -----------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.20)

project(
  PROJECT_NAME
  DESCRIPTION ""
  LANGUAGES CXX)

# Set module path in order to use custom CMake modules
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# ----------------------------------------------------------------------------
# Operating system
# ----------------------------------------------------------------------------
# Detect operating system and define SYSTEM macros
message(STATUS "We are on a ${CMAKE_SYSTEM_NAME} system")
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  set(SYSTEM_DEFINITIONS SYSTEM_LINUX)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
  set(SYSTEM_DEFINITIONS SYSTEM_DARWIN)
elseif(CMAKE_SYSTEM_NAME STREQUAL "AIX")
  set(SYSTEM_DEFINITIONS SYSTEM_AIX)
elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
  set(SYSTEM_DEFINITIONS SYSTEM_WINDOWS)
endif()

# Apply system-specific definitions to the target
if(SYSTEM_DEFINITIONS)
  message(STATUS "System definition: ${SYSTEM_DEFINITIONS}")
endif()

# ----------------------------------------------------------------------------
# Sub Modules auto-update Require git.
# ----------------------------------------------------------------------------
# Not sure if mantain that cause inside this specific project we are handling the dependencies
# through conda forge include(${CMAKE_MODULE_PATH}/UpdateSubmodules.cmake)

# ----------------------------------------------------------------------------
# Compiler options
# ----------------------------------------------------------------------------
include(CompilerOptions)

# ----------------------------------------------------------------------------
# Options
# ----------------------------------------------------------------------------
include(${CMAKE_MODULE_PATH}/Options.cmake)

# ----------------------------------------------------------------------------
# Compulsory libraries
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Source Tree
# ----------------------------------------------------------------------------
# set(INCLUDE_DIRS ${PROJECT_SOURCE_DIR}/include)
# add_subdirectory(source)

# ----------------------------------------------------------------------------
# Documentation Require Doxygen: https://www.doxygen.nl/
# ----------------------------------------------------------------------------
if(BUILD_DOCUMENTATION)
  find_package(Doxygen REQUIRED dot OPTIONAL_COMPONENTS mscgen dia)
  if(DOXYGEN_FOUND)
    add_subdirectory(docs)
  else()
    message(STATUS "Doxygen not found, not building docs")
  endif()
endif()

# ----------------------------------------------------------------------------
# Testing Rquire GTest framework, this is automatically downloaded by the project.
# ----------------------------------------------------------------------------
if(BUILD_TESTS)
  include(CTest)
  include(${CMAKE_MODULE_PATH}/GTest.cmake)
  add_subdirectory(${PROJECT_SOURCE_DIR}/tests/cxx)
endif()

# ----------------------------------------------------------------------------
# CPP CHECK static analyzer Rquire CPP check static analyzer: https://cppcheck.sourceforge.io/
# ----------------------------------------------------------------------------
if(ENABLE_CPPCHECK)
  include(${CMAKE_MODULE_PATH}/CppCheck.cmake)
endif()

# ----------------------------------------------------------------------------
# Tooling for immediate testing
# ----------------------------------------------------------------------------
