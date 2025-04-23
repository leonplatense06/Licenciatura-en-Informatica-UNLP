lista = [1, 2, 3, 4, 55, 65, 7, 8, 9, 11, 23, 45, 67, 89, 100]
lista_impares = []
lista_pares = []

for i in lista:
    if not(i % 2) == 0:
        lista_impares.append(i)
    else:
        lista_pares.append(i)

print("Los Impares son: ", lista_impares)
print("Los Pares son: ", lista_pares)