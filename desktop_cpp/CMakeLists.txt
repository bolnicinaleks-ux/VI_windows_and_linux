cmake_minimum_required(VERSION 3.16)
project(ViDesktop VERSION 0.6.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick Network QuickControls2)

set(INCLUDE_FILES
    include/models.h
    include/api_client.h
    include/ui_controller.h
    include/win_event_filter.h
)

set(SRC_FILES
    src/main.cpp
    src/api_client.cpp
    src/ui_controller.cpp
)

set(RESOURCES
    qml.qrc
)

add_executable(ViDesktop ${SRC_FILES} ${INCLUDE_FILES} ${RESOURCES})

target_include_directories(ViDesktop PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(ViDesktop PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Network
    Qt6::QuickControls2
)

if(WIN32)
    target_link_libraries(ViDesktop PRIVATE dwmapi user32)
endif()
