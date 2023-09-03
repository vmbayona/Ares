import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import firwin, lfilter

# Parámetros de la señal
tiempo_total = 1.0
tasa_muestreo = 1000.0
frecuencia_corte = 50.0  # Frecuencia de corte del filtro en Hz

# Generar una señal de prueba (una suma de dos sinusoides)
t = np.linspace(0, tiempo_total, int(tiempo_total * tasa_muestreo), endpoint=False)
señal = np.sin(2 * np.pi * 100.0 * t) + 0.5 * np.sin(2 * np.pi * 300.0 * t)

# Diseñar un filtro FIR
orden_filtro = 63
coeficientes_filtro = firwin(orden_filtro, frecuencia_corte / (tasa_muestreo / 2))

# Aplicar el filtro FIR a la señal
señal_filtrada = lfilter(coeficientes_filtro, 1.0, señal)

# Graficar las señales
plt.figure(figsize=(12, 6))

plt.subplot(3, 1, 1)
plt.plot(t, señal)
plt.title('Señal Original')

plt.subplot(3, 1, 2)
plt.plot(coeficientes_filtro)
plt.title('Respuesta del Filtro FIR')

plt.subplot(3, 1, 3)
plt.plot(t, señal_filtrada)
plt.title('Señal Filtrada')

plt.tight_layout()
plt.show()
