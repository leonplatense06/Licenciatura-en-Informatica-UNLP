import random
import sys
 # Preguntas para el juego
questions = [
 "¿Qué función se usa para obtener la longitud de una cadena en Python?",
 "¿Cuál de las siguientes opciones es un número entero en Python?",
 "¿Cómo se solicita entrada del usuario en Python?",
 "¿Cuál de las siguientes expresiones es un comentario válido en Python?",
 "¿Cuál es el operador de comparación para verificar si dos valores son iguales?",
 ]
 # Respuestas posibles para cada pregunta, en el mismo orden que las preguntas
answers = [
 ("size()", "len()", "length()", "count()"),
 ("3.14", "'42'", "10", "True"),
 ("input()", "scan()", "read()", "ask()"),
 (
 "// Esto es un comentario",
 "/* Esto es un comentario */",
 "-- Esto es un comentario",
 "# Esto es un comentario",
 ),
 ("=", "==", "!=", "==="),
 ]
 # Índice de la respuesta correcta para cada pregunta, el el mismo orden que las preguntas
correct_answers_index = [1, 2, 0, 3, 1]

 # formo lista de 3 tuplas sin repetirlas (para que no se repita la misma pregunta),
 # cada tupla contiene una pregunta, sus opciones, y su respuesta correcta, es decir, las agrupe
questions_to_ask = random.sample(list(zip(questions, answers, correct_answers_index)), k=3)

puntaje = 0.0
# El usuario deberá contestar 3 preguntas
for quest, options, correct_ans in questions_to_ask:
 # Se muestra la pregunta y las respuestas posibles
    print(quest)
    for i, answer in enumerate(options):
        print(f"{i + 1}. {answer}")
 # El usuario tiene 2 intentos para responder correctamente
    for intento in range(2):
        user_answer = input("Respuesta: ")
 # Verificar si la respuesta del usuario no es un numero
        if not(user_answer.isnumeric()):
            print("Respuesta no válida")
            sys.exit(1)
        else:
            user_answer = int(user_answer) - 1
 # Se verifica si la respuesta del usuario es "posible"
            if (user_answer >= 0) & (user_answer < 4): 
 # Se verifica si la respuesta es correcta
                if user_answer == correct_ans:
                    print("¡Correcto!")
                    puntaje += 1.0
                    break
                else:
 # Si el usuario no responde correctamente después de 2 intentos,
 # se muestra la respuesta correcta
                    puntaje -= 0.5
                    print("Incorrecto. La respuesta correcta es:")
                    print(options[correct_ans])
 # Si la respesta del usuario no es "posible"
            else:
                print("Respuesta no válida.")
                sys.exit(1)
 # Se imprime un blanco al final de la pregunta
    print()

# Se muestra el puntaje final
if (puntaje < 0.0):
    puntaje = 0.0
print(f"Obtuviste {puntaje:.1f} puntos.")
