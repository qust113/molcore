set(CTEST_PROJECT_NAME "MolCore")
set(CTEST_NIGHTLY_START_TIME "23:59:59 UTC")

set(CTEST_DROP_METHOD "http")
#set(CTEST_DROP_SITE "trunk.cdash.org")
#set(CTEST_DROP_LOCATION "/submit.php?project=MolCore")
# Use the slicer URL for submission for now, bug in CDash processing code.
set(CTEST_DROP_SITE "www.cdash.org")
set(CTEST_DROP_LOCATION "/slicer4/submit.php?project=MolCore")
set(CTEST_DROP_SITE_CDASH TRUE)
