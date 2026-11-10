#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# Termux AI & Data Science Installer
# Repositório: https://github.com/W3skerSec/termux-ai-wheels
# Descrição: Instala PyTorch, Scikit-Learn, Keras 3, Pandas, Matplotlib no Termux
# ==============================================================================

set -e

echo "=================================================="
echo "  Instalador de Inteligência Artificial para Termux"
echo "  Autor: W3skerSec"
echo "=================================================="

# 1. Dependências do sistema Termux
echo "[1/4] Instalando dependências de sistema..."
pkg install -y python python-pip matplotlib patchelf git

# 2. Releases URL base
RELEASE_TAG="v1.0.0"
BASE_URL="https://github.com/W3skerSec/termux-ai-wheels/releases/download/${RELEASE_TAG}"

TMP_WHEELS_DIR="$PREFIX/tmp/termux-ai-wheels"
mkdir -p "$TMP_WHEELS_DIR"
cd "$TMP_WHEELS_DIR"

# 3. Baixando wheels pré-compiladas
echo "[2/4] Baixando wheels pré-compiladas (ARM64 / Android)..."

WHEELS=(
  "ml_dtypes-0.6.0-cp314-cp314-android_24_arm64_v8a.whl"
  "optree-0.20.0-cp314-cp314-android_24_arm64_v8a.whl"
  "scikit_learn-1.6.1-cp314-cp314-android_24_arm64_v8a.whl"
  "torch-2.11.0-cp314-cp314-android_aarch64.whl"
)

for whl in "${WHEELS[@]}"; do
  if [ ! -f "$whl" ]; then
    echo "  → Baixando $whl..."
    curl -L -o "$whl" "${BASE_URL}/${whl}"
  fi
done

# 4. Instalando wheels
echo "[3/4] Instalando wheels..."
pip install --no-deps *.whl

# 5. Instalando dependências auxiliares e Keras 3
echo "[4/4] Instalando Keras 3, Pandas, OpenPyXL e utilitários..."
pip install absl-py namex joblib threadpoolctl openpyxl pandas
pip install --no-deps keras

# Limpeza dos temporários
rm -rf "$TMP_WHEELS_DIR"

echo "=================================================="
echo "  Instalação concluída com sucesso!"
echo "  Testando o ambiente..."
echo "=================================================="

KERAS_BACKEND=torch python3 -c "
import torch
import sklearn
import keras
import pandas as pd
import matplotlib
print(f'  ✓ PyTorch     : {torch.__version__}')
print(f'  ✓ Scikit-Learn: {sklearn.__version__}')
print(f'  ✓ Keras 3     : {keras.__version__} (backend: {keras.backend.backend()})')
print(f'  ✓ Pandas      : {pd.__version__}')
print(f'  ✓ Matplotlib  : {matplotlib.__version__}')
"

echo "=================================================="
echo "Ambiente pronto para rodar modelos de IA no Termux!"
