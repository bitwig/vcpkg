#set(ENV{CC} clang-cl)
#set(ENV{CXX} clang-cl)

set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE dynamic)

#set(VCPKG_CXX_FLAGS_RELEASE "/O3 -mfpmath=sse -msse2 -mno-sse4.1 -mno-sse4.2 -mno-sse4a ")
#set(VCPKG_C_FLAGS_RELEASE "/O3 -mfpmath=sse -msse2 -mno-sse4.1 -mno-sse4.2 -mno-sse4a ")

#set(VCPKG_BUILD_TYPE release)
