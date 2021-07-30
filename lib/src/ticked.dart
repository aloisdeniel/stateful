import 'package:flutter/widgets.dart';

import 'disposed.dart';

typedef TickedInitializer<T> = DisposedValue<T> Function(
  BuildContext context,
  TickerProvider vsync,
);

/// A simple wrapper around [StatefulWidget]s that [initialize] a single item from
/// [initState] and [dispose] it.
class Ticked<T> extends StatefulWidget {
  final TickedInitializer<T> initialize;
  final DisposedWidgetBuilder<T> builder;
  const Ticked({
    Key? key,
    required this.initialize,
    required this.builder,
  }) : super(key: key);

  @override
  _TickedState<T> createState() => _TickedState<T>();
}

class _TickedState<T> extends State<Ticked<T>> with TickerProviderStateMixin {
  late DisposedValue<T> value;

  @override
  void initState() {
    value = widget.initialize(context, this);

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
