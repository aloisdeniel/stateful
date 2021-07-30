import 'package:flutter/widgets.dart';

import 'ticked.dart';
import 'disposed.dart';

/// An helper widget that instanciate an [AnimationController] and dispose it.
class Animated extends StatelessWidget {
  const Animated({
    Key? key,
    required this.builder,
    this.value,
    this.duration,
    this.reverseDuration,
    this.debugLabel,
    this.lowerBound,
    this.upperBound,
    this.animationBehavior,
  }) : super(key: key);

  final Duration? duration;
  final Duration? reverseDuration;
  final String? debugLabel;
  final double? lowerBound;
  final double? upperBound;
  final double? value;
  final AnimationBehavior? animationBehavior;
  final DisposedWidgetBuilder<AnimationController> builder;

  @override
  Widget build(BuildContext context) {
    return Ticked<AnimationController>(
      initialize: (context, vsync) {
        final result = AnimationController(
          duration: duration,
          animationBehavior: animationBehavior ?? AnimationBehavior.normal,
          debugLabel: debugLabel,
          lowerBound: lowerBound ?? 0.0,
          upperBound: upperBound ?? 1.0,
          reverseDuration: reverseDuration,
          value: value,
          vsync: vsync,
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
