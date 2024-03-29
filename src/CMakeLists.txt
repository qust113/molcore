
set(HEADERS
  atom.h
  bond.h
  graph.h
  molcore.h
  molecule.h
  ringperceiver.h
  variant.h
  variant-inline.h
  variantmap.h
)

set(SOURCES
  atom.cpp
  bond.cpp
  graph.cpp
  molecule.cpp
  ringperceiver.cpp
  variantmap.cpp
)

add_library(MolCore SHARED ${SOURCES})

# Generate an export header for the MolCore library. This handles symbol
# visibility on all platforms using functionality added in CMake 2.8.6.
include(GenerateExportHeader)
generate_export_header(MolCore EXPORT_FILE_NAME molcoreexport.h)
include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_compiler_export_flags(molcore_export_flags)
set_property(TARGET MolCore APPEND
  PROPERTY COMPILE_FLAGS ${molcore_export_flags})
