#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# Colores
greenColor="\e[0;32m\033[1m"
purpleColor="\e[0;35m\033[1m"
redColor="\e[0;31m\033[1m"
yellowColor="\e[0;33m\033[1m"
endColor="\033[0m\e[0m"

# Variables
BIN_DIR="$HOME/.local/bin"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SYSTEMD_USER_DIR/visual-break.service"
TIMER_FILE="$SYSTEMD_USER_DIR/visual-break.timer"
BIN_FILE="$BIN_DIR/visual-break"

create_directories() {
    echo -e "${purpleColor}Creando directorios necesarios...${endColor}"
    mkdir -p "$BIN_DIR"
    mkdir -p "$SYSTEMD_USER_DIR"
}

check_files_exist() {
    local files=("$@")
    for file in "${files[@]}"; do
        if [[ -n "$file" && ! -f "$file" ]]; then
            echo -e "${redColor}[!] Error: El archivo $file no existe.${endColor}"
            exit 1
        fi
    done
}

copy_files() {
    local src_bin="$1"
    local dst_bin="$2"
    local src_service="${3:-}"  # Valor por defecto vacío
    local dst_service="${4:-}"  # Valor por defecto vacío
    local src_timer="${5:-}"    # Valor por defecto vacío
    local dst_timer="${6:-}"    # Valor por defecto vacío

    # Verifica solo los archivos que no estén vacíos
    check_files_exist "$src_bin" "$src_service" "$src_timer"

    echo -e "${purpleColor}Copiando archivos...${endColor}"
    cp "$src_bin" "$dst_bin"
    chmod 755 "$dst_bin"
    
    if [[ -n "$src_service" && -n "$dst_service" ]]; then
        sed "s/user/$USER/g" "$src_service" > "$dst_service"
        chmod 655 "$dst_service"
    fi

    if [[ -n "$src_timer" && -n "$dst_timer" ]]; then
        sed "s/user/$USER/g" "$src_timer" > "$dst_timer"
        chmod 655 "$dst_timer"
    fi
}

install_systemd() {
    echo -e "${yellowColor}Instalando VisualBrake...${endColor}"
    create_directories
    copy_files bin/visual-break "$BIN_FILE" services/visual-break.service "$SERVICE_FILE" services/visual-break.timer "$TIMER_FILE"

    if ! command -v systemctl &> /dev/null; then
        echo -e "${redColor}[!] Error: systemctl no está disponible.${endColor}"
        exit 1
    fi

    if ! systemctl --user daemon-reload; then
        echo -e "${redColor}[!] Error recargando systemd.${endColor}"
        exit 1
    fi

    if ! systemctl --user enable visual-break.timer; then
        echo -e "${redColor}[!] Error habilitando el temporizador.${endColor}"
        exit 1
    fi

    if ! systemctl --user start visual-break.timer; then
        echo -e "${redColor}[!] Error iniciando el temporizador.${endColor}"
        exit 1
    fi

    if ! systemctl --user start visual-break.service; then
        echo -e "${redColor}[!] Error iniciando el servicio.${endColor}"
        exit 1
    fi

    echo -e "\n${greenColor}[+] VisualBrake se ha instalado y configurado correctamente.${endColor}\n"
}

print_help() {
    echo -e "${yellowColor}Uso: $0 [systemd]${endColor}"
    echo "  systemd   - Instala VisualBrake con systemd timers"
}

if [ $# -ne 1 ]; then
    print_help
    exit 1
fi

case "$1" in
    systemd)
        install_systemd
        ;;
    *)
        print_help
        exit 1
        ;;
esac
