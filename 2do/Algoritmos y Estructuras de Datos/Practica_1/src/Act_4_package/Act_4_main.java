/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Act_4_package;

/**
 *
 * @author rama
 */
public class Act_4_main {
    public static int Max = Integer.MIN_VALUE;
    public static int Min = Integer.MAX_VALUE;
    public static int Prom = 0;
    public static int[] vecGlob = {23, 56, 12, 89, 45, 37, 78, 64, 15, 92};
    public static void minMaxPromSinParametros(){
        for (int item : vecGlob){
            if (item < Min){
                Min = item;
            }
            if (item > Max){
                Max = item;
            }
            Prom += item;
        }
        Prom = Prom / vecGlob.length;
    }
    public static void main(String[] args){
        int[] vec = {23, 56, 12, 89, 45, 37, 78, 64, 15, 92};
        int[] vecReturned;
        Enteros obj = new Enteros();
        
        vecReturned = proces.minMaxProm(vec);
        System.out.println("VECTOR:");
        System.out.println("Maximo: " + vecReturned[0]);
        System.out.println("Minimo: " + vecReturned[1]);
        System.out.println("Promedio: " + vecReturned[2]);
        
        proces.minMaxPromObj(vec, obj);
        System.out.println("OBJETO:");
        System.out.println("Maximo: " + obj.Max);
        System.out.println("Minimo: " + obj.Min);
        System.out.println("Promedio: " + obj.Prom);
        
        minMaxPromSinParametros();
        System.out.println("SIN PARAMETROS NI RETURN:");
        System.out.println("Maximo: " + Max);
        System.out.println("Minimo: " + Min);
        System.out.println("Promedio: " + Prom);        
    }
}