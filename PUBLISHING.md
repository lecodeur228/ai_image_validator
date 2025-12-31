# Publishing to pub.dev

Guide pour publier le package `ai_image_validator` sur pub.dev.

## ✅ Checklist avant publication

### 1. Documentation
- [x] README.md complet avec exemples
- [x] CHANGELOG.md avec l'historique des versions
- [x] LICENSE (MIT)
- [x] Exemple fonctionnel dans le dossier `example/`

### 2. pubspec.yaml
- [x] Description claire et concise (< 180 caractères)
- [x] Version correcte (1.0.0)
- [x] Homepage/repository/issue_tracker configurés
- [x] Dépendances à jour

### 3. Code
- [x] Code formatté (`dart format .`)
- [x] Aucune erreur (`flutter analyze`)
- [x] Tests fonctionnels

## 📝 Étapes de publication

### 1. Vérifier le package

```bash
cd /Users/techpastor/Documents/flutter/ai_image_validator
flutter pub publish --dry-run
```

Cette commande vérifie que tout est en ordre sans publier réellement.

### 2. Corriger les éventuels problèmes

Si la commande précédente signale des problèmes :
- Corriger les erreurs mentionnées
- Relancer `flutter pub publish --dry-run`

### 3. Publier le package

```bash
flutter pub publish
```

Vous serez invité à :
1. Confirmer la publication
2. Vous authentifier avec votre compte Google
3. Autoriser pub.dev à accéder à votre compte

### 4. Vérifier sur pub.dev

Une fois publié, votre package sera disponible sur :
https://pub.dev/packages/ai_image_validator

## 🔧 Avant de publier

### Formater le code

```bash
dart format .
```

### Analyser le code

```bash
flutter analyze
```

### Tester l'exemple

```bash
cd example
flutter pub get
flutter run
```

## 📋 Checklist finale

- [ ] README.md est clair et complet
- [ ] CHANGELOG.md liste toutes les nouveautés
- [ ] LICENSE est présent (MIT)
- [ ] pubspec.yaml contient description, homepage, repository
- [ ] Version suit le format semver (1.0.0)
- [ ] Code formatté avec `dart format`
- [ ] Aucune erreur avec `flutter analyze`
- [ ] Exemple fonctionne correctement
- [ ] `flutter pub publish --dry-run` réussit

## 🎯 Après publication

### Mise à jour du README

Ajoutez le badge de version dans README.md :
```markdown
[![pub package](https://img.shields.io/pub/v/ai_image_validator.svg)](https://pub.dev/packages/ai_image_validator)
```

### Promouvoir le package

- Partager sur les réseaux sociaux
- Poster sur Reddit (r/FlutterDev)
- Écrire un article de blog
- Créer une vidéo de démonstration

## 🔄 Futures mises à jour

Pour publier une nouvelle version :

1. Modifier le code
2. Mettre à jour CHANGELOG.md
3. Incrémenter la version dans pubspec.yaml
   - Patch: 1.0.1 (corrections de bugs)
   - Minor: 1.1.0 (nouvelles fonctionnalités)
   - Major: 2.0.0 (breaking changes)
4. Relancer `flutter pub publish`

## 📞 Support

Si vous rencontrez des problèmes :
- [Documentation pub.dev](https://dart.dev/tools/pub/publishing)
- [Guide Flutter](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#publish)
- [Support pub.dev](https://pub.dev/help)
