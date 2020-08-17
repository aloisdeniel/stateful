import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'initialized.dart';
import 'ticked.dart';

/// An helper widget that instanciate an [TabController] and dispose it.
class Tabbed extends StatelessWidget {
  final InitializedWidgetBuilder<TabController> builder;
  final int initialIndex;
  final int length;
  const Tabbed({
    Key key,
    this.initialIndex,
    @required this.length,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ticked<TabController>(
      initialize: (context, vsync) {
        final result = TabController(
          initialIndex: initialIndex ?? 0,
          length: length,
          vsync: vsync,
        );
        return Disposed(
          value: result,
          dispose: () => result.dispose(),
        );
      },
      builder: builder,
    );
  }
}
