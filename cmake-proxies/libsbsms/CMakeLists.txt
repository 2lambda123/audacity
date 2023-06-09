
add_library( ${TARGET} STATIC )

def_vars()

set( SOURCES
   PRIVATE
      ${TARGET_ROOT}/src/buffer.cpp
      ${TARGET_ROOT}/src/dBTable.cpp
      ${TARGET_ROOT}/src/fft.cpp
      ${TARGET_ROOT}/src/grain.cpp
      ${TARGET_ROOT}/src/resample.cpp
      ${TARGET_ROOT}/src/sbsms.cpp
      ${TARGET_ROOT}/src/slide.cpp
      ${TARGET_ROOT}/src/sms.cpp
      ${TARGET_ROOT}/src/subband.cpp
      ${TARGET_ROOT}/src/track.cpp
      ${TARGET_ROOT}/src/trackpoint.cpp
)

set( INCLUDES
   PRIVATE
      ${_PRVDIR}
   PUBLIC
      ${TARGET_ROOT}/include
)

set( OPTIONS
   PRIVATE
      $<$<C_COMPILER_ID:AppleClang,Clang,GNU>:-Wno-enum-compare>
      ${MMX_FLAG}
      ${SSE_FLAG}
)

find_package( Threads )
if( Threads_FOUND AND CMAKE_USE_PTHREADS_INIT )
   set( MULTITHREADED 1 )
endif()

if(NOT APPLE OR MACOS_ARCHITECTURE STREQUAL "x86_64")
   set( ENABLE_SSE ${HAVE_SSE} )
endif()

configure_file( config.h.in private/config.h )

organize_source( "${TARGET_ROOT}" "" "${SOURCES}" )
target_sources( ${TARGET} PRIVATE ${SOURCES} )
target_compile_options( ${TARGET} PRIVATE ${OPTIONS} )
target_include_directories( ${TARGET} PRIVATE ${INCLUDES} )

set_target_properties(${TARGET} PROPERTIES POSITION_INDEPENDENT_CODE On)
