# DevOpsCoffeeLab — Labs

Des labs pratiques pour apprendre Kubernetes, Helm, ArgoCD et l'IaC en manipulant de vrais clusters — pas en cochant des cases de QCM.

Chaque lab est indépendant : un énoncé, un manifest de départ à compléter, un script de vérification automatique, et une solution de référence en dernier recours.

## Labs disponibles

| # | Lab | Thème | Niveau |
|---|-----|-------|--------|
| 01 | [Pods vs conteneurs](./lab-01-pods-vs-containers) | Kubernetes — Pods multi-conteneurs | Débutant |

*(cette table grandit à chaque nouveau lab publié)*

## Comment utiliser un lab

1. Va dans le dossier du lab qui t'intéresse
2. Lis son `README.md` — chaque lab a son propre contexte, ses objectifs et ses prérequis
3. Complète les fichiers marqués `# TODO`
4. Lance le script `verify/verify.sh` du lab pour valider ton travail automatiquement
5. Si tu es bloqué, la solution de référence est dans le dossier `solution/` — mais essaie sérieusement avant

## Convention de structure

Chaque lab suit la même organisation :

```
lab-XX-nom-du-lab/
├── README.md              # contexte, objectifs, étapes
├── manifests/              # fichiers de départ avec des TODO
├── verify/
│   └── verify.sh           # script de vérification automatique
└── solution/                # solution de référence
```

## Prérequis généraux

- `kubectl` configuré sur un cluster local ([kind](https://kind.sigs.k8s.io/), [minikube](https://minikube.sigs.k8s.io/), ou Docker Desktop)
- Pour les futurs labs Helm/ArgoCD : `helm` et/ou `argocd` CLI installés (précisé lab par lab)

## Contribuer / workflow de développement

Ce repo suit une convention de branches et de commits stricte. Voir [CONTRIBUTING.md](./CONTRIBUTING.md) pour le détail complet.

## Une question, un bug, une idée de lab ?

Ouvre une issue sur ce repo, ou viens en discuter sur [LinkedIn — DevOpsCoffeeLab](https://linkedin.com/company/devopscoffeelab).
