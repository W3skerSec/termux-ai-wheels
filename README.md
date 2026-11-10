# 🚀 Repositório APT de Inteligência Artificial para Termux (ARM64 / Android)

Servidor e repositório de pacotes **APT nativos** para **Termux**, contendo as principais bibliotecas de Inteligência Artificial e Ciência de Dados pré-compiladas e otimizadas para a arquitetura **aarch64 (ARM64)** rodando **Python 3.14+**.

Este projeto resolve o problema crônico de falta de suporte oficial no Termux e no PyPI para arquiteturas mobile, eliminando compilações lentas, quebras de dependências e a necessidade de URLs complexas.

---

## ⚡ Ativação Rápida (Executar apenas uma vez)

Para adicionar este repositório ao seu gerenciador de pacotes do Termux, execute o comando abaixo no terminal:

```bash
curl -sL https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/main/setup-repo.sh | bash
```

*(Ou adicione manualmente, se preferir):*
```bash
echo "deb [trusted=yes] https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/gh-pages/ ./" > $PREFIX/etc/apt/sources.list.d/w3skersec.list
pkg update
```

---

## 📦 Como Instalar os Pacotes

Com o repositório ativado, você instala qualquer pacote diretamente pelo gerenciador nativo do Termux (`pkg` ou `apt`):

### 1. Instalar o Keras 3 (com backend PyTorch)
```bash
pkg install keras
```
> **Nota:** O gerenciador de pacotes resolverá e instalará automaticamente todas as dependências nativas (`torch`, `optree`, `ml-dtypes`), sem precisar baixar o TensorFlow pesado.

### 2. Instalar apenas o PyTorch
```bash
pkg install torch
```

### 3. Instalar o Scikit-Learn
```bash
pkg install scikit-learn
```

### 4. Instalar o Ambiente Completo de IA e Dados
```bash
pkg install keras scikit-learn matplotlib
pip install pandas openpyxl
```

---

## 📋 Tabela de Pacotes do Repositório

| Pacote | Comando de Instalação | Versão | Arquitetura | Descrição Técnica |
| :--- | :--- | :--- | :--- | :--- |
| **Keras 3** | `pkg install keras` | `3.15.1` | `all` | Framework de Deep Learning multi-backend operando nativamente sobre PyTorch. |
| **PyTorch** | `pkg install torch` | `2.11.0` | `aarch64` | Biblioteca de Tensores e Redes Neurais com binários corrigidos via `patchelf` (`libabsl_base_cpu_detect.so`). |
| **Scikit-Learn** | `pkg install scikit-learn` | `1.6.1` | `aarch64` | Algoritmos de Machine Learning compilados com Clang e suporte a paralelismo OpenMP 5.1 nativo. |
| **Optree** | `pkg install optree` | `0.20.0` | `aarch64` | Biblioteca de manipulação de árvores e tuplas estruturadas utilizada pelo Keras 3. |
| **ml-dtypes** | `pkg install ml-dtypes` | `0.6.0` | `aarch64` | Tipos numéricos de Machine Learning compilados em C++17 com Eigen. |

---

## 💡 Exemplos de Código em Python

### Exemplo 1: Rede Neural com Keras 3 (Backend PyTorch)

```python
import os
# Define o PyTorch como motor de processamento do Keras 3
os.environ["KERAS_BACKEND"] = "torch"

import keras
from keras import layers, models
import numpy as np

print(f"Keras: {keras.__version__} | Backend: {keras.backend.backend()}")

# Criando dados de exemplo
X = np.array([[23.0], [27.0], [122.0], [67.0], [25.0], [30.0]], dtype=np.float32)
y = np.array([[0.0],  [0.0],  [1.0],   [1.0],  [0.0],  [0.0]], dtype=np.float32)

# Modelo Sequential clássico: 64 -> 32 -> 1
model = models.Sequential([
    layers.Input(shape=(1,)),
    layers.Dense(64, activation="relu"),
    layers.Dense(32, activation="relu"),
    layers.Dense(1, activation="sigmoid")
])

model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])
model.fit(X, y, epochs=50, verbose=1)

# Testando predição
novo_dado = np.array([[80.0]], dtype=np.float32)
prob = model.predict(novo_dado)[0][0]
print(f"Resultado para 80.0 -> Probabilidade: {prob:.4f}")
```

### Exemplo 2: Classificação com Scikit-Learn

```python
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import numpy as np

X = np.array([[23], [27], [122], [67], [25], [30]])
y = np.array([0, 0, 1, 1, 0, 0])

clf = LogisticRegression()
clf.fit(X, y)

pred = clf.predict([[80]])[0]
prob = clf.predict_proba([[80]])[0][1]
print(f"Classe predita para 80: {pred} (Probabilidade: {prob:.2f})")
```

---

## 🛡️ Engenharia e Estabilidade Técnica

1. **Sem Symlinks Frágeis:** Não utilizamos symlinks manuais no `$PREFIX/lib`. O PyTorch teve as tabelas `DT_NEEDED` dos seus binários ELF corrigidas diretamente com `patchelf`, garantindo que atualizações normais do Termux (`pkg upgrade`) nunca quebrem a biblioteca.
2. **OpenMP com Clang e libc++:** O Scikit-Learn foi construído com a toolchain padrão LLVM/Clang do Android, contornando a incompatibilidade do GCC com cabeçalhos ausentes da libstdc++.
3. **Distribuição via APT:** Todo o repositório é indexado segundo o padrão Debian (`Packages.gz` e `Release`), permitindo controle de versão, gerenciamento limpo e desinstalação segura via `pkg uninstall`.

---

## 👤 Autor e Mantenedor

- **Mantenedor:** [W3skerSec](https://github.com/W3skerSec)
- **Repositório:** [https://github.com/W3skerSec/termux-ai-wheels](https://github.com/W3skerSec/termux-ai-wheels)
- **Licença:** MIT
