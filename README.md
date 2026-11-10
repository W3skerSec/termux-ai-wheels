# 🚀 Termux AI & Data Science Wheels (`aarch64` / Android)

Repositório de pacotes Python pré-compilados e otimizados para **Android / Termux (aarch64)** rodando **Python 3.14+**.

Essas bibliotecas não estão disponíveis no repositório padrão do Termux nem possuem wheels oficiais no PyPI para Android aarch64. Todas foram compiladas nativamente via **LLVM/Clang** com suporte a **OpenMP** e corrigidas via **patchelf** para total compatibilidade com o sistema Termux.

---

## 📦 Pacotes Inclusos no Release v1.0.0

| Pacote | Versão | Arquitetura | Detalhes |
| :--- | :--- | :--- | :--- |
| **PyTorch** (`torch`) | `2.11.0` | `android_aarch64` | Corrigido com `patchelf` (`libabsl_base_cpu_detect.so`) |
| **Scikit-Learn** | `1.6.1` | `android_24_arm64_v8a` | Compilação nativa com OpenMP 5.1 via Clang |
| **ml_dtypes** | `0.6.0` | `android_24_arm64_v8a` | Compilado com Eigen / C++17 |
| **optree** | `0.20.0` | `android_24_arm64_v8a` | Suporte a estruturas de árvore para Keras/JAX |
| **Keras 3** | `3.15.1` | Universal (`py3-none-any`) | Configurado para rodar com backend **PyTorch** |

---

## ⚡ Instalação Rápida (1 Comando)

Para instalar todo o ambiente (PyTorch + Scikit-Learn + Keras 3 + Pandas + Matplotlib) em qualquer Termux:

```bash
curl -sL https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/main/install.sh | bash
```

---

## 🛠️ Instalação Manual das Wheels

Caso queira baixar ou instalar apenas um pacote específico diretamente dos Releases:

```bash
# PyTorch 2.11.0
pip install https://github.com/W3skerSec/termux-ai-wheels/releases/download/v1.0.0/torch-2.11.0-cp314-cp314-android_aarch64.whl

# Scikit-Learn 1.6.1
pip install https://github.com/W3skerSec/termux-ai-wheels/releases/download/v1.0.0/scikit_learn-1.6.1-cp314-cp314-android_24_arm64_v8a.whl

# Dependências do Keras 3
pip install https://github.com/W3skerSec/termux-ai-wheels/releases/download/v1.0.0/optree-0.20.0-cp314-cp314-android_24_arm64_v8a.whl
pip install https://github.com/W3skerSec/termux-ai-wheels/releases/download/v1.0.0/ml_dtypes-0.6.0-cp314-cp314-android_24_arm64_v8a.whl
pip install --no-deps keras
```

---

## 🧪 Como usar Keras 3 com backend PyTorch

Basta definir a variável de ambiente `KERAS_BACKEND=torch`:

```python
import os
os.environ["KERAS_BACKEND"] = "torch"

import keras
from keras import layers, models

# Modelo Sequential clássico
model = models.Sequential([
    layers.Input(shape=(1,)),
    layers.Dense(64, activation="relu"),
    layers.Dense(32, activation="relu"),
    layers.Dense(1, activation="sigmoid")
])

model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])
print(f"Keras {keras.__version__} rodando com backend {keras.backend.backend()} no Termux!")
```

---

## 🛡️ Sem Symlinks, Sem Gambiarras
- Não requer symlinks no `$PREFIX/lib` que quebram com `pkg upgrade`.
- Usa a toolchain LLVM/Clang nativa do Termux.
- Totalmente compatível com as atualizações de sistema.
