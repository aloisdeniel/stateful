import 'package:flutter/widgets.dart';

import 'disposed.dart';

/// An helper widget that instanciate an [ScrollController] and dispose it.
class Scrolled extends StatelessWidget {
  final double? initialScrollOffset;
  final bool? keepScrollOffset;
  final String? debugLabel;
  final DisposedWidgetBuilder<ScrollController> builder;
  const Scrolled({
    Key? key,
    this.initialScrollOffset,
    this.keepScrollOffset,
    this.debugLabel,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Disposed<ScrollController>(
      initialize: (context) {
        final result = ScrollController(
          initialScrollOffset: initialScrollOffset ?? 0.0,
          keepScrollOffset: keepScrollOffset ?? true,
          debugLabel: debugLabel,
        );
        return DisposedValue(
          value: result,
          dispose: () => result.dispose(),
        );
      },
      builder: builder,
    );
  }
}
