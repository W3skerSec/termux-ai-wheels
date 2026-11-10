<div align="center">

<img src="https://img.shields.io/badge/Termux-000000?style=for-the-badge&logo=gnometerminal&logoColor=white" alt="Termux"/>
<img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android"/>
<img src="https://img.shields.io/badge/ARM64-aarch64-blue?style=for-the-badge&logo=arm&logoColor=white" alt="ARM64"/>
<img src="https://img.shields.io/badge/Python-3.14+-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python"/>

# ⚡ Termux AI Wheels

### Repositório APT de IA & Data Science para Termux — ARM64 / Android

Pacotes nativos pré-compilados para **aarch64** · Sem pip lento · Sem quebra de deps · Plug & Play

[![APT Ready](https://img.shields.io/badge/APT-Ready-brightgreen?style=flat-square&logo=debian)](https://github.com/W3skerSec/termux-ai-wheels)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?style=flat-square&logo=pytorch)](https://pytorch.org)
[![Keras](https://img.shields.io/badge/Keras-3.15.1-D00000?style=flat-square&logo=keras)](https://keras.io)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-1.6.1-F7931E?style=flat-square&logo=scikitlearn)](https://scikit-learn.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)

</div>

---

## 🎯 O Problema que Resolvemos

Rodar **IA no Android/Termux** é doloroso por padrão:

- 🐌 `pip install torch` → build de horas, falha, timeout
- 💥 Incompatibilidade de SONAME / `DT_NEEDED` quebrando libs nativas
- ❌ PyPI não distribui wheels para `android_24_arm64_v8a`
- 🧩 Dependências circulares sem solução no ARM64

**Este repositório resolve tudo isso** — pacotes prontos, instalação em segundos.

---

## 🚀 Setup em 1 Linha

```bash
curl -sL https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/main/setup-repo.sh | bash
```

> Isso adiciona o repositório ao seu APT e roda `pkg update` automaticamente.

<details>
<summary>⚙️ Configuração manual (alternativa)</summary>

```bash
echo "deb [trusted=yes] https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/gh-pages/ ./" \
  > $PREFIX/etc/apt/sources.list.d/w3skersec.list

pkg update
```

</details>

---

## 📦 Pacotes Disponíveis

| Pacote | Versão | Arch | Instalar | Notas |
|:---|:---:|:---:|:---|:---|
| 🔥 **PyTorch** | `2.11.0` | `aarch64` | `pkg install torch` | Binários com `patchelf` — zero symlinks frágeis |
| 👁️ **TorchVision** | `0.26.0` | `aarch64` | `pkg install torchvision` | Modelos de visão + C++ ops (`_C.so` e `image.so`) |
| 🧠 **Keras 3** | `3.15.1` | `all` | `pkg install keras` | Multi-backend, opera sobre PyTorch |
| 🤖 **Scikit-Learn** | `1.6.1` | `aarch64` | `pkg install scikit-learn` | Compilado com Clang + OpenMP 5.1 nativo |
| 🌳 **Optree** | `0.20.0` | `aarch64` | `pkg install optree` | Dep. do Keras 3, C++17 |
| 🔢 **ml-dtypes** | `0.6.0` | `aarch64` | `pkg install ml-dtypes` | Tipos numéricos ML — Eigen/C++17 |
| 🐼 **Pandas** | `3.0.5` | `aarch64` | `pkg install pandas` | Análise de dados de alta performance |
| 📊 **Seaborn** | `0.13.2` | `all` | `pkg install seaborn` | Visualização estatística sobre matplotlib |
| 📂 **OpenPyXL** | `3.1.5` | `all` | `pkg install openpyxl` | Leitura e escrita de planilhas `.xlsx` |
| ⚙️ **Joblib** | `1.6.0` | `all` | `pkg install joblib` | Paralelismo e cache de funções Python |
| 🧵 **threadpoolctl** | `3.8.0` | `all` | `pkg install threadpoolctl` | Controle de thread pools (dep. sklearn) |
| 🔤 **absl-py** | `2.5.1` | `all` | `pkg install absl-py` | Utilitários Google / Abseil para Python |
| 🏷️ **Namex** | `0.1.0` | `all` | `pkg install namex` | Gestão de namespaces (dep. Keras) |

---

## ⚡ Instalação por Caso de Uso

### 👁️ Visão Computacional (TorchVision)
```bash
pkg install torch torchvision
```

### 🧠 Stack Completo de Deep Learning
```bash
pkg install keras torch torchvision scikit-learn pandas seaborn openpyxl
```

### 🔥 Só PyTorch
```bash
pkg install torch
```

### 📊 Só Data Science (sem IA pesada)
```bash
pkg install pandas seaborn openpyxl joblib
```

### 🤖 Machine Learning Clássico
```bash
pkg install scikit-learn pandas
```

---

## 💻 Exemplos de Código

<details open>
<summary><strong>🧠 Rede Neural com Keras 3 (backend PyTorch)</strong></summary>

```python
import os
os.environ["KERAS_BACKEND"] = "torch"

import keras
from keras import layers, models
import numpy as np

print(f"Keras {keras.__version__} | Backend: {keras.backend.backend()}")

# Dados de treino
X = np.array([[23.], [27.], [122.], [67.], [25.], [30.]], dtype=np.float32)
y = np.array([[0.],  [0.],  [1.],   [1.],  [0.],  [0.]], dtype=np.float32)

# Modelo Sequential
model = models.Sequential([
    layers.Input(shape=(1,)),
    layers.Dense(64, activation="relu"),
    layers.Dense(32, activation="relu"),
    layers.Dense(1,  activation="sigmoid"),
])

model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])
model.fit(X, y, epochs=50, verbose=0)

prob = model.predict(np.array([[80.]], dtype=np.float32))[0][0]
print(f"Entrada 80.0 → Probabilidade: {prob:.4f}")
```

</details>

<details>
<summary><strong>🤖 Classificação com Scikit-Learn</strong></summary>

```python
from sklearn.linear_model import LogisticRegression
import numpy as np

X = np.array([[23], [27], [122], [67], [25], [30]])
y = np.array([0, 0, 1, 1, 0, 0])

clf = LogisticRegression()
clf.fit(X, y)

pred = clf.predict([[80]])[0]
prob = clf.predict_proba([[80]])[0][1]
print(f"Classe: {pred} | Probabilidade: {prob:.2f}")
```

</details>

<details>
<summary><strong>🐼 Análise de Dados com Pandas + Seaborn</strong></summary>

```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.DataFrame({
    "modelo": ["Keras", "PyTorch", "Sklearn"],
    "acuracia": [0.97, 0.96, 0.92],
})

sns.barplot(data=df, x="modelo", y="acuracia", palette="viridis")
plt.title("Acurácia dos Modelos — Termux ARM64")
plt.savefig("resultado.png", dpi=150)
print(df.to_string(index=False))
```

</details>

---

## 🔧 Engenharia & Diferenciais Técnicos

```
┌─────────────────────────────────────────────────────────────┐
│                   Como os .deb são feitos                              │
├─────────────────────────────────────────────────────────────┤
  1. Compilação nativa no próprio Android (Termux/Clang)                
  2. patchelf corrige DT_NEEDED em binários ELF nativos                 
  3. Indexação APT-padrão Debian (Packages.gz + Release)                
  4. .dist-info embutido → pip reconhece tudo normalmente              
  5. Desinstalação limpa via pkg uninstall / apt remove                 

```

| ✅ Feito certo | ❌ Outros projetos |
|:---|:---|
| Patchelf em ELF nativos | Symlinks frágeis em `$PREFIX/lib` |
| `pkg upgrade` não quebra nada | Quebra após qualquer update |
| OpenMP 5.1 nativo (Clang/LLVM) | GCC com headers ausentes |
| Controle de versão APT | `pip` sem controle de versão |

---

## 📁 Estrutura do Repositório

```
termux-ai-wheels/
├── README.md           ← esta documentação
├── setup-repo.sh       ← script de ativação do APT (1 linha)
├── install.sh          ← instalador all-in-one alternativo
└── [branch: gh-pages]
    ├── Packages        ← índice APT
    ├── Packages.gz     ← índice comprimido
    ├── Release         ← metadados da release APT
    ├── torch_2.11.0_aarch64.deb
    ├── keras_3.15.1_all.deb
    ├── scikit-learn_1.6.1_aarch64.deb
    ├── pandas_3.0.5_aarch64.deb
    └── ...
```

---

## 🛣️ Roadmap

- [x] PyTorch 2.11.0 (aarch64)
- [x] **TorchVision 0.26.0** (aarch64 + C++ ops)
- [x] Keras 3 + dependências
- [x] Scikit-Learn 1.6.1
- [x] Pandas 3.0.5
- [x] Seaborn, OpenPyXL, Joblib
- [ ] TorchAudio
- [ ] ONNX Runtime (ARM64)
- [ ] LLaMA.cpp Python bindings

---

## 👤 Autor

<div align="center">

**[W3skerSec](https://github.com/W3skerSec)** · Mantido com 🖤 no Android

*Compilado, testado e publicado diretamente do Termux.*

</div>

---

<div align="center">
<sub>MIT License · ARM64 · Python 3.14+ · Termux · Android 24+</sub>
</div>
