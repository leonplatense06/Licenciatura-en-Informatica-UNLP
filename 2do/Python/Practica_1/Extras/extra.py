def menu():
    """Esta Funcion Muestra en Pantalla el Menu Principal del Programa, y noo Retorna un Valor
    Hasta que Este sea Valido."""
    op = input("""\nSeleccione Que Tarea Desea Realizar:
----------------------------
    1- Agregar Producto.
    2- Eliminar Producto.
    3- Ver Inventario.
    4- Salir.
----------------------------
    Eleccion: """)
    return (int(op)) if ((op.isnumeric()) and ((int(op) > 0) and (int(op) < 5))) else menu()
 # python tiene circuito corto asi que no pasa nada, si no es numerico no se va a pasar a int para
 # chequear la segunda cond.

def addProd():
    """Esta Funcion Agrega un Produco al Inventario, o en Caso de que Este Ya Exista, Incrementa
    Su Cantidad en el Valor Indicado."""
    nom = input("Nombre del Producto: ")
    cant = int(input("Cantidad: "))
    if (nom in inventario):
        print("""\n----------------------------
El Producto Ya se Encuentra en el Inventario,
la Cantidad Indicada se Sumara a la Existente.
----------------------------\n""")
        inventario[nom] += cant
    else:
        inventario[nom] = cant
        print("\n----------------------------\nProducto Agregado.\n----------------------------")
    return

def removeProd():
    """Esta Funcion Elimina un Producto del Inventario Solo Si Este Existe, de lo Contrario, lo Informa y No Hace Nada"""
    nom = input("Nombre del Producto: ")
    if (nom in inventario):
        del inventario[nom]
        print("\n----------------------------\nProducto Eliminado.\n----------------------------")
    else:
        print("\n----------------------------\nEl Producto No se Encuentra en el Inventario.\n----------------------------")
    return

def showInv():
    """Esta Funcion Imprime en Pantalla el Inventario"""
    print(f"\n----------------------------\nInventario:\n{inventario}\n----------------------------")
    return

inventario = {   
}

 # eleccion del user
option = menu()
while (option != 4):
    match option:
        case 1:
            addProd()
        case 2:
            removeProd()
        case 3:
            showInv()
    option = menu()
print("----------------------------\nEjecucion Finalizada.\n----------------------------")