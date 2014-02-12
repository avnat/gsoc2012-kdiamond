project(kdiamond)

if(NOT COMPILING_KDEGAMES)
        find_package(KDE4 REQUIRED)
        include(KDE4Defaults)
        include(MacroLibrary)
        find_package(KDEGames REQUIRED)

        add_definitions(${QT_DEFINITIONS} ${KDE4_DEFINITIONS})
        add_definitions(-DQT_USE_FAST_CONCATENATION -DQT_USE_FAST_OPERATOR_PLUS)
        include_directories(${QDBUS_INCLUDE_DIRS} ${KDE4_INCLUDES} ${KDEGAMES_INCLUDE_DIRS})
endif(NOT COMPILING_KDEGAMES)

SET(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" ${CMAKE_MODULE_PATH})

add_subdirectory(sounds)
add_subdirectory(themes)

SET(BUILD_QML 0)
SET(BUILD_QWIDGET 1)

find_package(KDE4 REQUIRED)
find_package(KDeclarative REQUIRED)
include(KDE4Defaults)
include(MacroLibrary)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
configure_file(config.h.in ${CMAKE_CURRENT_BINARY_DIR}/config.h @ONLY)

if (BUILD_QML)
 add_subdirectory(src_qml)
 message(BUILD_QML)
endif()
if (BUILD_QWIDGET)
 add_subdirectory(src_qwidget)
 message(BUILD_QWIDGET)
endif()

install(DIRECTORY themes
        DESTINATION ${DATA_INSTALL_DIR}/kdiamond)
