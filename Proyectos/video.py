import mediapipe as mp
import pyautogui
import cv2

# Inicializar mediapipe
mp_drawing = mp.solutions.drawing_utils
mp_hands = mp.solutions.hands

# Inicializar pyautogui
screen_width, screen_height = pyautogui.size()

# Inicializar la captura de video
cap = cv2.VideoCapture(0)

# Variable para el estado de la mano (abierta o cerrada) con suavizado
alpha = 0.2  # Factor de suavizado
hand_open_smoothed = False

with mp_hands.Hands(min_detection_confidence=0.5, min_tracking_confidence=0.5) as hands:
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        # Convertir la imagen a RGB
        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

        # Obtener resultados de la detección de manos
        results = hands.process(rgb_frame)

        # Asegurarse de que se hayan detectado manos
        if results.multi_hand_landmarks:
            for hand_landmarks in results.multi_hand_landmarks:
                # Obtener la posición de la punta del dedo índice
                index_finger_tip = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                index_finger_x, index_finger_y = int(index_finger_tip.x * screen_width), int(index_finger_tip.y * screen_height)

                # Obtener la posición de la punta del pulgar
                thumb_tip = hand_landmarks.landmark[mp_hands.HandLandmark.THUMB_TIP]
                thumb_tip_x, thumb_tip_y = int(thumb_tip.x * screen_width), int(thumb_tip.y * screen_height)

                # Mover el mouse a la posición del dedo índice
                pyautogui.moveTo(index_finger_x, index_finger_y)

                # Dibujar los landmarks de la mano en el frame
                mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

                # Verificar si la mano está cerrada (punta del pulgar a la izquierda del índice)
                hand_open = thumb_tip_x < index_finger_x

                # Aplicar suavizado exponencial
                hand_open_smoothed = alpha * hand_open + (1 - alpha) * hand_open_smoothed

                # Imprimir las coordenadas de la punta del dedo índice y la punta del pulgar
                print(f"Index Finger: ({index_finger_x}, {index_finger_y}) | Thumb Tip: ({thumb_tip_x}, {thumb_tip_y})")

                # Realizar clic si la mano está cerrada
                if not hand_open_smoothed:
                    pyautogui.click()

        # Maximizar la ventana si la mano está abierta
        if hand_open_smoothed:
            pyautogui.hotkey('winleft', 'up')  # Maximizar la ventana en Windows

        # Mostrar el frame
        cv2.imshow("Hand Tracking", frame)

        # Salir del bucle si se presiona 'q'
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

# Liberar recursos
cap.release()
cv2.destroyAllWindows()
