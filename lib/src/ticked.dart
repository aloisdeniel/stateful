import 'package:flutter/widgets.dart';

import 'initialized.dart';

typedef TickedInitializer<T> = Disposed<T> Function(
  BuildContext context,
  TickerProvider vsync,
);

/// A simple wrapper around [StatefulWidget]s that [initialize] a single item from
/// [initState] and [dispose] it.
class Ticked<T> extends StatefulWidget {
  final TickedInitializer<T> initialize;
  final InitializedWidgetBuilder<T> builder;
  const Ticked({
    Key key,
    this.initialize,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _TickedState<T> createState() => _TickedState<T>();
}

class _TickedState<T> extends State<Ticked<T>> with TickerProviderStateMixin {
  Disposed<T> value;

  @override
  void initState() {
    if (widget.initialize != null) {
      value = widget.initialize(context, this);
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
