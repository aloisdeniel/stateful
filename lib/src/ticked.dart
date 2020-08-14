import 'package:flutter/widgets.dart';

import 'initialized.dart';

typedef TickedInitializer<T> = T Function(
  BuildContext context,
  TickerProvider vsync,
);

/// A simple wrapper around [StatefulWidget] with a state that implements [TickerProviderStateMixin].
/// It [initialize] sa single item from [initState] and [dispose] it.
class Ticked<T> extends StatefulWidget {
  final InitializedWidgetBuilder<T> builder;
  final TickedInitializer<T> initialize;
  final InitializedDisposer<T> dispose;
  const Ticked({
    Key key,
    @required this.initialize,
    this.dispose,
    @required this.builder,
  })  : assert(builder != null),
        assert(initialize != null),
        super(key: key);

  @override
  _TickedState<T> createState() => _TickedState<T>();
}

class _TickedState<T> extends State<Ticked<T>> with TickerProviderStateMixin {
  T value;

  @override
  void initState() {
    if (widget.initialize != null) {
      value = widget.initialize(context, this);
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
