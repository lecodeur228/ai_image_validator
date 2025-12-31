import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiClient {
  static GenerativeModel? _model;

  static void initialize({required String apiKey, required String model}) {
    _model = GenerativeModel(model: model, apiKey: apiKey);
  }

  static GenerativeModel get model {
    if (_model == null) {
      throw Exception(
        'AiImageValidator not initialized. '
        'Call AiImageValidator.initialize() first.',
      );
    }
    return _model!;
  }
}
