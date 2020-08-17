import 'package:flutter/material.dart';
import 'package:stateful/stateful.dart';

extension RegistryExtensions on Registry {
  RegistryEntry<AnimationController> animated<T>({
    Duration duration,
    Duration reverseDuration,
    AnimationBehavior animationBehavior,
    String debugLabel,
    double lowerBound,
    double upperBound,
    double value,
  }) {
    return this.ticked(
      (context, vsync) {
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
        return Disposed(
          value: result,
          dispose: () => result.dispose(),
        );
      },
    );
  }

  RegistryEntry<TextEditingController> textEdited<T>({
    String text,
  }) {
    return this.initialized(
      (context) {
        final result = TextEditingController(text: text);
        return Disposed(
          value: result,
          dispose: () => result.dispose(),
        );
      },
    );
  }

  RegistryEntry<PageController> paged<T>({
    int initialPage,
    bool keepPage,
    double viewportFraction,
  }) {
    return this.initialized(
      (context) {
        final result = PageController(
          initialPage: initialPage ?? 0,
          keepPage: keepPage ?? true,
          viewportFraction: viewportFraction ?? 1.0,
        );
        return Disposed(
          value: result,
          dispose: () => result.dispose(),
        );
      },
    );
  }

  RegistryEntry<TabController> tabbed<T>({
    @required int length,
    int initialIndex,
  }) {
    return this.ticked((context, vsync) {
      final result = TabController(
        initialIndex: initialIndex ?? 0,
        length: length,
        vsync: vsync,
      );
      return Disposed(
        value: result,
        dispose: () => result.dispose(),
      );
    });
  }

  RegistryEntry<ScrollController> scrolled<T>({
    double initialScrollOffset,
    bool keepScrollOffset,
    String debugLabel,
  }) {
    return this.initialized((context) {
      final result = ScrollController(
        initialScrollOffset: initialScrollOffset ?? 0.0,
        keepScrollOffset: keepScrollOffset ?? true,
        debugLabel: debugLabel,
      );
      return Disposed(
        value: result,
        dispose: () => result.dispose(),
      );
    });
  }
}
