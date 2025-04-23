/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tp2_ejercicio6;

/**
 *
 * @author rama
 */
import tp2_binary_tree.BinaryTree;
public class Transformacion {
    private BinaryTree<Integer> ar;
    
    public Transformacion(){
        
    }
    public Transformacion(BinaryTree<Integer> ar){
        this.ar = ar;
    }    
    
    public BinaryTree<Integer> suma(){
        hacerLaSuma(this.ar);
        return this.ar;
    }
    
    private int hacerLaSuma(BinaryTree<Integer> ab){
        if (ab.getData() == null){
            return 0;
        }
        
        int sumaIzq = hacerLaSuma(ab.getLeftChild());
        int sumaDer = hacerLaSuma(ab.getRightChild());
        
        int valorAct = ab.getData();
        
        ab.setData(sumaIzq + sumaDer);
        
        return valorAct + sumaIzq + sumaDer;
        
    }
}
