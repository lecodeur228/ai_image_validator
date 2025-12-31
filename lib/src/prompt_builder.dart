String buildPrompt(List<String> allowedClasses) {
  return '''
You are an image verification system.

Analyze the image and return ONLY a valid JSON object.
Do NOT use markdown formatting. Do NOT wrap the JSON in code blocks.
Return raw JSON only.

Allowed classes:
${allowedClasses.join(', ')}

Return this exact JSON format:
{
  "detected_class": "class_name",
  "confidence": 0.95
}

Rules:
- detected_class must be one of the allowed classes, or "unknown"
- confidence must be a number between 0.0 and 1.0
- If the image does not match any allowed class, use "unknown" and set confidence below 0.6
- Return ONLY the JSON object, nothing else
''';
}
