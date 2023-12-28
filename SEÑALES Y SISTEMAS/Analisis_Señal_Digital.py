import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft

def analyze_digital_signal(time, signal):
    # Calcular la Transformada de Fourier
    fft_result = fft(signal)
    frequencies = np.fft.fftfreq(len(time), d=(time[1] - time[0]))

    # Encontrar la frecuencia dominante
    dominant_frequency = np.abs(frequencies[np.argmax(np.abs(fft_result))])

    # Calcular el período
    period = 1 / dominant_frequency if dominant_frequency != 0 else float('inf')

    # Calcular el ciclo de trabajo
    duty_cycle = np.sum(signal) / len(signal)

    return dominant_frequency, period, duty_cycle

# Señal de ejemplo
signal = np.array([1, 1, 0, 1, 0,0,1,0,1])
time = np.arange(0, len(signal), 1)

# Visualizar la señal
plt.step(time, signal, where='post')
plt.xlabel('Time')
plt.ylabel('Signal Value')
plt.title('Digital Signal Analysis')

# Analizar la señal
dominant_frequency, period, duty_cycle = analyze_digital_signal(time, signal)

print(f'Dominant Frequency: {dominant_frequency} Hz')
print(f'Period: {period} seconds')
print(f'Duty Cycle: {duty_cycle}')

plt.show()
