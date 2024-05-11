import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('FrameConfig', () {
    const dimensions = DimensionsConfig(
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

    const dimensions1 = DimensionsConfig(
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

    final frameConfig = FrameConfig(
      body: Container(),
      top: Container(),
      bodyTop: Container(),
      leftEnd: Container(),
      leftEndTop: Container(),
      rightEnd: Container(),
      rightEndTop: Container(),
      bodyBottom: Container(),
      bottom: Container(),
      dimensions: dimensions,
    );

    const frameConfig1 = FrameConfig(
      body: SizedBox(),
      top: SizedBox(),
      bodyTop: SizedBox(),
      leftEnd: SizedBox(),
      leftEndTop: SizedBox(),
      rightEnd: SizedBox(),
      rightEndTop: SizedBox(),
      bodyBottom: SizedBox(),
      bottom: SizedBox(),
      dimensions: dimensions1,
    );

    test('FrameConfig constructor sets all properties correctly', () {
      final body = Container();
      final top = Container();
      final bodyTop = Container();
      final leftEnd = Container();
      final leftEndTop = Container();
      final rightEnd = Container();
      final rightEndTop = Container();
      final bodyBottom = Container();
      final bottom = Container();

      final frameConfig = FrameConfig(
        body: body,
        top: top,
        bodyTop: bodyTop,
        leftEnd: leftEnd,
        leftEndTop: leftEndTop,
        rightEnd: rightEnd,
        rightEndTop: rightEndTop,
        bodyBottom: bodyBottom,
        bottom: bottom,
        dimensions: dimensions, // ignore: avoid_redundant_argument_values
      );

      expect(frameConfig.body, equals(body));
      expect(frameConfig.top, equals(top));
      expect(frameConfig.bodyTop, equals(bodyTop));
      expect(frameConfig.leftEnd, equals(leftEnd));
      expect(frameConfig.leftEndTop, equals(leftEndTop));
      expect(frameConfig.rightEnd, equals(rightEnd));
      expect(frameConfig.rightEndTop, equals(rightEndTop));
      expect(frameConfig.bodyBottom, equals(bodyBottom));
      expect(frameConfig.bottom, equals(bottom));
      expect(frameConfig.dimensions, equals(dimensions));
    });

    test('FrameConfig merge merges two FrameConfig instances correctly', () {
      final mergedFrameConfig = frameConfig.merge(frameConfig1);
      expect(mergedFrameConfig.body, equals(frameConfig.body));
      expect(mergedFrameConfig.top, equals(frameConfig.top));
      expect(mergedFrameConfig.bodyTop, equals(frameConfig.bodyTop));
      expect(mergedFrameConfig.leftEnd, equals(frameConfig.leftEnd));
      expect(mergedFrameConfig.leftEndTop, equals(frameConfig.leftEndTop));
      expect(mergedFrameConfig.rightEnd, equals(frameConfig.rightEnd));
      expect(mergedFrameConfig.rightEndTop, equals(frameConfig.rightEndTop));
      expect(mergedFrameConfig.bodyBottom, equals(frameConfig.bodyBottom));
      expect(mergedFrameConfig.bottom, equals(frameConfig.bottom));
      expect(mergedFrameConfig.dimensions, equals(frameConfig.dimensions));

      const emptyConfig = FrameConfig.empty;
      final mergedFrameConfig1 = emptyConfig.merge(frameConfig);
      expect(mergedFrameConfig1.body, equals(frameConfig.body));
      expect(mergedFrameConfig1.top, equals(frameConfig.top));
      expect(mergedFrameConfig1.bodyTop, equals(frameConfig.bodyTop));
      expect(mergedFrameConfig1.leftEnd, equals(frameConfig.leftEnd));
      expect(mergedFrameConfig1.leftEndTop, equals(frameConfig.leftEndTop));
      expect(mergedFrameConfig1.rightEnd, equals(frameConfig.rightEnd));
      expect(mergedFrameConfig1.rightEndTop, equals(frameConfig.rightEndTop));
      expect(mergedFrameConfig1.bodyBottom, equals(frameConfig.bodyBottom));
      expect(mergedFrameConfig1.bottom, equals(frameConfig.bottom));
      expect(mergedFrameConfig1.dimensions, equals(frameConfig.dimensions));
    });

    test(
        'copyWith creates a new FrameConfig object with specified properties updated',
        () {
      final updatedConfig = frameConfig.copyWith(
        body: frameConfig1.body,
        top: frameConfig1.top,
        bodyTop: frameConfig1.bodyTop,
        leftEnd: frameConfig1.leftEnd,
        leftEndTop: frameConfig1.leftEndTop,
        rightEnd: frameConfig1.rightEnd,
        rightEndTop: frameConfig1.rightEndTop,
        bodyBottom: frameConfig1.bodyBottom,
        bottom: frameConfig1.bottom,
        dimensions: frameConfig1.dimensions,
      );

      expect(updatedConfig.body, equals(frameConfig1.body));
      expect(updatedConfig.top, equals(frameConfig1.top));
      expect(updatedConfig.bodyTop, equals(frameConfig1.bodyTop));
      expect(updatedConfig.leftEnd, equals(frameConfig1.leftEnd));
      expect(updatedConfig.leftEndTop, equals(frameConfig1.leftEndTop));
      expect(updatedConfig.rightEnd, equals(frameConfig1.rightEnd));
      expect(updatedConfig.rightEndTop, equals(frameConfig1.rightEndTop));
      expect(updatedConfig.bodyBottom, equals(frameConfig1.bodyBottom));
      expect(updatedConfig.bottom, equals(frameConfig1.bottom));
      expect(updatedConfig.dimensions, equals(frameConfig1.dimensions));
    });

    test('toString returns the correct string representation', () {
      const frameConfig = FrameConfig(
        body: Text('Body'),
        top: Text('Top'),
        bodyTop: Text('Body Top'),
        leftEnd: Text('Left End'),
        leftEndTop: Text('Left End Top'),
        rightEnd: Text('Right End'),
        rightEndTop: Text('Right End Top'),
        bodyBottom: Text('Body Bottom'),
        bottom: Text('Bottom'),
        dimensions: dimensions,
      );

      final expectedString =
          'FrameConfig(body: Text("Body"), top: Text("Top"), bodyTop: Text("Body Top"), leftEnd: Text("Left End"), leftEndTop: Text("Left End Top"), rightEnd: Text("Right End"), rightEndTop: Text("Right End Top"), bodyBottom: Text("Body Bottom"), bottom: Text("Bottom"), dimensions: $dimensions)';

      expect(frameConfig.toString(), equals(expectedString));
    });
  });
}
