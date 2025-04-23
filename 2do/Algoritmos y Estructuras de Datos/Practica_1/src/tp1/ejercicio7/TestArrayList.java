/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tp1.ejercicio7;

/**
 *
 * @author rama
 */
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import Act_3_package.Estudiante;
import java.util.LinkedList;


public class TestArrayList {
    public static void main(String[] args){
        Scanner s = new Scanner(System.in);
        String op;
        ArrayList<Integer> listNums = new ArrayList<>();
        ArrayList<Estudiante> listEst = new ArrayList<>();
        LinkedList<Integer> listaLink = new LinkedList<>();
        List<Integer> sucList;
        
        System.out.print("Ingrese Un Numero Entero (" + Integer.MAX_VALUE + " para Terminar): ");
        Integer num = s.nextInt();
        while (num != Integer.MAX_VALUE){
            listNums.add(num);
            System.out.print("Ingrese Un Numero En tero (" + Integer.MAX_VALUE + " para Terminar): ");
            num = s.nextInt();
        }
        System.out.println("Lista De Numeros: ");
        for (Integer item : listNums){
            System.out.println(item + ".");
        }
        Metodos.metodoGeneral(listEst);
        System.out.print("Desea Agregar un Estudiante a la Lista? [y/n]: ");
        op = s.next();
        if (op.toLowerCase().equals("y")){
            System.out.println("---------------------");
            System.out.println("Agregar un Estudiante.");
            Estudiante nueEst = new Estudiante();
            //leer estudiante
            Metodos.cargarEstTeclado(nueEst);
            //agregar estudiante chequeando que no se repita
            Metodos.agregarSinRepetir(listEst, nueEst);
        }
        
        //informar si listNums es capicua
        System.out.println(Metodos.esCapicua(listNums));
        
        //formar lista de sucesion
        sucList = Metodos.sucesion(6);
        //imprimirla
        System.out.print("Sucesion: ");
        for (int item : sucList){
            System.out.print(item + ", ");
        }
        System.out.println("");
        //invertir array
        Metodos.invertirArrayList(listNums);
        //imprimirlo
        System.out.print("Array Nums Invertido: ");
        for (int item : listNums){
            System.out.print(item + ", ");
        }
        
        //sumatoria de una LinkedList
        //le meto valores a la lista
        listaLink.add(4);listaLink.add(4);listaLink.add(4);listaLink.add(4);
        int valor = Metodos.sumarLinkedList(listaLink);
        System.out.println("");
        System.out.println("Sumatoria: " + valor);
        
        //combinar dos listas ordenadas formando otra lista ordenada
        ArrayList<Integer> list1 = new ArrayList<>();
        list1.add(2);list1.add(4);list1.add(15);list1.add(27);list1.add(43);list1.add(90);
        ArrayList<Integer> list2 = new ArrayList<>();
        list2.add(20);list2.add(44);list2.add(57);list2.add(77);list2.add(83);list2.add(92);
        ArrayList<Integer> listaCombinada = new ArrayList<>(Metodos.combinarListasOrdenadas(list1, list2));
        //imprimir lista ocombinada y ordenada
        System.out.println("");
        System.out.print("Lista Combinada: " + listaCombinada);
    }
}
