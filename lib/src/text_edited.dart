import 'package:flutter/widgets.dart';

import 'initialized.dart';

/// An helper widget that instanciate an [TextEditingController] and dispose it.
class TextEdited extends StatelessWidget {
  final String text;
  final InitializedWidgetBuilder<TextEditingController> builder;
  const TextEdited({
    Key key,
    this.text = '',
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Initialized<TextEditingController>(
      initialize: (context) => TextEditingController(text: text),
      dispose: (context, controller) => controller.dispose(),
      builder: builder,
    );
  }
}
