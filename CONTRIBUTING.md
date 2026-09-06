# Contribuer à DevOpsCoffeeLab / Labs

Ce repo suit un workflow Git simple mais strict, inspiré de Git Flow et des Conventional Commits. L'objectif : un historique lisible, et des branches dont le nom dit exactement ce qu'elles font.

## Branches

- `develop` — toujours stable et déployable/utilisable. On n'y commite jamais directement.
- Une branche par fonctionnalité, correction ou contenu, créée depuis `develop` :

| Préfixe | Usage | Exemple |
|---|---|---|
| `feat/` | Nouveau contenu (nouveau lab, nouvelle section) | `feat/lab-02-helm-charts` |
| `fix/` | Correction d'un bug (script, manifest, typo bloquante) | `fix/verify-script-namespace-check` |
| `docs/` | Documentation uniquement (README, commentaires) | `docs/update-prerequisites-lab01` |
| `chore/` | Maintenance (gitignore, CI, réorganisation de fichiers) | `chore/update-gitignore` |
| `refactor/` | Réécriture sans changement de comportement | `refactor/verify-script-lab01` |

**Règle** : le nom après le `/` est en anglais ou français cohérent avec le reste du repo, en kebab-case (mots séparés par des tirets), toujours descriptif.

## Commits

Format [Conventional Commits](https://www.conventionalcommits.org/) :

```
<type>(<scope>): <description>
```

- **type** : `feat`, `fix`, `docs`, `chore`, `refactor`, `test`
- **scope** : la partie du repo concernée (nom du lab, ou `readme`, `gitignore`, etc.)
- **description** : **toujours en anglais**, à l'impératif, minuscule, sans point final

**Règle stricte : les messages de commit sont rédigés en anglais**, même si le reste du repo (README, contenu des labs) est en français. Ça garantit un historique Git cohérent et lisible par n'importe quel outil ou contributeur externe.

Exemples :
```
feat(lab-02-helm): add starter manifest and verification script
fix(lab-01-pods): fix volume path in verify.sh
docs(readme): update available labs table
chore(gitignore): add terraform files
```

Si le commit casse la compatibilité ou change une convention établie, ajoute `!` après le type/scope et explique dans le corps du message :
```
feat(lab-01-pods)!: rename lab namespace for consistency across labs
```

## Workflow complet pour ajouter un nouveau lab

```bash
# 1. Partir de develop à jour
git checkout develop
git pull origin develop

# 2. Créer la branche de fonctionnalité
git checkout -b feat/lab-02-helm-charts

# 3. Travailler, committer par petites étapes cohérentes
git add lab-02-helm-charts/
git commit -m "feat(lab-02-helm): add readme and lab statement"
git commit -m "feat(lab-02-helm): add verification script"

# 4. Pousser la branche
git push -u origin feat/lab-02-helm-charts

# 5. Ouvrir une Pull Request vers develop, se relire, puis merger
```

## Pull Requests

- Une PR = un lab ou une fonctionnalité cohérente, pas un fourre-tout
- Le titre de la PR reprend le format des commits (en anglais) : `feat(lab-02-helm): add helm charts lab`
- Avant de merger, vérifie que le script `verify.sh` du lab fonctionne réellement sur un cluster local
- Squash-merge recommandé si la branche contient beaucoup de petits commits intermédiaires, pour garder l'historique de `develop` propre
