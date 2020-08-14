import 'package:flutter/widgets.dart';

typedef InitializedInitializer<T> = T Function(
  BuildContext context,
);

typedef InitializedDisposer<T> = void Function(
  BuildContext context,
  T value,
);

typedef InitializedWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T value,
);

/// A simple wrapper around [StatefulWidget]s that [initialize] a single item from
/// [initState] and [dispose] it.
class Initialized<T> extends StatefulWidget {
  final InitializedInitializer<T> initialize;
  final InitializedWidgetBuilder<T> builder;
  final InitializedDisposer<T> dispose;
  const Initialized({
    Key key,
    this.initialize,
    this.dispose,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _InitializedState<T> createState() => _InitializedState<T>();
}

class _InitializedState<T> extends State<Initialized<T>> {
  T value;

  @override
  void initState() {
    if (widget.initialize != null) {
      value = widget.initialize(context);
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.dispose?.call(context, value);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}
