/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Act_2_package;

/**
 *
 * @author rama
 */
import java.util.Scanner;
public class Act_2 {
    public static void main(String[] args){
        Scanner s = new Scanner(System.in);
        System.out.println("Ingrese Un Numero Entero: ");
        int n = s.nextInt();
        int[] array = new int[n];
        Multiplos.generadorArray(array, n);
        System.out.println("Vector: ");
        for (int i=0; i < n; i++){
            System.out.print(array[i] + "; ");
        }
        
        
    }
}
