add_mlir_dialect_library(MLIRSDBM
  SDBM.cpp
  SDBMDialect.cpp
  SDBMExpr.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/SDBM
)
target_link_libraries(MLIRSDBM
  PUBLIC
  MLIRIR
  )
