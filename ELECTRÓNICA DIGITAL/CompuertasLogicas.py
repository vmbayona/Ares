import matplotlib.pyplot as plt
import numpy as np

def and_gate(a, b):
    return a and b

def or_gate(a, b):
    return a or b

def xor_gate(a, b):
    return a != b

def not_gate(a):
    return not a

def plot_truth_table(gate_function, gate_name, negated=False):
    fig, ax = plt.subplots()
    ax.axis('tight')
    ax.axis('off')

    if negated:
        table_data = [
            ['A', '~A', f'{gate_name}(A, ~A)']
        ]
    else:
        table_data = [
            ['A', 'B', f'{gate_name}(A, B)']
        ]

    for a in [0, 1]:
        if negated:
            result = gate_function(a)
            table_data.append([str(a), str(not a), str(result)])
        else:
            for b in [0, 1]:
                result = gate_function(a, b)
                table_data.append([str(a), str(b), str(result)])

    ax.table(cellText=table_data, colLabels=None, cellLoc='center', loc='center')
    plt.title(f"Tabla de verdad para la compuerta lógica {gate_name}")
    plt.show()

# Tabla de verdad para la compuerta AND
plot_truth_table(and_gate, "AND")

# Tabla de verdad para la compuerta OR
plot_truth_table(or_gate, "OR")

# Tabla de verdad para la compuerta XOR
plot_truth_table(xor_gate, "XOR")

# Tabla de verdad para la compuerta NOT
plot_truth_table(not_gate, "NOT", negated=True)
