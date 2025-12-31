# Instructions pour ajouter votre vidéo

Votre vidéo (3 MB) peut être hébergée directement sur GitHub !

## 📝 Étapes

1. **Copiez votre vidéo dans le dossier demo/** :
   ```bash
   cp /chemin/vers/votre/video.mp4 demo/demo.mp4
   ```

2. **Ajoutez et commitez** :
   ```bash
   git add demo/demo.mp4
   git commit -m "Add demo video"
   git push
   ```

3. **C'est tout !** La vidéo apparaîtra automatiquement dans le README sur GitHub et pub.dev

## 🎬 Format recommandé

- Nom du fichier : `demo.mp4` (déjà configuré dans le README)
- Durée : 30-90 secondes
- Résolution : 720p ou 1080p
- Format : MP4 (H.264)

## ✅ Vérification

Après le push, la vidéo sera visible à :
- https://github.com/lecodeur228/ai_image_validator (page du README)
- pub.dev/packages/ai_image_validator (page du package)

La vidéo se lira directement dans le navigateur, avec des contrôles play/pause ! 🎉
