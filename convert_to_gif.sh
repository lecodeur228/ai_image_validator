#!/bin/bash

# Script pour convertir la vidéo en GIF optimisé

echo "🎬 Conversion de la vidéo en GIF..."

# Vérifier si ffmpeg est installé
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ ffmpeg n'est pas installé"
    echo "📦 Installation avec Homebrew:"
    echo "   brew install ffmpeg"
    exit 1
fi

# Convertir la vidéo en GIF optimisé
ffmpeg -i demo/demo.mp4 \
  -vf "fps=10,scale=600:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
  -loop 0 \
  demo/demo.gif

echo "✅ GIF créé : demo/demo.gif"
echo "📊 Taille du fichier:"
ls -lh demo/demo.gif
