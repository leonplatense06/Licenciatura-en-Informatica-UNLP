ingreso = input("Ingrese numeros: ")
lista = []

for elem in ingreso.split():
    lista.append(int(elem))

for elem in lista:
    if elem < 0:
        break
    print(elem)