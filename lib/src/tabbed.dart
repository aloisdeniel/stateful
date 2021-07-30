import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'disposed.dart';
import 'ticked.dart';

/// An helper widget that instanciate an [TabController] and dispose it.
class Tabbed extends StatelessWidget {
  final DisposedWidgetBuilder<TabController> builder;
  final int initialIndex;
  final int length;
  const Tabbed({
    Key? key,
    this.initialIndex = 0,
    required this.length,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ticked<TabController>(
      initialize: (context, vsync) {
        final result = TabController(
          initialIndex: initialIndex,
          length: length,
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
