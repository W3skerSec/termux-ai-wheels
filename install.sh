#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  Termux AI Wheels — Instalador All-in-One
#  https://github.com/W3skerSec/termux-ai-wheels
#
#  Uso:  curl -sL https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/main/install.sh | bash
# ==============================================================================

set -euo pipefail

# ── Cores ─────────────────────────────────────────────────────────────────────
RED='\033[0;31m';  GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m';  BOLD='\033[1m'; RESET='\033[0m'

ok()    { echo -e "  ${GREEN}✓${RESET} $*"; }
info()  { echo -e "  ${CYAN}→${RESET} $*"; }
step()  { echo -e "\n${BOLD}[$1] $2${RESET}"; }
die()   { echo -e "\n  ${RED}✗ Erro:${RESET} $*\n" >&2; exit 1; }

# ── Verificações ───────────────────────────────────────────────────────────────
[ -n "${PREFIX:-}" ] || die "Execute dentro do Termux."
command -v pkg    &>/dev/null || die "'pkg' não encontrado."
command -v python3 &>/dev/null || die "Python 3 não encontrado. Execute: pkg install python"

# ── Banner ─────────────────────────────────────────────────────────────────────
clear
echo ""
echo -e "${BOLD}${BLUE}"
echo "  ╔══════════════════════════════════════════════════╗"
echo "  ║       Termux AI Wheels — Instalador              ║"
echo "  ║   PyTorch · Keras · Scikit-Learn · Pandas        ║"
echo "  ║            ARM64 / Android / Python 3.14         ║"
echo "  ╚══════════════════════════════════════════════════╝"
echo -e "${RESET}"

# ── [1/4] Dependências de sistema ─────────────────────────────────────────────
step "1/4" "Instalando dependências de sistema..."
pkg install -y python python-pip matplotlib patchelf git 2>/dev/null
ok "Dependências instaladas."

# ── [2/4] Adicionar repositório APT ───────────────────────────────────────────
step "2/4" "Configurando repositório APT..."

REPO_FILE="$PREFIX/etc/apt/sources.list.d/w3skersec.list"
REPO_URL="https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/gh-pages/"
echo "deb [trusted=yes] ${REPO_URL} ./" > "$REPO_FILE"
apt-get update --allow-releaseinfo-change -qq
ok "Repositório APT configurado."

# ── [3/4] Instalar pacotes via APT ────────────────────────────────────────────
step "3/4" "Instalando pacotes de IA e Data Science..."

PACKAGES=(torch keras scikit-learn pandas seaborn openpyxl joblib threadpoolctl absl-py namex)

for pkg_name in "${PACKAGES[@]}"; do
  info "Instalando ${pkg_name}..."
  apt-get install -y "$pkg_name" -qq 2>/dev/null && ok "${pkg_name}" || info "${pkg_name} (pulado — já instalado ou não disponível)"
done

# ── [4/4] Verificação do ambiente ─────────────────────────────────────────────
step "4/4" "Verificando ambiente instalado..."
echo ""

KERAS_BACKEND=torch python3 - <<'PYEOF'
results = []
libs = [
    ("torch",       "torch.__version__"),
    ("sklearn",     "sklearn.__version__"),
    ("keras",       "keras.__version__"),
    ("pandas",      "pd.__version__"),
    ("seaborn",     "sns.__version__"),
    ("matplotlib",  "matplotlib.__version__"),
    ("openpyxl",    "openpyxl.__version__"),
]

import importlib, sys
for mod_name, ver_expr in libs:
    alias = mod_name.split(".")[0]
    try:
        mod = importlib.import_module(mod_name)
        # resolução de alias
        if mod_name == "sklearn":
            import sklearn as mod; alias = "sklearn"
        if mod_name == "seaborn":
            import seaborn as sns; mod = sns
        if mod_name == "pandas":
            import pandas as pd; mod = pd
        if mod_name == "matplotlib":
            import matplotlib; mod = matplotlib
        ver = eval(ver_expr.replace("torch.", "mod.").replace("sklearn.", "mod.").replace("keras.", "mod.").replace("pd.", "mod.").replace("sns.", "mod.").replace("matplotlib.", "mod.").replace("openpyxl.", "mod."))
        results.append(("✓", mod_name, ver))
    except Exception as e:
        results.append(("✗", mod_name, "não instalado"))

for status, name, ver in results:
    color = "\033[0;32m" if status == "✓" else "\033[0;31m"
    print(f"  {color}{status}\033[0m  {name:<14} {ver}")
PYEOF

# ── Resumo final ───────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}  ══════════════════════════════════════════════════"
echo -e "   Instalação concluída! Pronto para rodar IA 🚀"
echo -e "  ══════════════════════════════════════════════════${RESET}"
echo ""
echo -e "  Teste rápido:"
echo -e "    ${CYAN}KERAS_BACKEND=torch python3 -c \"import keras; print(keras.__version__)\"${RESET}"
echo ""
echo -e "  ${BLUE}→ Docs: https://github.com/W3skerSec/termux-ai-wheels${RESET}"
echo ""
