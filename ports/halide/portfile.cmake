vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO halide/Halide
    REF c3641b6850d156aff6bb01a9c01ef475bd069a31 # v13.0.0
    SHA512 9a8e8a1f922babce992e73e7b6567bd338a651a4cc0d411a53ddab6087fa3a4fb4e864be4b36891edefaa80d85750f6c25760f61de75f7e642d1d8ce80d88cbe
    HEAD_REF release/13.x
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        target-aarch64 TARGET_AARCH64
        target-amdgpu TARGET_AMDGPU
        target-arm TARGET_ARM
        target-d3d12compute TARGET_D3D12COMPUTE
        target-hexagon TARGET_HEXAGON
        target-metal TARGET_METAL
        target-mips TARGET_MIPS
        target-nvptx TARGET_NVPTX
        target-opencl TARGET_OPENCL
        target-powerpc TARGET_POWERPC
        target-riscv TARGET_RISCV
        target-x86 TARGET_X86
)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS ${FEATURE_OPTIONS}
        -DWITH_DOCS=NO
        -DWITH_PYTHON_BINDINGS=NO
        -DWITH_TESTS=NO
        -DWITH_TUTORIALS=NO
        -DWITH_UTILS=NO
        -DCMAKE_INSTALL_LIBDIR=bin
        -DCMAKE_INSTALL_DATADIR=share/${PORT}
        -DHalide_INSTALL_CMAKEDIR=share/${PORT}
        -DHalide_INSTALL_HELPERSDIR=share/HalideHelpers
        -DHalide_INSTALL_PLUGINDIR=bin
)

# ADD_BIN_TO_PATH needed to compile autoschedulers, 
# which use Halide.dll (and deps) during the build.
vcpkg_cmake_install(ADD_BIN_TO_PATH)

vcpkg_copy_tools(
    TOOL_NAMES
        featurization_to_sample
        get_host_target
        retrain_cost_model
        weightsdir_to_weightsfile
    AUTO_CLEAN
)

# Release mode MODULE targets in CMake don't get PDBs.
# Exclude those to avoid warning with default globs.
vcpkg_copy_pdbs(
    BUILD_PATHS
        "${CURRENT_PACKAGES_DIR}/bin/Halide.dll" 
        "${CURRENT_PACKAGES_DIR}/debug/bin/*.dll"
)

vcpkg_cmake_config_fixup()
vcpkg_cmake_config_fixup(PACKAGE_NAME HalideHelpers)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/tutorial)

configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
configure_file(${CMAKE_CURRENT_LIST_DIR}/usage ${CURRENT_PACKAGES_DIR}/share/${PORT}/usage COPYONLY)
