# 🚀 Termux AI APT Repository (`aarch64` / Android)

Repositório **APT nativo** para Termux com pacotes de Inteligência Artificial pré-compilados e otimizados para arquitetura ARM64.

Permite instalar bibliotecas como **Keras 3**, **PyTorch**, **Scikit-Learn** e dependências diretamente com o comando padrão:

```bash
pkg install keras
```

---

## ⚡ Ativação do Repositório (Execute uma única vez)

Para adicionar o repositório ao seu Termux:

```bash
curl -sL https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/main/setup-repo.sh | bash
```

*Ou manualmente:*
```bash
echo "deb [trusted=yes] https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/gh-pages/ ./" > $PREFIX/etc/apt/sources.list.d/w3skersec.list
pkg update
```

---

## 📦 Como Instalar Pacotes no Dia a Dia

Uma vez ativado o repositório, basta usar o `pkg` ou `apt` normalmente:

```bash
# Instala o Keras 3 + PyTorch + ml-dtypes + optree automaticamente:
pkg install keras

# Instala o PyTorch isoladamente:
pkg install torch

# Instala o Scikit-Learn:
pkg install scikit-learn
```

O gerenciador de pacotes do Termux resolverá automaticamente todas as dependências nativas (`libc++`, `python`, `abseil-cpp`) sem precisar compilar nada e sem precisar copiar URLs longas!

---

## 🛠️ Pacotes Disponíveis no Repositório

| Pacote | Comando APT | Versão | Arquitetura | Detalhes |
| :--- | :--- | :--- | :--- | :--- |
| **Keras 3** | `pkg install keras` | `3.15.1` | `all` | Configurado para backend PyTorch nativo |
| **PyTorch** | `pkg install torch` | `2.11.0` | `aarch64` | Patcheado com `patchelf` (`libabsl_base_cpu_detect`) |
| **Scikit-Learn** | `pkg install scikit-learn` | `1.6.1` | `aarch64` | Compilação com suporte a OpenMP 5.1 via Clang |
| **Optree** | `pkg install optree` | `0.20.0` | `aarch64` | Otimização de PyTree para Keras/JAX |
| **ml-dtypes** | `pkg install ml-dtypes` | `0.6.0` | `aarch64` | Tipos numéricos compilados com C++17 / Eigen |

---

## 🧪 Exemplo de Uso do Keras 3 com PyTorch

```python
import os
os.environ["KERAS_BACKEND"] = "torch"

import keras
from keras import layers, models

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

## 🛡️ Vantagens do Servidor APT Nativo
- **Zero URL longa:** Instalação idêntica aos pacotes oficiais do Termux (`pkg install <pacote>`).
- **Resolução automática de dependências:** Ao instalar `keras`, o APT puxa `torch`, `optree` e `ml-dtypes` automaticamente.
- **Gerenciado pelo Dpkg:** Desinstalação limpa com `pkg uninstall keras` ou `apt remove torch`.
- **Hospedagem 100% gratuita no GitHub:** Alta disponibilidade e velocidade através do CDN global.
