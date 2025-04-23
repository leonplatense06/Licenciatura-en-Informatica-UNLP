/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Act_1_package;

/**
 *
 * @author rama
 */
public class Act_1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        int a = 3;
        int b = 8;
        System.out.println("Intervalo con For: ");Intervalo.conFor(a, b);System.out.println();
        System.out.println("Intervalo con While: ");Intervalo.conWhile(a, b);System.out.println();
        System.out.println("Intervalor Recursivo: ");Intervalo.conRecursion(a, b);System.out.println();
        
    }
    
}
