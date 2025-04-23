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
import Act_3_package.Estudiante;
import java.util.List;
import java.util.Scanner;
import java.util.LinkedList;
public class Metodos {
    private static Estudiante cargarEst1(Estudiante est){
        est.setNom("Raul");est.setApe("Crivaro");
        est.setCom("1B");est.setEmail("raul@gmail.com");
        est.setDir("Calle 131");
        return est;               
    }
    private static Estudiante cargarEst2(Estudiante est){
        est.setNom("Lucía");est.setApe("Martínez");
        est.setCom("1B");est.setEmail("lucia@gmail.com");
        est.setDir("Avenida 456");
        return est;
    }
    private static Estudiante cargarEst3(Estudiante est){
        est.setNom("Julian");est.setApe("Marconi");
        est.setCom("2B");est.setEmail("julian@gmail.com");
        est.setDir("Avenida Siempre Viva"); 
        return est;
    }
    
    public static void cargarEstTeclado(Estudiante est){
        Scanner s = new Scanner(System.in);
        String dato;
        System.out.println("Ingrese Nombre del Estudiante: ");dato = s.nextLine();
        est.setNom(dato);        
        System.out.println("Ingrese Apellido del Estudiante: ");dato = s.nextLine();
        est.setApe(dato);
        System.out.println("Ingrese el Email del Estadiante: ");dato = s.nextLine();
        est.setEmail(dato);
        System.out.println("Ingrese la Comision del Estudiante: ");dato = s.nextLine();
        est.setCom(dato);
        System.out.println("Ingrese la Direccion del Estudiante: ");dato = s.nextLine();
        est.setDir(dato);        
    }
    
    public static void metodoGeneral(ArrayList<Estudiante> listEst){
        Estudiante est1 = new Estudiante();
        Estudiante est2 = new Estudiante();
        Estudiante est3 = new Estudiante();
        cargarEst1(est1);cargarEst2(est2);cargarEst3(est3);//normalmente seria un solo metodo que carga un est leido
                                                         //por teclado pero era mucho para ingresar por el teclad asi que lo hice asi
        //cargo el arraylist
        listEst.add(est1);listEst.add(est2);listEst.add(est3);
        //copiar la lista
        ArrayList<Estudiante> listEstCopia = new ArrayList<>(listEst);
        
        System.out.println("Lista Original: ");
        for (Estudiante item : listEst){
            System.out.println(item.getNom() + ".");
        }
        System.out.println("\nLista Copia: ");
        for (Estudiante item : listEstCopia){
            System.out.println(item.getNom() + ".");
        }
        //modificar un dato de lista original
        listEst.get(0).setNom("Simoooooooooooon");
        
        //modifico un objeto estudiante
        est3.setNom("PIIIIIIIIIIRRRRRRLLLLLLOOOOOOOO");
        
        
        System.out.println("Lista Original: ");
        for (Estudiante item : listEst){
            System.out.println(item.getNom() + ".");
        }
        System.out.println("\nLista Copia: ");
        for (Estudiante item : listEstCopia){
            System.out.println(item.getNom() + ".");
        }
        //AMBOS CAMBIOS SE VEN REFLEJADOS EN AMBAS LISTAS
    }
    public static void agregarSinRepetir(ArrayList<Estudiante> listEst, Estudiante est){
           if (!listEst.contains(est)){
               listEst.add(est);
               System.out.println("Agregado!");
           }
           else{
               System.out.println("Estudiante " + est.getNom() + " " + est.getApe() + " ya se encuentra en la lista.");
           }
    }
    
    public static boolean esCapicua(ArrayList<Integer> list){
        int priPos = 0, ultPos = (list.size() -1);
        
        while (priPos < ultPos){
            if (!list.get(priPos).equals(list.get(ultPos))){
                return false;
            }
            priPos++;ultPos--;
        }
        return true;
    }
    
    public static List<Integer> sucesion(int n){
        List<Integer> suc = new ArrayList<>();
        suc.add(n);
        if (n == 1){
            return suc;
        }
        int sig;
        if (n % 2 == 0){
            sig = n/2;
        }
        else { 
            sig = 3*n +1;
        }
        
        suc.addAll(sucesion(sig));
        return suc;       
    }
    
    public static void invertirArrayList(ArrayList<Integer> list){
        if (list.size() <= 1){
            return;
        }
        int aux = list.get(0);
        list.set(0, list.get(list.size() -1));
        list.set(list.size()-1, aux);
        
        ArrayList<Integer> subLista = new ArrayList<>(list.subList(1, list.size()-1));
        invertirArrayList(subLista);
        
        for(int i = 1; i < list.size()-1; i++){
            list.set(i, subLista.get(i - 1));
        }
    }
    
    public static int sumarLinkedList(LinkedList<Integer> list){
        if (list.isEmpty()){
            return 0;
        }
        int valor = list.removeFirst();
        return valor + sumarLinkedList(list);
    }
    
    public static ArrayList<Integer> combinarListasOrdenadas(ArrayList<Integer> list1, ArrayList<Integer> list2){
        int item1, item2;
        ArrayList<Integer> listaCombinada = new ArrayList<>();
        while ((!list1.isEmpty()) & (!list2.isEmpty())){
            if (list1.get(0) < list2.get(0)){
                listaCombinada.add(list1.get(0));
                list1.remove(0);
            }
            else {
                listaCombinada.add(list2.get(0));
                list2.remove(0);
            }
        }
        if (!list1.isEmpty()){
            for (int item : list1){
                listaCombinada.add(item);
            }
        }
        else{
            if (!list2.isEmpty()){
                for (int item : list2){
                    listaCombinada.add(item);
                }
            }
        }
        return (listaCombinada);
    }
}
