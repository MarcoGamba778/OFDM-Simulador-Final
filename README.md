# Simulador de un sistema OFDM

Aplicación interactiva para explorar la transmisión y recepción OFDM en banda base. Permite ajustar parámetros del sistema y observar los efectos del ruido y el multitrayecto.

## Requisitos

- Windows 10 u 11.
- Python 3.10 o superior. Al instalar Python desde [python.org](https://www.python.org/downloads/windows/), active la opción **Add python.exe to PATH**.
- Conexión a Internet durante la primera ejecución para descargar las librerías.

## Instalación y ejecución

1. En GitHub, descargue el proyecto con **Code → Download ZIP** y extraiga el archivo.
2. Abra la carpeta `OFDM-Simulador-Final` extraída. Si el proyecto se encuentra dentro de otra carpeta con el mismo nombre, entre hasta encontrar `app.py`, `src` y `Iniciar_OFDM.bat`.
3. Haga doble clic en `Iniciar_OFDM.bat`. La primera vez creará un entorno Python local e instalará NumPy, SciPy, Matplotlib y Streamlit; esto puede tardar unos minutos.
4. Cuando aparezca la dirección local, abra `http://localhost:8501` en el navegador. Deje abierta la ventana de consola durante el uso.

Si la ventana muestra un error y solicita presionar una tecla, hubo un problema previo. El iniciador muestra el motivo antes de cerrarse. Los casos más comunes son Python ausente o instalación de dependencias sin conexión. Para cerrar normalmente la aplicación, use `Ctrl+C` en la consola.

## Ejecución desde Visual Studio Code

Abra la carpeta raíz que contiene `app.py`. En la terminal integrada ejecute `Iniciar_OFDM.bat`, o use **Terminal → Run Task → OFDM: Ejecutar simulador** después de instalar las dependencias.

## Uso

En el panel lateral se pueden configurar modulación QAM, número de subportadoras, prefijo cíclico, canal, SNR, cantidad de símbolos y semilla aleatoria. Pulse **Transmitir y recibir** para ejecutar el enlace. Las vistas muestran formas de onda, constelaciones, respuesta del canal y BER.

La BER es el cociente entre bits errados y bits transmitidos. La semilla aleatoria permite repetir una misma configuración. Los valores mostrados son resultados de simulación en banda base, no mediciones de radio.

## Pruebas y experimentos

En una consola situada en la carpeta del proyecto:

```powershell
.venv\Scripts\python.exe -m pytest -q
.venv\Scripts\python.exe run_all.py --quick
```

Las figuras se guardan en `results/`. Sin `--quick`, los experimentos ejecutan más realizaciones y tardan más.

## Estructura

- `app.py`: interfaz Streamlit.
- `src/ofdm_sim/`: funciones de muestreo, transformadas, OFDM, canal y enlace.
- `experiments/`: análisis y generación de figuras.
- `tests/`: pruebas automatizadas.
- `results/`: resultados gráficos.
- `docs/informe_tecnico.md`: fundamentos, metodología y limitaciones.

## Alcance del modelo

La simulación usa señales complejas de banda base y supone sincronización ideal. El ecualizador conoce la respuesta del canal. No se simulan hardware RF, pilotos ni codificación de canal. La transmisión y el experimento de BER de la interfaz mantienen activado el prefijo cíclico.
