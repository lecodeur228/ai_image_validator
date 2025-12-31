# AI Image Validator

[![pub package](https://img.shields.io/pub/v/ai_image_validator.svg)](https://pub.dev/packages/ai_image_validator)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package for validating images using Google's Gemini AI. Easily verify if images match specific classes with customizable confidence thresholds.

## 🎥 Demo

[![Watch Demo](https://img.shields.io/badge/▶️-Watch_Demo-red?style=for-the-badge&logo=youtube)](https://youtube.com/shorts/Mh787H-E0ig)

See the package in action: image selection, AI validation, and result display.

## ✨ Features

- 🤖 **AI-Powered Validation**: Uses Google's Gemini AI for accurate image classification
- 📸 **Image Selection**: Built-in support for camera and gallery
- 🎯 **Customizable Classes**: Define your own list of allowed image classes
- ⚙️ **Confidence Threshold**: Set minimum confidence levels for validation
- 🎨 **Fully Customizable UI**: Create your own interface, the package handles only the logic
- ⚡ **Simple API**: Easy to integrate with just a few lines of code

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ai_image_validator: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🔑 Getting Started

### 1. Get a Gemini API Key

1. Visit [Google AI Studio](https://aistudio.google.com/apikey)
2. Create a new API key (it's free!)
3. Copy your API key

### 2. Initialize the Package

```dart
import 'package:ai_image_validator/ai_image_validator.dart';

void main() {
  // Initialize once at app startup
  AiImageValidator.initialize(
    apiKey: 'YOUR_GEMINI_API_KEY',
    model: 'gemini-2.0-flash', // Optional, this is the default
  );
  
  runApp(MyApp());
}
```

## 🚀 Usage

### Basic Example

```dart
import 'package:ai_image_validator/ai_image_validator.dart';
import 'dart:io';

// 1. Pick an image
final File? imageFile = await AiImageValidator.pickImage(
  ImageSource.gallery, // or ImageSource.camera
);

if (imageFile != null) {
  // 2. Validate the image
  final ImageValidationResult result = await AiImageValidator.validateImage(
    imageFile: imageFile,
    allowedClasses: ['cat', 'dog', 'bird'],
    minConfidence: 0.7,
  );

  // 3. Check the result
  if (result.isAllowed) {
    print('✅ Valid image: ${result.detectedClass}');
    print('Confidence: ${result.confidence}');
  } else {
    print('❌ Invalid image');
  }
}
```

### Complete Example with Custom UI

```dart
import 'package:flutter/material.dart';
import 'package:ai_image_validator/ai_image_validator.dart';
import 'dart:io';

class ImageValidatorPage extends StatefulWidget {
  @override
  _ImageValidatorPageState createState() => _ImageValidatorPageState();
}

class _ImageValidatorPageState extends State<ImageValidatorPage> {
  File? _image;
  ImageValidationResult? _result;
  bool _isLoading = false;

  // Configure your validation parameters
  final List<String> allowedClasses = ['cat', 'dog', 'bird'];
  final double minConfidence = 0.7;

  Future<void> _validateImage(ImageSource source) async {
    setState(() => _isLoading = true);

    try {
      // Pick image
      final imageFile = await AiImageValidator.pickImage(source);
      
      if (imageFile == null) {
        setState(() => _isLoading = false);
        return;
      }

      // Validate image
      final result = await AiImageValidator.validateImage(
        imageFile: imageFile,
        allowedClasses: allowedClasses,
        minConfidence: minConfidence,
      );

      setState(() {
        _image = imageFile;
        _result = result;
        _isLoading = false;
      });

      // Show result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.isAllowed 
              ? '✅ Valid: ${result.detectedClass}'
              : '❌ Invalid image',
          ),
          backgroundColor: result.isAllowed ? Colors.green : Colors.red,
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Image Validator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) Image.file(_image!, height: 200),
            if (_result != null) ...[
              Text('Class: ${_result!.detectedClass}'),
              Text('Confidence: ${(_result!.confidence * 100).toInt()}%'),
              Text(_result!.isAllowed ? '✅ Valid' : '❌ Invalid'),
            ],
            if (_isLoading) CircularProgressIndicator(),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _validateImage(ImageSource.gallery),
              icon: Icon(Icons.photo_library),
              label: Text('Pick from Gallery'),
            ),
            ElevatedButton.icon(
              onPressed: () => _validateImage(ImageSource.camera),
              icon: Icon(Icons.camera_alt),
              label: Text('Take Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 📖 API Reference

### `AiImageValidator.initialize()`

Initializes the Gemini AI client. Must be called once before using the package.

**Parameters:**
- `apiKey` (String, required): Your Gemini API key
- `model` (String, optional): Gemini model to use (default: 'gemini-2.0-flash')

```dart
AiImageValidator.initialize(
  apiKey: 'YOUR_API_KEY',
  model: 'gemini-2.0-flash',
);
```

### `AiImageValidator.pickImage()`

Opens the device's image picker to select an image.

**Parameters:**
- `source` (ImageSource, required): Either `ImageSource.camera` or `ImageSource.gallery`

**Returns:** `Future<File?>` - The selected image file, or null if cancelled

```dart
final File? image = await AiImageValidator.pickImage(ImageSource.gallery);
```

### `AiImageValidator.validateImage()`

Validates an image using Gemini AI.

**Parameters:**
- `imageFile` (File, required): The image file to validate
- `allowedClasses` (List<String>, required): List of valid image classes
- `minConfidence` (double, optional): Minimum confidence threshold (default: 0.7)

**Returns:** `Future<ImageValidationResult>`

```dart
final result = await AiImageValidator.validateImage(
  imageFile: imageFile,
  allowedClasses: ['cat', 'dog', 'bird'],
  minConfidence: 0.7,
);
```

### `ImageValidationResult`

The result object returned by `validateImage()`.

**Properties:**
- `detectedClass` (String): The class detected by the AI
- `confidence` (double): Confidence level (0.0 - 1.0)
- `isAllowed` (bool): Whether the image is valid (class is in allowedClasses and confidence >= minConfidence)

```dart
print(result.detectedClass); // e.g., "cat"
print(result.confidence);    // e.g., 0.95
print(result.isAllowed);     // e.g., true
```

## 💡 Use Cases

- **Profile Picture Validation**: Ensure users upload appropriate profile photos
- **Product Image Verification**: Validate that uploaded images match product categories
- **Content Moderation**: Filter images based on specific categories
- **Document Verification**: Check if uploaded images are valid documents
- **Animal/Pet Recognition**: Verify pet images for pet-related apps
- **Food Classification**: Validate food images for recipe or restaurant apps

## 🎨 Customization

This package provides **only the core validation logic**. You have complete freedom to:

- Design your own UI/UX
- Implement custom image pickers
- Add your own loading states
- Create custom error handling
- Integrate with state management (GetX, Provider, Bloc, etc.)

See the [example](example/) folder for a complete implementation with GetX, BottomSheet, and SnackBar.

## ⚙️ Requirements

- Flutter SDK: >=3.10.0
- Dart SDK: >=3.10.4
- Google Gemini API key (free at [Google AI Studio](https://aistudio.google.com/apikey))

## 🔒 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 📱 Permissions

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### iOS

Add to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to select images</string>
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Credits

- Powered by [Google Gemini AI](https://ai.google.dev/)
- Uses [image_picker](https://pub.dev/packages/image_picker) for image selection
- Uses [google_generative_ai](https://pub.dev/packages/google_generative_ai) for AI integration

## 📞 Support

- 🐛 [Report bugs](https://github.com/lecodeur228/ai_image_validator/issues)
- 💡 [Request features](https://github.com/lecodeur228/ai_image_validator/issues)
- 📧 Email: your-email@example.com

## 🌟 Show Your Support

If this package helped you, please ⭐️ the repo and share it with others!
