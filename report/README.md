# Rapport LaTeX (français)

Ce dossier contient le rapport du projet Flutter en LaTeX :

- Fichier principal : `report/rapport.tex`
- Les captures d'écran et le logo sont référencés depuis `demo/`.

## Compilation

Depuis la racine du projet (ou depuis `report/`) :

```
cd report
pdflatex rapport.tex
pdflatex rapport.tex  # (optionnel pour rafraîchir la table des matières)
```

Assurez-vous d'avoir une distribution LaTeX installée (ex. MacTeX sur macOS).

## Logo Mundiapolis

Le rapport utilise le logo situé à `demo/logo_mundia.png`.
Si vous souhaitez changer de logo, modifiez la ligne correspondante dans `rapport.tex` ou remplacez l'image.
