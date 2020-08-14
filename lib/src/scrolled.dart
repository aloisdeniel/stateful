import 'package:flutter/widgets.dart';

import 'initialized.dart';

/// An helper widget that instanciate an [ScrollController] and dispose it.
class Scrolled extends StatelessWidget {
  final double initialScrollOffset;
  final bool keepScrollOffset;
  final String debugLabel;
  final InitializedWidgetBuilder<ScrollController> builder;
  const Scrolled({
    Key key,
    this.initialScrollOffset,
    this.keepScrollOffset,
    this.debugLabel,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Initialized<ScrollController>(
      initialize: (context) => ScrollController(
        initialScrollOffset: initialScrollOffset ?? 0.0,
        keepScrollOffset: keepScrollOffset ?? true,
        debugLabel: debugLabel,
      ),
      dispose: (context, controller) => controller.dispose(),
      builder: builder,
    );
  }
}
