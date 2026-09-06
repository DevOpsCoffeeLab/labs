#!/usr/bin/env bash
# Lab 01 — Pourquoi un Pod n'est pas un conteneur
# Script de vérification automatique

set -uo pipefail

NAMESPACE="devopscoffeelab-lab01"
POD_NAME="web-with-logger"

PASS=0
FAIL=0

check() {
  local description="$1"
  local condition="$2"
  if eval "$condition" >/dev/null 2>&1; then
    echo "✅ $description"
    PASS=$((PASS + 1))
  else
    echo "❌ $description"
    FAIL=$((FAIL + 1))
  fi
}

echo "🔍 Vérification du Lab 01 — Pods multi-conteneurs"
echo "-------------------------------------------------"

check "kubectl est installé et accessible" \
  "command -v kubectl"

check "Le namespace '$NAMESPACE' existe" \
  "kubectl get namespace $NAMESPACE"

check "Le Pod '$POD_NAME' existe dans le namespace" \
  "kubectl get pod $POD_NAME -n $NAMESPACE"

check "Le Pod est à l'état Running" \
  "[[ \"\$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.status.phase}' 2>/dev/null)\" == 'Running' ]]"

check "Le Pod contient exactement 2 conteneurs" \
  "[[ \"\$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | wc -w)\" -eq 2 ]]"

check "Le conteneur 'web' est présent" \
  "kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | grep -qw web"

check "Le conteneur 'logger' est présent" \
  "kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | grep -qw logger"

check "Un volume 'shared-logs' est déclaré sur le Pod" \
  "kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath='{.spec.volumes[*].name}' 2>/dev/null | grep -qw shared-logs"

echo "-------------------------------------------------"
echo "⏳ Attente de quelques lignes de log côté conteneur 'logger'..."
sleep 6

check "Le fichier de log partagé existe et n'est pas vide (lu depuis 'web')" \
  "kubectl exec -n $NAMESPACE $POD_NAME -c web -- sh -c 'test -s /var/log/shared/access.log'"

echo "-------------------------------------------------"
echo "Résultat : $PASS réussi(s) / $((PASS + FAIL)) test(s)"
echo ""

if [[ $FAIL -eq 0 ]]; then
  echo "🎉 Lab validé ! Le conteneur 'web' peut lire les logs écrits par 'logger'"
  echo "   — la preuve que les deux partagent bien un volume et un cycle de vie,"
  echo "   sans jamais communiquer via le réseau."
  exit 0
else
  echo "🔧 Certains checks échouent encore. Regarde les ❌ ci-dessus et relis"
  echo "   la section 'Étapes' du README si tu es bloqué."
  exit 1
fi
