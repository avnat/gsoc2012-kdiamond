include_directories(
  ${CMAKE_SOURCE_DIR}
  ${CMAKE_BINARY_DIR}
  ${KDE4_INCLUDES}
  ${KDECLARATIVE_INCLUDE_DIR}
)

# Insert your sources here
set(kdiamond_SRCS
    main.cpp
    mainwindow.cpp
    board.cpp
    ../src_common/game-state.cpp
)

SET(kdiamond_RCCS qmlfiles.qrc)

kde4_add_kcfg_files(kdiamond_SRCS ../src_common/settings.kcfgc)

# generate rules for building source files from the resources
QT4_ADD_RESOURCES(kdiamond_RCC_SRCS ${kdiamond_RCCS})

kde4_add_executable(kdiamond ${kdiamond_SRCS}  ${kdiamond_RCC_SRCS})

# Link against the needed libraries
target_link_libraries(kdiamond
  ${QT_QTDECLARATIVE_LIBRARY}
  ${KDE4_KDEUI_LIBS}
  ${KDECLARATIVE_LIBRARIES}
)

install(TARGETS kdiamond RUNTIME DESTINATION ${INSTALL_TARGETS_DEFAULT_ARGS})
install(FILES kdiamond.kcfg DESTINATION ${DATA_INSTALL_DIR}/kdiamond)

macro_display_feature_log()
