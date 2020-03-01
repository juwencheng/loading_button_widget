# loading_button_widget

A new Flutter package project.

## Getting Started

```dart
Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: LoadingButtonWidget(
    title: "保存",
    color: Colors.brown,
    height: 44,
    onTap: () async {
        await Future.delayed(Duration(seconds: 2));
        // _incrementCounter();
        },
    ),
),
```
