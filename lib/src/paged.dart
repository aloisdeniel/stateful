import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'disposed.dart';

/// An helper widget that instanciate an [PageController] and dispose it.
class Paged extends StatelessWidget {
  final DisposedWidgetBuilder<PageController> builder;
  final int? initialPage;
  final double? viewportFraction;
  final bool? keepPage;
  const Paged({
    Key? key,
    this.initialPage,
    this.keepPage,
    this.viewportFraction,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Disposed<PageController>(
      initialize: (context) {
        final result = PageController(
          initialPage: initialPage ?? 0,
          keepPage: keepPage ?? true,
          viewportFraction: viewportFraction ?? 1.0,
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
