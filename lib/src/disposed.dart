import 'package:flutter/widgets.dart';

typedef DisposedInitializer<T> = DisposedValue<T> Function(
  BuildContext context,
);

typedef DisposedDisposer<T> = void Function();

typedef DisposedWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);

class DisposedValue<T> {
  final T value;
  final DisposedDisposer<T>? dispose;
  const DisposedValue({
    required this.value,
    this.dispose,
  });
}

/// A simple wrapper around [StatefulWidget]s that [initialize] a single item from
/// [initState] and [dispose] it.
class Disposed<T> extends StatefulWidget {
  const Disposed({
    Key? key,
    required this.builder,
    required this.initialize,
  }) : super(key: key);

  final DisposedInitializer<T> initialize;
  final DisposedWidgetBuilder<T> builder;

  @override
  _DisposedState<T> createState() => _DisposedState<T>();
}

class _DisposedState<T> extends State<Disposed<T>> {
  late DisposedValue<T> value;

  @override
  void initState() {
    value = widget.initialize(context);
    super.initState();
  }

  @override
  void dispose() {
    value.dispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value.value);
  }
}
