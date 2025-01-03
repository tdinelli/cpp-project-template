# List containing the options activated during the configuration of the CMake project
set(PROGRAM_OPTIONS)

# Testing
option(BUILD_TEST "Build the c++ tests for the library. Rquires: GTest" OFF)

# CPP CHECK
option(CPP_CHECK "Activate static  analysis check using cppcheck" OFF)

# Documentation
option(BUILD_DOCUMENTATION "Automatically build the documentation. Requires Doxygen" OFF)
