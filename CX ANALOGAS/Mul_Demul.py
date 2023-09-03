import numpy as np
import matplotlib.pyplot as plt

# Parámetros de las señales
amplitud_señal_1 = 1.0
frecuencia_señal_1 = 5.0
amplitud_señal_2 = 0.5
frecuencia_señal_2 = 10.0
frecuencia_portadora = 50.0
tiempo_total = 1.0
tasa_muestreo = 1000.0

# Generar las señales originales
t = np.linspace(0, tiempo_total, int(tiempo_total * tasa_muestreo), endpoint=False)
señal_1 = amplitud_señal_1 * np.sin(2 * np.pi * frecuencia_señal_1 * t)
señal_2 = amplitud_señal_2 * np.sin(2 * np.pi * frecuencia_señal_2 * t)

# Multiplexación: Sumar las señales y modular en frecuencia
señal_compuesta = señal_1 + señal_2
señal_modulada = np.sin(2 * np.pi * frecuencia_portadora * t) * señal_compuesta

# Demultiplexación: Demodular en frecuencia y separar las señales originales
señal_demodulada = señal_modulada * np.sin(2 * np.pi * frecuencia_portadora * t)
señal_recuperada_1 = np.sin(2 * np.pi * frecuencia_señal_1 * t) * señal_demodulada
señal_recuperada_2 = np.sin(2 * np.pi * frecuencia_señal_2 * t) * señal_demodulada

# Graficar las señales
plt.figure(figsize=(12, 6))

plt.subplot(4, 1, 1)
plt.plot(t, señal_1)
plt.title('Señal 1 (Original)')

plt.subplot(4, 1, 2)
plt.plot(t, señal_2)
plt.title('Señal 2 (Original)')

plt.subplot(4, 1, 3)
plt.plot(t, señal_compuesta)
plt.title('Señal Compuesta')

plt.subplot(4, 1, 4)
plt.plot(t, señal_demodulada)
plt.title('Señal Demodulada')

plt.tight_layout()
plt.show()
