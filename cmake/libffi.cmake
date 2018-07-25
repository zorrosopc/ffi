set(LIB_FFI_PRODUCT_NAME libffi.a)

if (LIBFFI_MODULE_TYPE STREQUAL "SHARED")
  if (CMAKE_SYSTEM_NAME MATCHES Darwin)
    set(LIB_FFI_PRODUCT_NAME libffi.dylib)
  else()
    set(LIB_FFI_PRODUCT_NAME libffi.so)
  endif()
else()
  set(LIBFFI_MODULE_TYPE STATIC)
endif()

if (NOT LIBFFI_LINK_EXTERNAL)
  ExternalProject_Add(ffi
    PREFIX deps/libffi
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/deps/libffi
    BUILD_IN_SOURCE 0
    BINARY_DIR deps/libffi
    INSTALL_COMMAND
      ${CMAKE_COMMAND} -E copy
      ${CMAKE_BINARY_DIR}/deps/libffi/${LIB_FFI_PRODUCT_NAME}
      ${CMAKE_BINARY_DIR}/lib/
    CMAKE_ARGS
      -DCMAKE_TOOLCHAIN_ROOT=${CMAKE_TOOLCHAIN_ROOT}
      -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
      -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
      -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
      -DOS=${TARGET_OS}
      -DCMAKE_EXTERNAL_SYSTEM_PROCESSOR=${CMAKE_EXTERNAL_SYSTEM_PROCESSOR}
      -DLIBFFI_MODULE_TYPE=${LIBFFI_MODULE_TYPE}
  )

  add_library(libffi ${LIBFFI_MODULE_TYPE} IMPORTED)
  add_dependencies(libffi ffi)
  set_property(TARGET libffi PROPERTY
    IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/lib/${LIB_FFI_PRODUCT_NAME})
endif()
