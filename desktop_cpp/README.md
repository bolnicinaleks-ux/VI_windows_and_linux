# Vi Desktop (Qt 6 / C++)

Нативное C++ ПК-приложение на **Qt 6 (QML)** для персонального ИИ-ассистента **Vi (Viki)** с динамическими темами оформления в стиле **Windows 11 Fluent Design**.

## Требования к сборке

- Компилятор C++17 (MSVC 2019+, GCC 11+, Clang)
- CMake 3.16+
- Qt 6.2+ (`Core`, `Gui`, `Qml`, `Quick`, `Network`, `QuickControls2`)

---

## Сборка и запуск на Windows (PowerShell)

### 1. Как найти установленный путь Qt 6
В команде конфигурации нужно заменить плейсхолдер `6.x.x` на **реальную версию Qt 6**, установленную у вас в папке `C:\Qt`.
Проверить установленные версии Qt можно в PowerShell:

```powershell
Get-ChildItem C:\Qt\6*
```

Например, если у вас установлена версия `6.7.2` (или `6.8.0`), путь будет:
`C:/Qt/6.7.2/msvc2019_64` (или `llvm-mingw_64` / `mingw_64`).

---

### 2. Сборка через CMake и MSVC

```powershell
# 1. Перейдите в папку проекта
cd desktop_cpp

# 2. Очистите папку build при необходимости
Remove-Item -Recurse -Force build -ErrorAction SilentlyContinue
mkdir build
cd build

# 3. Запустите cmake с УКАЗАНИЕМ РЕАЛЬНОГО ПУТИ К QT 6:
cmake .. -DCMAKE_PREFIX_PATH="C:/Qt/6.7.2/msvc2019_64"

# Если Qt установлен через Qt Online Installer или vcpkg, также можно передать:
# cmake .. -DQt6_DIR="C:/Qt/6.7.2/msvc2019_64/lib/cmake/Qt6"

# 4. Скомпилируйте приложение:
cmake --build . --config Release
```

---

### 3. Запуск приложения

```powershell
.\Release\ViDesktop.exe
```

*Примечание:* Если при запуске выдает ошибку отсутствия DLL, выполните `windeployqt`:
```powershell
C:\Qt\6.7.2\msvc2019_64\bin\windeployqt.exe .\Release\ViDesktop.exe
```
