@echo off
setlocal enabledelayedexpansion

set "file=JWT.key"
set "length=256"

:: Crear JWT.key si no existe
if not exist "%file%" (
    set "charset=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%%^&*()-_=+[]{};:,<.>/?"
    set "randomStr="
    for /l %%i in (1,1,%length%) do (
        set /a index=!random! %% 93
        for %%j in (!index!) do set "randomStr=!randomStr!!charset:~%%j,1!"
    )
    echo !randomStr! > "%file%"
    echo Archivo creado con cadena aleatoria de 256 caracteres.
)

:: Leer JWT del archivo
set /p MODULE_SESSIONMANAGER__JWT=<"%file%"

:: Establecer variables
set MODULE_IDSPROVIDER__PORT=3333
set MODULE_SESSIONMANAGER__PORT=8085
set MODULE_REQUESTID__PORT=8085
set MODULE_MESSAGING__PORT=8090
set MODULE_APPSERVER__PORT=8080

call set MODULE_IDSPROVIDER=http://idsprovider:%MODULE_IDSPROVIDER__PORT%
call set MODULE_SESSIONMANAGER=http://sessionmanager:%MODULE_SESSIONMANAGER__PORT%
call set MODULE_REQUESTID=http://sessionmanager:%MODULE_REQUESTID__PORT%
call set MODULE_MESSAGING=http://messaging:%MODULE_MESSAGING__PORT%

:: Crear archivo .env para Docker Compose
(
echo MODULE_IDSPROVIDER__JWT=%MODULE_SESSIONMANAGER__JWT%
echo MODULE_IDSPROVIDER__PORT=%MODULE_IDSPROVIDER__PORT%
echo MODULE_SESSIONMANAGER__PORT=%MODULE_SESSIONMANAGER__PORT%
echo MODULE_REQUESTID__PORT=%MODULE_REQUESTID__PORT%
echo MODULE_MESSAGING__PORT=%MODULE_MESSAGING__PORT%
echo MODULE_APPSERVER__PORT=%MODULE_APPSERVER__PORT%
echo MODULE_IDSPROVIDER=%MODULE_IDSPROVIDER%
echo MODULE_SESSIONMANAGER=%MODULE_SESSIONMANAGER%
echo MODULE_REQUESTID=%MODULE_REQUESTID%
echo MODULE_MESSAGING=%MODULE_MESSAGING%
) > .env

:: Mostrar info
type .env

:: Ejecutar Docker Compose
docker compose up --build
