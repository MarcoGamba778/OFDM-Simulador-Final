@echo off
setlocal
cd /d "%~dp0"
title Simulador OFDM

echo ========================================
echo       INICIADOR DEL SIMULADOR OFDM
echo ========================================
echo.

if not exist ".venv\Scripts\python.exe" (
    echo [1/3] Creando entorno virtual...
    where py >nul 2>&1
    if not errorlevel 1 (
        py -3 -m venv .venv
    ) else (
        where python >nul 2>&1
        if errorlevel 1 goto no_python
        python -m venv .venv
    )
    if errorlevel 1 goto venv_error
) else (
    echo [1/3] Entorno virtual existente.
)

.venv\Scripts\python.exe -c "import numpy, scipy, matplotlib, streamlit" >nul 2>&1
if errorlevel 1 (
    echo [2/3] Instalando dependencias. Se requiere conexion a Internet...
    .venv\Scripts\python.exe -m pip install --upgrade pip
    if errorlevel 1 goto install_error
    .venv\Scripts\python.exe -m pip install -r requirements.txt
    if errorlevel 1 goto install_error
) else (
    echo [2/3] Dependencias instaladas.
)

echo [3/3] Iniciando la aplicacion web...
echo Al abrir, vaya a http://localhost:8501 si el navegador no se abre solo.
echo Para cerrar, presione Ctrl+C en esta ventana.
echo.
.venv\Scripts\python.exe -m streamlit run app.py
if errorlevel 1 goto app_error
exit /b 0

:no_python
echo ERROR: No se encontro Python 3 en este computador.
echo Instale Python 3.10 o superior desde https://www.python.org/downloads/windows/
echo Durante la instalacion, marque "Add python.exe to PATH".
goto finish_error

:venv_error
echo ERROR: No se pudo crear el entorno virtual de Python.
echo Revise que Python 3.10 o superior este instalado correctamente.
goto finish_error

:install_error
echo ERROR: No se pudieron instalar las dependencias.
echo Compruebe la conexion a Internet y vuelva a ejecutar este archivo.
echo Si persiste, envie al equipo el mensaje de error mostrado arriba.
goto finish_error

:app_error
echo ERROR: Streamlit no pudo iniciar la aplicacion.
echo Compruebe los mensajes anteriores y que esta carpeta contenga app.py y src.
goto finish_error

:finish_error
echo.
echo Presione una tecla para cerrar esta ventana.
pause >nul
exit /b 1
