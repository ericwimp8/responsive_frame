import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('DimensionsConfig', () {
    test(
        'Creating a DimensionsConfig instance with all properties set works correctly',
        () {
      const dimensionsConfig = DimensionsConfig(
        topMaxHeight: 100,
        topMinHeight: 50,
        bodyTopMaxHeight: 200,
        bodyTopMinHeight: 150,
        bodyMaxWidth: 300,
        bodyMinWidth: 250,
        leftEndMaxWidth: 100,
        leftEndMinWidth: 50,
        leftEndFillVertical: true,
        leftEndTopMaxHeight: 150,
        leftEndTopMinHeight: 100,
        rightEndMaxWidth: 100,
        rightEndMinWidth: 50,
        rightEndFillVertical: true,
        rightEndTopMaxHeight: 150,
        rightEndTopMinHeight: 100,
        bodyBottomMaxHeight: 200,
        bodyBottomMinHeight: 150,
        bottomMaxHeight: 100,
        bottomMinHeight: 50,
        bodyAlignment: Alignment.center,
      );

      expect(dimensionsConfig.topMaxHeight, equals(100.0));
      expect(dimensionsConfig.topMinHeight, equals(50.0));
      expect(dimensionsConfig.bodyTopMaxHeight, equals(200.0));
      expect(dimensionsConfig.bodyTopMinHeight, equals(150.0));
      expect(dimensionsConfig.bodyMaxWidth, equals(300.0));
      expect(dimensionsConfig.bodyMinWidth, equals(250.0));
      expect(dimensionsConfig.leftEndMaxWidth, equals(100.0));
      expect(dimensionsConfig.leftEndMinWidth, equals(50.0));
      expect(dimensionsConfig.leftEndFillVertical, isTrue);
      expect(dimensionsConfig.leftEndTopMaxHeight, equals(150.0));
      expect(dimensionsConfig.leftEndTopMinHeight, equals(100.0));
      expect(dimensionsConfig.rightEndMaxWidth, equals(100.0));
      expect(dimensionsConfig.rightEndMinWidth, equals(50.0));
      expect(dimensionsConfig.rightEndFillVertical, isTrue);
      expect(dimensionsConfig.rightEndTopMaxHeight, equals(150.0));
      expect(dimensionsConfig.rightEndTopMinHeight, equals(100.0));
      expect(dimensionsConfig.bodyBottomMaxHeight, equals(200.0));
      expect(dimensionsConfig.bodyBottomMinHeight, equals(150.0));
      expect(dimensionsConfig.bottomMaxHeight, equals(100.0));
      expect(dimensionsConfig.bottomMinHeight, equals(50.0));
      expect(dimensionsConfig.bodyAlignment, equals(Alignment.center));
    });

    test('Merge method merges two DimensionsConfig instances properly', () {
      var config1 = const DimensionsConfig(
        topMaxHeight: 100,
        topMinHeight: 100,
        bodyTopMaxHeight: 100,
        bodyTopMinHeight: 100,
        bodyMaxWidth: 100,
        bodyMinWidth: 100,
        leftEndMaxWidth: 100,
        leftEndMinWidth: 100,
        leftEndFillVertical: true,
        leftEndTopMaxHeight: 100,
        leftEndTopMinHeight: 100,
        rightEndMaxWidth: 100,
        rightEndMinWidth: 100,
        rightEndFillVertical: true,
        rightEndTopMaxHeight: 100,
        rightEndTopMinHeight: 100,
        bodyBottomMaxHeight: 100,
        bodyBottomMinHeight: 100,
        bottomMaxHeight: 100,
        bottomMinHeight: 100,
        bodyAlignment: Alignment.center,
      );

      const config2 = DimensionsConfig(
        topMaxHeight: 200,
        topMinHeight: 200,
        bodyTopMaxHeight: 200,
        bodyTopMinHeight: 200,
        bodyMaxWidth: 200,
        bodyMinWidth: 200,
        leftEndMaxWidth: 200,
        leftEndMinWidth: 200,
        leftEndFillVertical: false,
        leftEndTopMaxHeight: 200,
        leftEndTopMinHeight: 200,
        rightEndMaxWidth: 200,
        rightEndMinWidth: 200,
        rightEndFillVertical: false,
        rightEndTopMaxHeight: 200,
        rightEndTopMinHeight: 200,
        bodyBottomMaxHeight: 200,
        bodyBottomMinHeight: 200,
        bottomMaxHeight: 200,
        bottomMinHeight: 200,
        bodyAlignment: Alignment.bottomCenter,
      );

      final mergedConfig = config1.merge(config2);
      expect(mergedConfig, config1);

      config1 = DimensionsConfig.empty;
      final mergedConfig1 = config1.merge(config2);
      expect(mergedConfig1, config2);
    });

    test(
        'copyWith method creates a new DimensionsConfig instance with updated values',
        () {
      const originalConfig = DimensionsConfig(
        topMaxHeight: 100,
        topMinHeight: 100,
        bodyTopMaxHeight: 100,
        bodyTopMinHeight: 100,
        bodyMaxWidth: 100,
        bodyMinWidth: 100,
        leftEndMaxWidth: 100,
        leftEndMinWidth: 100,
        leftEndFillVertical: true,
        leftEndTopMaxHeight: 100,
        leftEndTopMinHeight: 100,
        rightEndMaxWidth: 100,
        rightEndMinWidth: 100,
        rightEndFillVertical: true,
        rightEndTopMaxHeight: 100,
        rightEndTopMinHeight: 100,
        bodyBottomMaxHeight: 100,
        bodyBottomMinHeight: 100,
        bottomMaxHeight: 100,
        bottomMinHeight: 100,
        bodyAlignment: Alignment.center,
      );

      final updatedConfig = originalConfig.copyWith(
        topMaxHeight: 200,
        topMinHeight: 200,
        bodyTopMaxHeight: 200,
        bodyTopMinHeight: 200,
        bodyMaxWidth: 200,
        bodyMinWidth: 200,
        leftEndMaxWidth: 200,
        leftEndMinWidth: 200,
        leftEndFillVertical: false,
        leftEndTopMaxHeight: 200,
        leftEndTopMinHeight: 200,
        rightEndMaxWidth: 200,
        rightEndMinWidth: 200,
        rightEndFillVertical: false,
        rightEndTopMaxHeight: 200,
        rightEndTopMinHeight: 200,
        bodyBottomMaxHeight: 200,
        bodyBottomMinHeight: 200,
        bottomMaxHeight: 200,
        bottomMinHeight: 200,
        bodyAlignment: Alignment.bottomCenter,
      );

      expect(updatedConfig.topMaxHeight, 200);
      expect(updatedConfig.topMinHeight, 200);
      expect(updatedConfig.bodyTopMaxHeight, 200.0);
      expect(updatedConfig.bodyTopMinHeight, 200);
      expect(updatedConfig.bodyMaxWidth, 200);
      expect(updatedConfig.bodyMinWidth, 200);
      expect(updatedConfig.leftEndMaxWidth, 200);
      expect(updatedConfig.leftEndMinWidth, 200);
      expect(updatedConfig.leftEndFillVertical, isFalse);
      expect(updatedConfig.leftEndTopMaxHeight, 200);
      expect(updatedConfig.leftEndTopMinHeight, 200);
      expect(updatedConfig.rightEndMaxWidth, 200);
      expect(updatedConfig.rightEndMinWidth, 200);
      expect(updatedConfig.rightEndFillVertical, isFalse);
      expect(updatedConfig.rightEndTopMaxHeight, 200);
      expect(updatedConfig.rightEndTopMinHeight, 200);
      expect(updatedConfig.bodyBottomMaxHeight, 200);
      expect(updatedConfig.bodyBottomMinHeight, 200);
      expect(updatedConfig.bottomMaxHeight, 200);
      expect(updatedConfig.bottomMinHeight, 200);
      expect(updatedConfig.bodyAlignment, Alignment.bottomCenter);
    });

    test('Empty constant instance is created correctly', () {
      const dimensionsConfig = DimensionsConfig.empty;

      expect(dimensionsConfig.topMaxHeight, isNull);
      expect(dimensionsConfig.topMinHeight, isNull);
      expect(dimensionsConfig.bodyTopMaxHeight, isNull);
      expect(dimensionsConfig.bodyTopMinHeight, isNull);
      expect(dimensionsConfig.bodyMaxWidth, isNull);
      expect(dimensionsConfig.bodyMinWidth, isNull);
      expect(dimensionsConfig.leftEndMaxWidth, isNull);
      expect(dimensionsConfig.leftEndMinWidth, isNull);
      expect(dimensionsConfig.leftEndFillVertical, isNull);
      expect(dimensionsConfig.leftEndTopMaxHeight, isNull);
      expect(dimensionsConfig.leftEndTopMinHeight, isNull);
      expect(dimensionsConfig.rightEndMaxWidth, isNull);
      expect(dimensionsConfig.rightEndMinWidth, isNull);
      expect(dimensionsConfig.rightEndFillVertical, isNull);
      expect(dimensionsConfig.rightEndTopMaxHeight, isNull);
      expect(dimensionsConfig.rightEndTopMinHeight, isNull);
      expect(dimensionsConfig.bodyBottomMaxHeight, isNull);
      expect(dimensionsConfig.bodyBottomMinHeight, isNull);
      expect(dimensionsConfig.bottomMaxHeight, isNull);
      expect(dimensionsConfig.bottomMinHeight, isNull);
      expect(dimensionsConfig.bodyAlignment, isNull);
    });
  });
}
