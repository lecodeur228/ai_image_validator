import 'package:flutter_test/flutter_test.dart';
import 'package:ai_image_validator/ai_image_validator.dart';

void main() {
  group('AiImageValidator', () {
    test('initialize sets up Gemini client', () {
      expect(
        () => AiImageValidator.initialize(
          apiKey: 'test_api_key',
          model: 'gemini-1.5-flash',
        ),
        returnsNormally,
      );
    });
  });

  group('ImageValidationResult', () {
    test('fromJson creates valid result when detection is positive', () {
      final json = {'detected_class': 'chat', 'confidence': 0.95};

      final result = ImageValidationResult.fromJson(
        json: json,
        allowedClasses: ['chat', 'chien'],
        minConfidence: 0.7,
      );

      expect(result.isAllowed, true);
      expect(result.detectedClass, 'chat');
      expect(result.confidence, 0.95);
    });

    test('fromJson creates invalid result when confidence too low', () {
      final json = {'detected_class': 'chat', 'confidence': 0.5};

      final result = ImageValidationResult.fromJson(
        json: json,
        allowedClasses: ['chat', 'chien'],
        minConfidence: 0.7,
      );

      expect(result.isAllowed, false);
      expect(result.detectedClass, 'chat');
      expect(result.confidence, 0.5);
    });

    test('fromJson creates invalid result when class not in allowed list', () {
      final json = {'detected_class': 'oiseau', 'confidence': 0.95};

      final result = ImageValidationResult.fromJson(
        json: json,
        allowedClasses: ['chat', 'chien'],
        minConfidence: 0.7,
      );

      expect(result.isAllowed, false);
      expect(result.detectedClass, 'oiseau');
    });

    test('fromJson handles unknown detection', () {
      final json = {'confidence': 0.0};

      final result = ImageValidationResult.fromJson(
        json: json,
        allowedClasses: ['chat', 'chien'],
        minConfidence: 0.7,
      );

      expect(result.isAllowed, false);
      expect(result.detectedClass, 'unknown');
      expect(result.confidence, 0.0);
    });
  });
}
