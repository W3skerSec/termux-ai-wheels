#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
#  Termux AI Wheels — Setup do Repositório APT
#  https://github.com/W3skerSec/termux-ai-wheels
# ==============================================================================

set -euo pipefail

# ── Cores ─────────────────────────────────────────────────────────────────────
RED='\033[0;31m';  GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m';  BOLD='\033[1m'; RESET='\033[0m'

ok()   { echo -e "  ${GREEN}✓${RESET} $*"; }
info() { echo -e "  ${CYAN}→${RESET} $*"; }
warn() { echo -e "  ${YELLOW}⚠${RESET} $*"; }
die()  { echo -e "  ${RED}✗ Erro:${RESET} $*" >&2; exit 1; }

# ── Banner ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${BLUE}"
echo "  ╔══════════════════════════════════════════════════╗"
echo "  ║       Termux AI Wheels — W3skerSec               ║"
echo "  ║   Repositório APT de IA & Data Science ARM64     ║"
echo "  ╚══════════════════════════════════════════════════╝"
echo -e "${RESET}"

# ── Verificações ───────────────────────────────────────────────────────────────
[ -n "${PREFIX:-}" ] || die "Execute este script dentro do Termux."
command -v apt-get &>/dev/null || die "apt-get não encontrado."

REPO_FILE="$PREFIX/etc/apt/sources.list.d/w3skersec.list"
REPO_URL="https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/gh-pages/"

# ── Configurar repositório ─────────────────────────────────────────────────────
echo -e "${BOLD}[1/2] Configurando repositório APT...${RESET}"

echo "deb [trusted=yes] ${REPO_URL} ./" > "$REPO_FILE"
ok "Repositório adicionado em: $REPO_FILE"

# ── Atualizar lista de pacotes ─────────────────────────────────────────────────
echo ""
echo -e "${BOLD}[2/2] Atualizando listas de pacotes...${RESET}"
apt-get update --allow-releaseinfo-change -qq && ok "Listas atualizadas!" || warn "Aviso no update — verifique sua conexão."

# ── Resumo ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}  ══════════════════════════════════════════════════"
echo -e "   Repositório configurado com sucesso! 🎉"
echo -e "  ══════════════════════════════════════════════════${RESET}"
echo ""
echo -e "  Instale os pacotes disponíveis:"
echo ""
echo -e "    ${CYAN}pkg install torch${RESET}             → PyTorch 2.11.0"
echo -e "    ${CYAN}pkg install keras${RESET}             → Keras 3.15.1"
echo -e "    ${CYAN}pkg install scikit-learn${RESET}      → Scikit-Learn 1.6.1"
echo -e "    ${CYAN}pkg install pandas${RESET}            → Pandas 3.0.5"
echo -e "    ${CYAN}pkg install seaborn${RESET}           → Seaborn 0.13.2"
echo ""
echo -e "  Stack completo de IA:"
echo -e "    ${BOLD}${CYAN}pkg install keras scikit-learn pandas seaborn openpyxl${RESET}"
echo ""
echo -e "  ${BLUE}→ Docs: https://github.com/W3skerSec/termux-ai-wheels${RESET}"
echo ""
