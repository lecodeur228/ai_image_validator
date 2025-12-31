# Exemple d'utilisation - AI Image Validator

Cette application montre comment utiliser le package `ai_image_validator` avec une interface personnalisée.

## 🎯 Fonctionnalités

- ✅ Sélection d'image via BottomSheet (caméra ou galerie)
- ✅ Validation avec Gemini AI
- ✅ Messages de succès/erreur avec GetX SnackBar
- ✅ Interface complètement personnalisable
- ✅ Configuration directement dans le code

## 📋 Configuration

### 1. Initialiser le package

```dart
void main() {
  AiImageValidator.initialize(
    apiKey: 'VOTRE_CLE_API_GEMINI',
    model: 'gemini-2.0-flash',
  );
  runApp(const MyApp());
}
```

### 2. Définir vos paramètres dans le code

```dart
// Classes autorisées
final List<String> allowedClasses = ['chat', 'chien', 'oiseau'];

// Seuil de confiance
final double minConfidence = 0.7;
```

### 3. Utiliser le package

```dart
// Sélectionner une image
final imageFile = await AiImageValidator.pickImage(ImageSource.camera);

// Valider l'image
final result = await AiImageValidator.validateImage(
  imageFile: imageFile,
  allowedClasses: allowedClasses,
  minConfidence: minConfidence,
);

// Vérifier le résultat
if (result.isAllowed) {
  print('✅ Image valide: ${result.detectedClass}');
}
```

## 🚀 Lancement

```bash
cd example
flutter pub get
flutter run
```

## 🎨 Personnalisation

L'interface est **100% personnalisable**. Vous contrôlez tout :
- Les couleurs et le design
- La logique de sélection
- Les messages d'erreur/succès
- Les paramètres de validation
