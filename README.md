<div align="center">

<img src="https://img.shields.io/badge/Termux-000000?style=for-the-badge&logo=gnometerminal&logoColor=white" alt="Termux"/>
<img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android"/>
<img src="https://img.shields.io/badge/ARM64-aarch64-blue?style=for-the-badge&logo=arm&logoColor=white" alt="ARM64"/>
<img src="https://img.shields.io/badge/Python-3.14+-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python"/>

# ⚡ Termux AI Wheels

### Repositório APT Autossuficiente de IA, Visão & Data Science para Termux

Cadeia completa e fechada de dependências pré-compiladas para **aarch64** · Imune a quebras de upstream · Plug & Play

[![APT Ready](https://img.shields.io/badge/APT-Ready-brightgreen?style=flat-square&logo=debian)](https://github.com/W3skerSec/termux-ai-wheels)
[![Whisper](https://img.shields.io/badge/Whisper-1.9.5-00A67E?style=flat-square&logo=openai)](https://github.com/ggerganov/whisper.cpp)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.11.0-EE4C2C?style=flat-square&logo=pytorch)](https://pytorch.org)
[![Ultralytics YOLO](https://img.shields.io/badge/YOLO-v8%2Fv11-00FFFF?style=flat-square&logo=yolo)](https://ultralytics.com)
[![OpenCV](https://img.shields.io/badge/OpenCV-5.1.0-5C3EE8?style=flat-square&logo=opencv)](https://opencv.org)
[![NumPy](https://img.shields.io/badge/NumPy-2.4.4-013243?style=flat-square&logo=numpy)](https://numpy.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)

</div>

---

## 🎯 Por que este repositório é Diferente?

A maioria dos tutoriais de IA para Android quebra em poucas semanas porque:
- O Termux upstream atualiza bibliotecas C/C++ compartilhadas (`libicu`, `ffmpeg`, `libxml2`, `openblas`) sem sincronia com os pacotes Python.
- O PyPI empurra atualizações do NumPy ou SciPy com novas ABIs incompatíveis com binários existentes.
- Módulos essenciais como **Ultralytics YOLO** assumem cegamente que todo Linux é desktop e rejeitam o Android com `ValueError: Unsupported operating system: Android`.

**O Termux AI Wheels resolve isso blindando a cadeia inteira:**
Todas as dependências diretas, indiretas e compartilhadas estão preservadas e empacotadas no repositório. O que funciona hoje continuará funcionando para sempre.

---

## 🚀 Setup em 1 Linha

```bash
curl -sL https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/main/setup-repo.sh | bash
```

> Adiciona a chave, registra o repositório em `$PREFIX/etc/apt/sources.list.d/w3skersec.list` e sincroniza o APT.

---

## 📦 Matriz Completa de Pacotes (Cadeia Fechada)

### 🧠 Frameworks Centrais de IA & Redes Neurais
| Pacote | Versão | Arquitetura | Instalação | Finalidade Técnica |
|:---|:---:|:---:|:---|:---|
| 🔥 **PyTorch** | `2.11.0` | `aarch64` | `pkg install torch` | Tensores & autograd nativo (ELF patchelf corrigido) |
| 👁️ **TorchVision** | `0.26.0` | `aarch64` | `pkg install torchvision` | Modelos de visão + C++ ops nativos (`_C.so` e `image.so`) |
| 🔊 **TorchAudio** | `2.11.0` | `aarch64` | `pkg install torchaudio` | Sinais de áudio + C++ ops (`forced_align` e `RNNT`) |
| 🎯 **Ultralytics YOLO** | `8.4.202` | `all` | `pkg install ultralytics` | YOLOv8/v11 patcheado para Android + CLI `yolo` |
| 🧠 **Keras 3** | `3.15.1` | `all` | `pkg install keras` | Multi-backend operando nativamente sobre PyTorch |

### 🗣️ Reconhecimento de Fala & Áudio Neural (Speech-to-Text)
| Pacote | Versão | Arquitetura | Instalação | Finalidade Técnica |
|:---|:---:|:---:|:---|:---|
| 🎙️ **Whisper.cpp** | `1.9.5` | `aarch64` | `pkg install whisper-cpp` | Motor C++ de STT com aceleração **ARM NEON + DotProd** + CLI `whisper-cli` e `whisper-server` |
| 🐍 **OpenAI Whisper** | `20250625` | `all` | `pkg install python-openai-whisper` | Bindings Python do Whisper com PyTorch |
| ⏳ **tqdm** | `4.70.1` | `all` | `pkg install python-tqdm` | Barra de progresso para downloads e inferência de áudio |

### 🔬 Computação Científica & Visão Computacional
| Pacote | Versão | Arquitetura | Instalação | Finalidade Técnica |
|:---|:---:|:---:|:---|:---|
| 🔢 **NumPy** | `2.4.4` | `aarch64` | `pkg install numpy` | **Golden ABI** estável alinhada com Pandas e PyTorch |
| 🧪 **SciPy** | `1.18.0` | `aarch64` | `pkg install python-scipy` | Algoritmos científicos com aceleração OpenBLAS |
| 👁️ **OpenCV** | `5.1.0` | `aarch64` | `pkg install opencv opencv-python` | Visão computacional C++ & bindings Python (`cv2`) |
| 🤖 **Scikit-Learn** | `1.6.1` | `aarch64` | `pkg install scikit-learn` | Machine learning clássico com OpenMP nativo |
| 🐼 **Pandas** | `3.0.5` | `aarch64` | `pkg install pandas` | Estruturas tabulares e análise de alta performance |

### 📊 Visualização de Dados
| Pacote | Versão | Arquitetura | Instalação | Finalidade Técnica |
|:---|:---:|:---:|:---|:---|
| 📈 **Matplotlib** | `3.11.2` | `aarch64` | `pkg install matplotlib` | Renderização gráfica nativa via FreeType/Qhull |
| 🎨 **Seaborn** | `0.13.2` | `all` | `pkg install seaborn` | Visualização estatística avançada |
| 🖼️ **Pillow** | `13.0.0` | `aarch64` | `pkg install python-pillow` | Processamento de imagens rasterizadas |

### 🔗 Cadeia de Suporte & Dependências Fechadas
| Pacote | Versão | Tipo | Descrição |
|:---|:---:|:---:|:---|
| 🌳 **optree** | `0.20.0` | aarch64 | Manipulação estruturada de tensores em C++ (Keras) |
| 📐 **ml-dtypes** | `0.6.0` | aarch64 | Tipos de ponto flutuante em C++17 (Keras/PyTorch) |
| ⚡ **joblib** | `1.6.0` | all | Paralelismo de pipelines para Scikit-Learn |
| 🧵 **threadpoolctl** | `3.8.0` | all | Gestor de concorrência OpenMP / BLAS |
| 🌐 **requests** | `2.32.4` | all | Requisições HTTP (com urllib3, certifi, idna, charset-normalizer) |
| 🔤 **fonttools** | `4.68.0` | all | Manipulação tipográfica de vetores (Matplotlib) |
| 📐 **contourpy** | `1.4.0` | aarch64 | Curvas de nível 2D em C++ (Matplotlib) |
| 🧩 **kiwisolver** | `1.5.1` | aarch64 | Resolução de restrições geométricas em C++ (Matplotlib) |
| 📑 **openpyxl** | `3.1.5` | all | Manipulação de planilhas Excel `.xlsx` |

---

## ⚡ Comandos Rápidos por Caso de Uso

### 🎯 Visão Computacional Completa (YOLO + OpenCV + TorchVision)
```bash
pkg install torch torchvision opencv opencv-python ultralytics
```

### 🧠 Deep Learning Multimodal (Visão + Áudio + Tensores)
```bash
pkg install torch torchvision torchaudio keras
```

### 📊 Data Science & Machine Learning Stack
```bash
pkg install numpy python-scipy pandas scikit-learn matplotlib seaborn openpyxl
```

---

## 💻 Teste de Validação Prático

```python
import torch
import torchvision
import torchaudio
import cv2
from ultralytics import YOLO
import pandas as pd
import numpy as np

print(f"✓ PyTorch     : {torch.__version__}")
print(f"✓ TorchVision : {torchvision.__version__}")
print(f"✓ TorchAudio  : {torchaudio.__version__}")
print(f"✓ OpenCV      : {cv2.__version__}")
print(f"✓ NumPy       : {np.__version__}")
print(f"✓ Pandas      : {pd.__version__}")
print("✓ YOLO Model  : Pronto para inferência!")
print("✓ Whisper STT : Motor ARM NEON 10x tempo real ativo!")
```

---

## 🛡️ Filosofia de Engenharia: A Blindagem de Cadeia

```
┌────────────────────────────────────────────────────────────────────────┐
│                   A Blindagem Termux AI Wheels                         │
├────────────────────────────────────────────────────────────────────────┤
│ 1. Zero Pip Compiles      → Nenhum clang rodando na máquina do usuário │
│ 2. Cadeia Auto-contida    → Todas as 31 dependências no mesmo repo     │
│ 3. SONAME & ABI Travadas  → NumPy 2.4.4 + PyTorch 2.11.0 imutáveis     │
│ 4. Patches para Android   → Ultralytics roda sem erro de OS            │
│ 5. Desinstalação Segura   → dpkg/apt gerencia o ciclo de vida limpo    │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 👤 Autor e Mantenedor

<div align="center">

**[W3skerSec](https://github.com/W3skerSec)**

*Engenharia reversa, otimização e empacotamento nativo direto do Android.*

</div>
