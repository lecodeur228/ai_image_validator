# 🎥 Comment ajouter votre vidéo à la documentation

## Option 1 : YouTube (Recommandé pour pub.dev)

### Étape 1 : Upload sur YouTube
1. Allez sur [YouTube Studio](https://studio.youtube.com)
2. Cliquez sur "Créer" → "Importer une vidéo"
3. Uploadez votre vidéo
4. Titre suggéré : "AI Image Validator - Flutter Package Demo"
5. Description : "Démonstration du package Flutter ai_image_validator pour la validation d'images avec l'IA Gemini"
6. Tags : flutter, dart, ai, gemini, image-validation, package
7. Publiez en "Public" ou "Non répertorié"

### Étape 2 : Copier le lien
Une fois publiée, copiez le lien de votre vidéo (ex: `https://youtu.be/VOTRE_VIDEO_ID`)

### Étape 3 : Mettre à jour le README.md
Remplacez `VOTRE_LIEN_YOUTUBE` dans le README par votre vrai lien :

```markdown
[![Watch Demo](https://img.shields.io/badge/▶️-Watch_Demo-red?style=for-the-badge&logo=youtube)](https://youtu.be/VOTRE_VIDEO_ID)
```

## Option 2 : GIF Animé (Alternatif)

Si vous préférez un GIF qui s'affiche directement dans le README :

### Étape 1 : Convertir la vidéo en GIF
Utilisez un outil en ligne comme :
- [ezgif.com](https://ezgif.com/video-to-gif)
- [cloudconvert.com](https://cloudconvert.com/mp4-to-gif)

Recommandations :
- Durée : max 10-15 secondes
- Résolution : max 800px de large
- FPS : 10-15 fps
- Taille : < 10 MB

### Étape 2 : Héberger le GIF
1. Créez un dossier `.github` ou `assets` dans votre repo
2. Uploadez le GIF : `demo.gif`
3. Commit et push sur GitHub

### Étape 3 : Ajouter au README
```markdown
## 🎬 Demo

![Demo](https://raw.githubusercontent.com/lecodeur228/ai_image_validator/main/demo.gif)
```

## Option 3 : Screenshots + Lien vidéo

### Créer des screenshots
1. Prenez 2-3 captures d'écran de votre app
2. Créez un dossier `screenshots/` dans le repo
3. Nommez-les : `screenshot1.png`, `screenshot2.png`, etc.

### Ajouter au README
```markdown
## 📸 Screenshots

<p align="center">
  <img src="screenshots/screenshot1.png" width="250" alt="Screenshot 1"/>
  <img src="screenshots/screenshot2.png" width="250" alt="Screenshot 2"/>
  <img src="screenshots/screenshot3.png" width="250" alt="Screenshot 3"/>
</p>

### 🎥 [▶️ Watch Full Demo Video](https://youtu.be/VOTRE_VIDEO_ID)
```

## 📋 Recommandations pour la vidéo

### Contenu idéal :
1. **Introduction** (3-5s) : Logo/titre du package
2. **Installation** (5-10s) : Montrer comment l'ajouter au pubspec.yaml
3. **Initialisation** (5-10s) : Montrer le code d'init
4. **Démonstration** (30-45s) :
   - Sélection d'image depuis galerie
   - Sélection depuis caméra
   - Validation réussie (image valide)
   - Validation échouée (image invalide)
   - Affichage des résultats
5. **Code** (10-15s) : Montrer le code simple
6. **Conclusion** (5s) : Lien vers pub.dev

### Spécifications techniques :
- **Durée** : 60-90 secondes max
- **Résolution** : 1080p (1920x1080) ou 720p (1280x720)
- **Format** : MP4 (pour YouTube) ou MOV
- **Audio** : Musique de fond légère OU voix-off (optionnel)
- **Sous-titres** : Recommandé pour accessibilité

### Outils de montage :
- **Gratuit** : 
  - DaVinci Resolve
  - CapCut
  - iMovie (Mac)
  - OpenShot
- **En ligne** :
  - Clipchamp
  - Canva Video

## 🎨 Template de vidéo

### Textes à afficher :
```
[0:00] AI Image Validator
       Flutter Package

[0:05] Install
       flutter pub add ai_image_validator

[0:10] Initialize with Gemini API

[0:15] Pick & Validate Images

[0:30] Customizable UI

[0:45] Get Started:
       pub.dev/packages/ai_image_validator
```

## ✅ Checklist finale

- [ ] Vidéo créée et éditée
- [ ] Uploadée sur YouTube (public ou non répertorié)
- [ ] Lien copié
- [ ] README.md mis à jour avec le lien
- [ ] (Optionnel) Screenshots ajoutés
- [ ] (Optionnel) GIF créé et ajouté
- [ ] Commit et push sur GitHub
- [ ] Testé que le lien fonctionne

## 💡 Conseils bonus

1. **Thumbnail personnalisé** sur YouTube pour plus d'attrait
2. **Playlist** si vous créez plusieurs vidéos de tutoriels
3. **Description YouTube** avec lien vers pub.dev
4. **Partage** de la vidéo sur les réseaux sociaux

## 📞 Besoin d'aide ?

Si vous avez besoin d'aide pour créer ou éditer la vidéo, n'hésitez pas à demander !
