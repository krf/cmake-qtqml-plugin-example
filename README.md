# CMake QML plugin example

Qt example using Qt plugins and QML plugins built using the CMake build system.

## Description

There are good tutorials and examples ([1](http://doc.qt.io/qt-5/qtqml-tutorials-extending-qml-example.html),
[2](https://qt.developpez.com/doc/5.0-snapshot/qmllanguage-modules/), 
[3](http://doc.qt.io/qt-5/qtqml-qmlextensionplugins-example.html)) how to write 
a QML module with qmake but there is not a lot of examples how to do it with CMake.

This project show how to create a basic CMake QML plugin that exports [C++ class](qml/my/plugin/example/myquickitem.h),
[QML file](qml/my/plugin/example/MyQml.qml) and [js file](qml/my/plugin/example/MyScript.js) to QML engine.

## Project structure

Project consists of several main CMake targets:
* [application target](src/CMakeLists.txt) - main application target that will use Qt plugins and QML plugins target.
* [plugin target](plugins/testplugin/CMakeLists.txt) - Qt plugin target that exports a C++ class
* [plugin target](qml/my/plugin/example/CMakeLists.txt) - QML plugin target that exports a C++ class alongside with resources containing QML files
