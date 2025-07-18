#!/bin/bash

FILE="JWT.key"
LENGTH=256

# Si el archivo no existe, generamos una cadena aleatoria y lo escribimos
if [ ! -f "$FILE" ]; then
  # Caracteres permitidos (escapar bien algunos para bash)
  CHARSET='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,<.>/?'
  CHARSET_LENGTH=${#CHARSET}
  RANDOM_STR=""

  for ((i=0; i<LENGTH; i++)); do
    INDEX=$((RANDOM % CHARSET_LENGTH))
    RANDOM_STR+="${CHARSET:$INDEX:1}"
  done

  echo "$RANDOM_STR" > "$FILE"
  echo "Archivo creado con cadena aleatoria de 256 caracteres."
fi

# Leer contenido del archivo
MODULE_SESSIONMANAGER__JWT=$(cat "$FILE")
echo "Contenido leído:"
echo "$MODULE_SESSIONMANAGER__JWT"

# Establecer los puertos
MODULE_IDSPROVIDER__PORT=3333
MODULE_SESSIONMANAGER__PORT=8085
MODULE_REQUESTID__PORT=8085
MODULE_MESSAGING__PORT=8090
MODULE_APPSERVER__PORT=8080

# Construir URLs
MODULE_IDSPROVIDER="http://idsprovider:$MODULE_IDSPROVIDER__PORT"
MODULE_SESSIONMANAGER="http://sessionmanager:$MODULE_SESSIONMANAGER__PORT"
MODULE_REQUESTID="http://sessionmanager:$MODULE_REQUESTID__PORT"
MODULE_MESSAGING="http://messaging:$MODULE_MESSAGING__PORT"

# Mostrar resultados
echo "MODULE_IDSPROVIDER=$MODULE_IDSPROVIDER"
echo "MODULE_SESSIONMANAGER=$MODULE_SESSIONMANAGER"
echo "MODULE_REQUESTID=$MODULE_REQUESTID"
echo "MODULE_MESSAGING=$MODULE_MESSAGING"

# Lanzar docker-compose
docker compose up --build
