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
public class proces {
    public static int[] minMaxProm(int[] v){
        int sum = 0, max = Integer.MIN_VALUE, min = Integer.MAX_VALUE;
        for (int item : v){
            sum += item;
            if (item > max){
                max = item;
            }
            if (item < min){
                min = item;
            }
        }
        int [] vec = {max, min, sum/v.length};
        return vec;
    }
    public static Enteros minMaxPromObj(int[] v, Enteros obj){
        obj.Max = Integer.MIN_VALUE;obj.Min= Integer.MAX_VALUE;
        obj.Prom = 0;
        for (int item : v){
            if (item < obj.Min){
                obj.Min = item;
            }
            if (item > obj.Max){
                obj.Max = item;
            }
            obj.Prom += item;
        }
        obj.Prom = obj.Prom / v.length;
        return null;
    }
}
