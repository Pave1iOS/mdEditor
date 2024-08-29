# MdEditor

**MdEditor** - это простой текстовый редактор с поддержкой язык разметки Markdown.

В проекте используются следующие шаблоны проектирования:
- DI
- CleanSwift

Для верстки экранов используется верстка на якорях.

## Getting Started

- Установите менеджер недостающих пакетов для macOS Homebrew с помощью команды в терминале 
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Скачайте и установите SwiftLint - утилиту для автоматической проверки Swift-кода

```
brew install swiftlint
```
Скачайте и установите Tuist - инструмент для автоматической кодогенерации проектных файлов и ресурсов проекта, чтобы сделать их типобезопасными в использовании

Перед тем как начать, убедитесь, что у вас установлен Tuist. Можно установить его с помощью Homebrew:

```bash
brew install tuist/tap/tuist
```

Или по инструкции на официальном сайте -- https://docs.tuist.io/documentation/tuist/installation

- Клонируйте репозиторий и выполните

```
tuist fetch
tuist generate
```

## Требования

- Написано на Swift 5;
- Поддерживается версия iOS 14;
- Необходим Xcode 14+;
- SwiftLint;
- Tuist.

## Запуск

Для тестовой сборки возможно использование аргументов, помзволяющих контролировать текущий flow приложения.

- `-enableTesting` -- нужен для уведомления о тестировании и отключает анимацию в UI;
- `-runTodoListFlow` -- старт с TodoListFlow, в обход нормальной работы. Нужен для прохождение UI-тестов TodoListFlow;
- `-runMainFlow` -- запуск MainFlow без прохождения авторизации.

Для внедрения этих аргументов, задайте их в Edit Scheme -> Arguments. Или передайте в тестах как

```swift
let app = XCUIApplication()
app.launchArguments = [LaunchArguments.runTodoListFlow.rawValue]
app.launch()
```
