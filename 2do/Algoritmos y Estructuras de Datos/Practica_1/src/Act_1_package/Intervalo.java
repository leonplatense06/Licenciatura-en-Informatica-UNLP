/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Act_1_package;

public class Intervalo {
    public static void conFor(int a, int b){
        for (int i=a;i <= b;i++){
            System.out.println(i);
        }
    }
    public static void conWhile(int a, int b){
        int i = a;
        while (i <= b){
            System.out.println(i++);
        }
    }
    public static void conRecursion(int a, int b){
        if (a > b){
            return;
        }
        else{
            System.out.println(a);
            conRecursion(a+1, b);
        }
    }
}