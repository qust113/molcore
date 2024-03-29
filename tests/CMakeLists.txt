include_directories("${MolCore_SOURCE_DIR}/src"
  "${MolCore_BINARY_DIR}/src")

# find google test
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

include(CheckIncludeFileCXX)
include(CheckCXXSymbolExists)
check_include_file_cxx("gtest/gtest.h" HAVE_GTEST_HPP)
if(HAVE_GTEST_HPP)
  check_cxx_symbol_exists(GTEST_HAS_PTHREAD "gtest/gtest.h" GTEST_HAS_PTHREAD)
  check_cxx_symbol_exists(GTEST_IS_THREADSAFE "gtest/gtest.h" GTEST_IS_THREADSAFE)
endif()

if(GTEST_HAS_PTHREAD)
  message(STATUS "GTest claims it has pthreads, we need to link to it.")
  find_package(Threads)
  set(EXTRA_LINK_LIB ${CMAKE_THREAD_LIBS_INIT})
else()
  set(EXTRA_LINK_LIB "")
endif()

# Specify the name of each test (the Test will be appended where needed).
set(tests
  Atom
  Bond
  Graph
  Molecule
  RingPerceiver
  Variant
  VariantMap
  )

# Build up the source file names.
set(testSrcs "")
foreach(TestName ${tests})
  message(STATUS "Adding ${TestName} test.")
  string(TOLOWER ${TestName} testname)
  list(APPEND testSrcs ${testname}test.cpp)
endforeach()
message(STATUS "Test source files: ${testSrcs}")

# Add a single executable for all of our tests.
add_executable(MolCoreTests ${testSrcs})
target_link_libraries(MolCoreTests MolCore
  ${GTEST_BOTH_LIBRARIES} ${EXTRA_LINK_LIB})

# Now add all of the tests, using the gtest_filter argument so that only those
# cases are run in each test invocation.
foreach(TestName ${tests})
  add_test(NAME "${TestName}Test"
    COMMAND MolCoreTests "--gtest_filter=${TestName}Test.*")
endforeach()
