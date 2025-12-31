class ImageValidationResult {
  final String detectedClass;
  final double confidence;
  final bool isAllowed;

  ImageValidationResult({
    required this.detectedClass,
    required this.confidence,
    required this.isAllowed,
  });

  factory ImageValidationResult.fromJson({
    required Map<String, dynamic> json,
    required List<String> allowedClasses,
    required double minConfidence,
  }) {
    final detected = json['detected_class']?.toString() ?? 'unknown';
    final confidence = (json['confidence'] is num)
        ? json['confidence'].toDouble()
        : 0.0;

    final isAllowed =
        allowedClasses.contains(detected) && confidence >= minConfidence;

    return ImageValidationResult(
      detectedClass: detected,
      confidence: confidence,
      isAllowed: isAllowed,
    );
  }
}
