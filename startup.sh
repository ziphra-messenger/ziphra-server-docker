#!/bin/bash

# Habilitar modo estricto
set -euo pipefail
IFS=$'\n\t'

FILE="JWT.key"
LENGTH=256

# Si el archivo no existe, generamos una cadena aleatoria y la guardamos
if [ ! -f "$FILE" ]; then
    CHARSET='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,<.>/?'
    CHARSET_LENGTH=${#CHARSET}
    RANDOM_STRING=""

    for ((i = 0; i < LENGTH; i++)); do
        INDEX=$((RANDOM % CHARSET_LENGTH))
        RANDOM_STRING+="${CHARSET:$INDEX:1}"
    done

    echo "$RANDOM_STRING" > "$FILE"
    echo "Archivo creado con cadena aleatoria de 256 caracteres."
fi

# Leer el contenido del archivo
MODULE_SESSIONMANAGER__JWT=$(<"$FILE")
echo "Contenido leído:"
echo "$MODULE_SESSIONMANAGER__JWT"

# Definir los puertos
MODULE_IDSPROVIDER__PORT=3333
MODULE_SESSIONMANAGER__PORT=8085
MODULE_REQUESTID__PORT=8085
MODULE_MESSAGING__PORT=8090
MODULE_APPSERVER__PORT=8080

# Construir las URLs
MODULE_IDSPROVIDER="http://idsprovider:${MODULE_IDSPROVIDER__PORT}"
MODULE_SESSIONMANAGER="http://sessionmanager:${MODULE_SESSIONMANAGER__PORT}"
MODULE_REQUESTID="http://sessionmanager:${MODULE_REQUESTID__PORT}"
MODULE_MESSAGING="http://messaging:${MODULE_MESSAGING__PORT}"

# Mostrar resultados
echo "MODULE_IDSPROVIDER=$MODULE_IDSPROVIDER"
echo "MODULE_SESSIONMANAGER=$MODULE_SESSIONMANAGER"
echo "MODULE_REQUESTID=$MODULE_REQUESTID"
echo "MODULE_MESSAGING=$MODULE_MESSAGING"

# Lanzar docker compose con variables de entorno
MODULE_SESSIONMANAGER__JWT="$MODULE_SESSIONMANAGER__JWT" \
MODULE_IDSPROVIDER="$MODULE_IDSPROVIDER" \
MODULE_SESSIONMANAGER="$MODULE_SESSIONMANAGER" \
MODULE_REQUESTID="$MODULE_REQUESTID" \
MODULE_MESSAGING="$MODULE_MESSAGING" \
docker compose up --build
