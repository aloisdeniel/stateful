import 'package:flutter/widgets.dart';

import 'disposed.dart';

/// An helper widget that instanciate an [TextEditingController] and dispose it.
class TextEdited extends StatelessWidget {
  final String text;
  final DisposedWidgetBuilder<TextEditingController> builder;
  const TextEdited({
    Key? key,
    this.text = '',
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Disposed<TextEditingController>(
      initialize: (context) {
        final result = TextEditingController(text: text);
        return DisposedValue(
          value: result,
          dispose: () => result.dispose(),
        );
      },
      builder: builder,
    );
  }
}
