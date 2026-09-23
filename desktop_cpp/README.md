# Vi Desktop (Qt 6 / C++)

Нативное C++ ПК-приложение на **Qt 6 (QML)** для персонального ИИ-ассистента **Vi (Viki)** с интерфейсом в стиле **Windows 11 Fluent Design**.

## Требования к сборке

- C++17 поддерживаемый компилятор (MSVC 2019+, GCC 11+, Clang)
- CMake 3.16+
- Qt 6.2+ (`Core`, `Gui`, `Qml`, `Quick`, `Network`, `QuickControls2`)

## Сборка и запуск

```bash
cd desktop_cpp
mkdir build
cd build
cmake .. -DCMAKE_PREFIX_PATH="C:/Qt/6.x.x/msvc2019_64"
cmake --build . --config Release
```

Запуск:
- Windows: `./Release/ViDesktop.exe`
- Linux: `./ViDesktop`
