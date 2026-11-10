#!/data/data/com.termux/files/usr/bin/bash
# ==============================================================================
# Termux AI Repository Setup (W3skerSec)
# Permite instalar pacotes como: pkg install keras, pkg install torch, etc.
# ==============================================================================

set -e

echo "Configurando repositório APT de IA (W3skerSec)..."

REPO_LIST="$PREFIX/etc/apt/sources.list.d/w3skersec.list"

echo "deb [trusted=yes] https://raw.githubusercontent.com/W3skerSec/termux-ai-wheels/gh-pages/ ./" > "$REPO_LIST"

echo "Atualizando listas do APT..."
apt-get update --allow-releaseinfo-change

echo ""
echo "=================================================="
echo " Repositório configurado com sucesso!"
echo " Agora você pode instalar diretamente com:"
echo ""
echo "   pkg install keras"
echo "   pkg install torch"
echo "   pkg install scikit-learn"
echo "=================================================="
