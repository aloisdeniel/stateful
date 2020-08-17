import 'package:flutter/widgets.dart';
import 'package:stateful/stateful.dart';

import 'initialized.dart';

class Registry {
  final List<RegistryEntry> _entries = [];

  RegistryEntry<T> initialized<T>({
    InitializedInitializer<T> initialize,
    InitializedDisposer<T> dispose,
  }) {
    assert(initialize != null);
    final initializer = RegistryInitialized<T>(
      initialize: initialize,
      dispose: dispose,
      key: _entries.length + 1,
    );
    _entries.add(initializer);
    return initializer;
  }

  RegistryEntry<T> ticked<T>({
    TickedInitializer<T> initialize,
    InitializedDisposer<T> dispose,
  }) {
    assert(initialize != null);
    final initializer = RegistryTicked<T>(
      initialize: initialize,
      dispose: dispose,
      key: _entries.length + 1,
    );
    _entries.add(initializer);
    return initializer;
  }
}

abstract class RegistryEntry<T> {
  final int key;
  Type get type => T;
  const RegistryEntry(this.key);
  T call(RegistryValues values) => values.values[key];
}

class RegistryInitialized<T> extends RegistryEntry<T> {
  final InitializedInitializer<T> initialize;
  final InitializedDisposer<T> dispose;
  const RegistryInitialized({
    int key,
    @required this.initialize,
    this.dispose,
  })  : assert(initialize != null),
        assert(key != null),
        super(key);
}

class RegistryTicked<T> extends RegistryEntry<T> {
  final TickedInitializer<T> initialize;
  final InitializedDisposer<T> dispose;
  const RegistryTicked({
    int key,
    @required this.initialize,
    this.dispose,
  })  : assert(initialize != null),
        assert(key != null),
        super(key);
}

class RegistryValues {
  final Registry registry;
  final Map<int, dynamic> values;

  RegistryValues({
    @required this.values,
    @required Registry registry,
  }) : this.registry = registry;
}

typedef Widget WidgetRegistryBuilder(
  BuildContext context,
  RegistryValues values,
);

class Registered extends StatefulWidget {
  final Registry registry;
  final WidgetRegistryBuilder builder;
  const Registered({
    Key key,
    @required this.builder,
    @required this.registry,
  })  : assert(builder != null),
        assert(registry != null),
        super(key: key);

  @override
  _RegisteredState createState() =>
      registry._entries.any((x) => x is RegistryTicked)
          ? _RegisteredTickedState()
          : _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  Registry registry;
  RegistryValues values;

  Map<int, dynamic> initializeValues() {
    final values = <int, dynamic>{};
    for (var entry in registry._entries) {
      if (entry is RegistryInitialized) {
        values[entry.key] = entry.initialize(context);
      }
    }
    return values;
  }

  @override
  void initState() {
    registry = widget.registry;
    values = RegistryValues(
      values: initializeValues(),
      registry: registry,
    );
    super.initState();
  }

  @override
  void dispose() {
    for (var entry in registry._entries) {
      final value = entry(values);
      if (entry is RegistryInitialized && entry.dispose != null) {
        entry.dispose(context, value);
      } else if (entry is RegistryTicked && entry.dispose != null) {
        entry.dispose(context, value);
      }
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(Registered oldWidget) {
    if (widget.registry._entries.length != registry._entries.length) {
      throw Exception(
          'The registry should has the same entries from one build to another');
    }

    for (var i = 0; i < oldWidget.registry._entries.length; i++) {
      final newEntry = widget.registry._entries[i];
      final oldEntry = registry._entries[i];
      if (newEntry.runtimeType != oldEntry.runtimeType) {
        throw Exception(
            'The registry should has the same entries from one build to another. The entry ${oldEntry.key} was a ${oldEntry.runtimeType}, and is now a ${newEntry.runtimeType}.');
      }
      if (newEntry.type != oldEntry.type) {
        throw Exception(
            'The registry should has the same entries from one build to another. The entry ${oldEntry.key} was of type ${oldEntry.type}, and is now of type ${newEntry.type}.');
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, values);
  }
}

class _RegisteredTickedState extends _RegisteredState
    with TickerProviderStateMixin {
  @override
  Map<int, dynamic> initializeValues() {
    final values = super.initializeValues();

    for (var entry in registry._entries) {
      if (entry is RegistryTicked) {
        values[entry.key] = entry.initialize(context, this);
      }
    }

    return values;
  }
}
