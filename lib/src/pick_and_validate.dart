import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'validator.dart';
import 'models/image_validation_result.dart';

class PickAndValidate {
  static final ImagePicker _picker = ImagePicker();

  static Future<ImageValidationResult?> pick({
    required ImageSource source,
    required List<String> allowedClasses,
    double minConfidence = 0.7,
  }) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile == null) {
      return null; // user cancelled
    }

    final file = File(pickedFile.path);

    return ImageValidator.validate(
      imageFile: file,
      allowedClasses: allowedClasses,
      minConfidence: minConfidence,
    );
  }
}
