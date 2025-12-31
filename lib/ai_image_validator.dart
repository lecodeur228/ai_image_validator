import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'src/gemini_client.dart';
import 'src/validator.dart';
import 'src/models/image_validation_result.dart';

export 'src/models/image_validation_result.dart';
export 'package:image_picker/image_picker.dart' show ImageSource;

class AiImageValidator {
  /// Must be called once before using the package
  static void initialize({
    required String apiKey,
    String model = 'gemini-2.0-flash',
  }) {
    GeminiClient.initialize(apiKey: apiKey, model: model);
  }

  /// Pick image from source (camera or gallery)
  static Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }

  /// Validate an image file with Gemini
  static Future<ImageValidationResult> validateImage({
    required File imageFile,
    required List<String> allowedClasses,
    double minConfidence = 0.7,
  }) {
    return ImageValidator.validate(
      imageFile: imageFile,
      allowedClasses: allowedClasses,
      minConfidence: minConfidence,
    );
  }
}
