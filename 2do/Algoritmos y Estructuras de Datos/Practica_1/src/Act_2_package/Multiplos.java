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
public class Multiplos {
    public static void generadorArray(int[] array, int dimF){
        int mul = 1;
        int dimL = 0;
        while (dimL < dimF){
            array[dimL] = dimF * mul++; //dimF es n (dim fis del vector y son sus multiplos los elementos del array
            dimL++;
        }
    }
}
