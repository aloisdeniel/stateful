# Stateful

A set of common stateful widget implementations.

## Usage

### Initialized

```dart
return Initialized<State>(
    initialize: (context) => State(),
    dispose: (context, state) => state.dispose(),
    builder: (context, state) => AnimatedBuilder(
        animation: state,
        builder: (context) => Text(state.value),
    ),
);
```

### Ticked (Initialized with *TickerProviderStateMixin*)

```dart
return Ticked<MyController>(
    initialize: (context, vsync) => MyController(vsync: vsync),
    dispose: (context, controller) => state.dispose(),
    builder: (context, controller) => MyView(
            controller: controller,
        ),
    ),
);
```

### Animated (*~ AnimationController*)

```dart
return Animated(
    duration: const Duration(milliseconds: 200),
    builder: (context, animationController) => MyView(
            controller: controller,
        ),
    ),
);
```

### Scrolled (*~ ScrollController*)

```dart
return Scrolled(
    initialOffset: 100.0,
    builder: (context, scrollController) => ListView(
            controller: controller,
            children: [
                /// ...
            ]
        ),
    ),
);
```

### Tabbed (*~ TabController*)

```dart
return Tabbed(
    initialIndex: 3,
    length: 4,
    builder: (context, tabController) => TabBarView(
        controller: tabController,
        children: [ 
            // ...
        ]
    ),
);
```

### Paged (*~ PageController*)

```dart
return Paged(
    initialPage: 2,
    viewportFraction: 0.6,
    builder: (context, pageController) => PageView(
        controller: pageController,
        children: [ 
            // ...
        ]
    ),
);
```

### TextEdited (*~ TextEditingController*)

```dart
return TextEdited(
    text: 'hello',
    builder: (context, textEditingController) => TextField(
        controller: textEditingController,
        /// ...
    ),
);
```

### Registered (*~ Multiple initializations*)

```dart
final registry = Registry();
final animated = registry.animated(
    duration: const Duration(milliseconds: 200)
);
final textEdited = registry.textEdited(
    text: 'hello',
);
final state = registry.initialized(
    initialize: (context) => State(),
    dispose: (context, state) => state.dispose(),
);

return Registered(
    registry: registry,
    builder: (context, values) => Column(
        children: [
            MyView(
                controller: animated(values),
            ),
            AnimatedBuilder(
                animation: state,
                builder: (context) => Text(state(values).value),
            ),
            TextField(
                controller: textEdited(values),
                /// ...
            ),
        ],
    ),
);
```