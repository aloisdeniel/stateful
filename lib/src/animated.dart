import 'package:flutter/widgets.dart';

import 'ticked.dart';
import 'initialized.dart';

/// An helper widget that instanciate an [AnimationController] and dispose it.
class Animated extends StatelessWidget {
  final Duration duration;
  final Duration reverseDuration;
  final String debugLabel;
  final double lowerBound;
  final double upperBound;
  final double value;
  final AnimationBehavior animationBehavior;
  final InitializedWidgetBuilder<AnimationController> builder;
  const Animated({
    Key key,
    this.value,
    this.duration,
    this.reverseDuration,
    this.debugLabel,
    this.lowerBound,
    this.upperBound,
    this.animationBehavior,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ticked<AnimationController>(
      initialize: (context, vsync) => AnimationController(
        duration: duration,
        animationBehavior: animationBehavior ?? AnimationBehavior.normal,
        debugLabel: debugLabel,
        lowerBound: lowerBound ?? 0.0,
        upperBound: upperBound ?? 1.0,
        reverseDuration: reverseDuration,
        value: value,
        vsync: vsync,
      ),
      dispose: (context, controller) => controller.dispose(),
      builder: builder,
    );
  }
}
