import 'package:flutter/widgets.dart';

typedef InitializerInitialize = void Function(
  BuildContext context,
);

/// A simple wrapper around [StatefulWidget] which calls its [initialize] callback
/// after the first frame if [afterFirstFrame] is `true`.
class Initializer extends StatefulWidget {
  const Initializer({
    Key? key,
    required this.initialize,
    required this.child,
    this.afterFirstFrame = true,
  }) : super(key: key);

  final InitializerInitialize initialize;
  final Widget child;
  final bool afterFirstFrame;

  @override
  _InitializerState createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  @override
  void initState() {
    if (widget.afterFirstFrame) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        widget.initialize(context);
      });
    } else {
      widget.initialize(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
