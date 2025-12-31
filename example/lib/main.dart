import 'package:flutter/material.dart';
import 'package:ai_image_validator/ai_image_validator.dart';
import 'package:get/get.dart';
import 'dart:io';

void main() {
  // Configuration unique de l'API Gemini
  // IMPORTANT: Remplacez 'YOUR_GEMINI_API_KEY' par votre vraie clé API
  // Obtenez votre clé gratuite sur: https://aistudio.google.com/apikey
  AiImageValidator.initialize(
    apiKey: 'YOUR_GEMINI_API_KEY',
    model: 'gemini-2.0-flash',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI Image Validator Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImageValidatorPage(),
    );
  }
}

class ImageValidatorPage extends StatefulWidget {
  const ImageValidatorPage({super.key});

  @override
  State<ImageValidatorPage> createState() => _ImageValidatorPageState();
}

class _ImageValidatorPageState extends State<ImageValidatorPage> {
  File? _selectedImage;
  ImageValidationResult? _result;
  bool _isLoading = false;

  // Configuration - Le développeur peut modifier ces valeurs
  final List<String> allowedClasses = ['chat', 'chien', 'oiseau'];
  final double minConfidence = 0.7;

  void _showImageSourceSelector() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choisir une source',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Prendre une photo'),
                onTap: () {
                  Get.back();
                  _pickAndValidate(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choisir depuis la galerie'),
                onTap: () {
                  Get.back();
                  _pickAndValidate(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> _pickAndValidate(ImageSource source) async {
    setState(() {
      _isLoading = true;
      _result = null;
      _selectedImage = null;
    });

    try {
      // 1. Sélectionner l'image
      final imageFile = await AiImageValidator.pickImage(source);

      if (imageFile == null) {
        setState(() => _isLoading = false);
        Get.snackbar(
          'Annulé',
          'Aucune image sélectionnée',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          icon: const Icon(Icons.info, color: Colors.white),
          duration: const Duration(seconds: 2),
        );
        return;
      }

      setState(() => _selectedImage = imageFile);

      // 2. Valider l'image avec Gemini
      final result = await AiImageValidator.validateImage(
        imageFile: imageFile,
        allowedClasses: allowedClasses,
        minConfidence: minConfidence,
      );

      setState(() {
        _result = result;
        _isLoading = false;
      });

      // 3. Afficher le résultat
      if (result.isAllowed) {
        Get.snackbar(
          'Validation réussie',
          'Image valide : ${result.detectedClass}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Validation échouée',
          'Classe détectée : ${result.detectedClass} (confiance: ${(result.confidence * 100).toStringAsFixed(0)}%)',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);

      Get.snackbar(
        'Erreur',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        duration: const Duration(seconds: 4),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AI Image Validator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Configuration card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⚙️ Configuration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Elements autorisés: ${allowedClasses.join(", ")}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Confiance minimale: ${(minConfidence * 100).toInt()}%',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Image preview
            if (_selectedImage != null) ...[
              Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.file(
                      _selectedImage!,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (_result != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: _result!.isAllowed
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _result!.isAllowed
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: _result!.isAllowed
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _result!.isAllowed ? 'VALIDE' : 'NON VALIDE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: _result!.isAllowed
                                        ? Colors.green.shade900
                                        : Colors.red.shade900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildResultRow(
                              'Classe détectée',
                              _result!.detectedClass,
                            ),
                            const SizedBox(height: 8),
                            _buildResultRow(
                              'Confiance',
                              '${(_result!.confidence * 100).toStringAsFixed(1)}%',
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Loading indicator
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Validation en cours...'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: _showImageSourceSelector,
              icon: const Icon(Icons.add_a_photo),
              label: const Text('Valider une image'),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
