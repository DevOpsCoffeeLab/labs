# Lab 01 — Pourquoi un Pod n'est pas un conteneur

**DevOpsCoffeeLab** · Niveau : débutant · Durée estimée : 30-45 min

[← Retour à la liste des labs](../README.md)

## Contexte

Un Pod peut contenir plusieurs conteneurs qui partagent le même réseau et le même stockage éphémère. C'est ce qui rend possible le pattern *sidecar* : un conteneur principal fait le travail, un second l'assiste (logs, proxy, synchronisation de fichiers...) sans jamais communiquer via le réseau externe.

Ce lab te fait construire ce pattern de tes propres mains, pour que ce ne soit plus une phrase de documentation mais quelque chose que tu as vu fonctionner.

## Objectifs pédagogiques

À la fin de ce lab, tu sauras expliquer et démontrer :
- [ ] pourquoi deux conteneurs dans un même Pod peuvent partager un fichier sans API ni réseau
- [ ] comment déclarer un volume `emptyDir` et le monter dans plusieurs conteneurs
- [ ] comment inspecter et déboguer un Pod multi-conteneurs avec `kubectl exec` et `kubectl logs -c`

## Prérequis

- Un cluster Kubernetes local fonctionnel : [kind](https://kind.sigs.k8s.io/), [minikube](https://minikube.sigs.k8s.io/) ou Docker Desktop avec Kubernetes activé
- `kubectl` installé et configuré sur ce cluster
- Un terminal bash (Linux, macOS, ou WSL sur Windows)

Vérifie que ton cluster répond avant de commencer :
```bash
kubectl cluster-info
```

## Énoncé

Tu dois créer un Pod nommé `web-with-logger` dans le namespace `devopscoffeelab-lab01`, contenant :

1. Un conteneur **`web`** (image `nginx:1.27-alpine`) qui sert une page web
2. Un conteneur **`logger`** (image `busybox:1.36`) qui écrit une ligne horodatée dans `/var/log/shared/access.log` toutes les 5 secondes
3. Un volume `emptyDir` nommé `shared-logs`, monté sur `/var/log/shared` dans **les deux** conteneurs

Le but : prouver que le conteneur `web` peut lire un fichier écrit par le conteneur `logger`, sans qu'aucun réseau ni API n'intervienne entre eux — uniquement le volume partagé du Pod.

## Étapes

### 1. Crée le namespace

```bash
kubectl create namespace devopscoffeelab-lab01
```

### 2. Complète le manifest

Ouvre `manifests/pod.yaml`. Le conteneur `web` est déjà configuré. Il te reste à compléter la commande du conteneur `logger` (repère les `# TODO`) pour qu'il écrive une ligne dans le fichier de log toutes les 5 secondes.

Indice : une boucle `while true; do ... ; sleep 5; done` en shell fait très bien l'affaire.

### 3. Applique le manifest

```bash
kubectl apply -f manifests/pod.yaml
```

### 4. Vérifie manuellement (optionnel mais recommandé)

```bash
kubectl get pod web-with-logger -n devopscoffeelab-lab01
kubectl exec -n devopscoffeelab-lab01 web-with-logger -c web -- cat /var/log/shared/access.log
```

Si tu vois des lignes de log apparaître côté `web` alors qu'elles sont écrites par `logger`, tu as compris l'essentiel du lab.

### 5. Lance le script de vérification

```bash
chmod +x verify/verify.sh
./verify/verify.sh
```

Le script rejoue automatiquement les vérifications ci-dessus et te donne un rapport clair.

## Si tu es bloqué

Un fichier solution complet est disponible dans `solution/pod-solution.yaml` — mais essaie sérieusement avant d'y jeter un œil. L'objectif n'est pas d'avoir un Pod qui tourne, c'est de comprendre pourquoi il tourne.

## Nettoyage

```bash
kubectl delete namespace devopscoffeelab-lab01
```

---

Un blocage, une question, une suggestion d'amélioration ? Ouvre une issue sur ce repo ou viens en discuter sur [LinkedIn — DevOpsCoffeeLab](https://linkedin.com/company/devopscoffeelab).
