import 'package:flutter/widgets.dart';

typedef InitializedInitializer<T> = Disposed<T> Function(
  BuildContext context,
);

typedef InitializedDisposer<T> = void Function();

typedef InitializedWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);

class Disposed<T> {
  final T value;
  final InitializedDisposer<T> dispose;
  const Disposed({
    @required this.value,
    this.dispose,
  });
}

/// A simple wrapper around [StatefulWidget]s that [initialize] a single item from
/// [initState] and [dispose] it.
class Initialized<T> extends StatefulWidget {
  final InitializedInitializer<T> initialize;
  final InitializedWidgetBuilder<T> builder;
  const Initialized({
    Key key,
    this.initialize,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _InitializedState<T> createState() => _InitializedState<T>();
}

class _InitializedState<T> extends State<Initialized<T>> {
  Disposed<T> value;

  @override
  void initState() {
    if (widget.initialize != null) {
      value = widget.initialize(context);
    }
    super.initState();
  }

  @override
  void dispose() {
    value?.dispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value.value);
  }
}
