#ifndef SHADOW_FFI_H
#define SHADOW_FFI_H

#include <stdio.h>
#include <stdlib.h>
#include <ffi.h>
#include <dlfcn.h>

#include <iotjs.h>
#include <iotjs_def.h>
#include <iotjs_binding.h>
#include <iotjs_objectwrap.h>
#include "iotjs_module_buffer.h"

typedef struct {
  ffi_cif *cif;
  ffi_closure *closure;
  void **code_loc;
  jerry_value_t callback;
} sdffi_callback_info_t;

/** MARK: - ffi.c */
void sdffi_copy_string_property(char *dst, jerry_value_t obj, const char *name);
void sdffi_copy_string_value(char *dst, jerry_value_t jval);
/** END MARK: ffi.c */

/** MARK: - iotjs_module_ffi.c */
jerry_value_t wrap_ptr (void *ptr);
void *unwrap_ptr_from_jbuffer(jerry_value_t jbuffer);
/** END MARK: iotjs_module_ffi.c */

/** MARK: - callback_info.c */
void LibFFICallbackInfo(jerry_value_t exports);
/** END MARK: callback_info.c*/

/** MARK: - callback_info.c */
void LibFFITypes(jerry_value_t exports);
/** END MARK: callback_info.c*/

/** MARK: - types.c */
ffi_type* sdffi_str_to_ffi_type_ptr(char *str);
void sdffi_cast_jval_to_pointer(void *ptr, ffi_type *type_ptr, jerry_value_t jval);
/** END MARK: types.c */

#endif /* SHADOW_FFI_H */
