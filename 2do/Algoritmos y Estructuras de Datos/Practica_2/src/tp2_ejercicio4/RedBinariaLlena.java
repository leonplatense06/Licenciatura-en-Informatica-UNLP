/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tp2_ejercicio4;

/**
 *
 * @author rama
 */
import tp2_binary_tree.BinaryTree;
public class RedBinariaLlena {
    private BinaryTree<Integer> ar;
    
    public RedBinariaLlena (){
        
    }
    
    public RedBinariaLlena (BinaryTree<Integer> ar){
        this.ar = ar;
    }
    
    public int retardoReenvio (){
        int ret;
        ret = sumarRetardo(this.ar);
        return ret;
    }
    
    private int sumarRetardo(BinaryTree<Integer> ar){
        if (ar.getData() == null){
            return 0;
        }
        int ladoIzq=0, ladoDer=0;
        
        if (ar.hasLeftChild()){
            ladoIzq = sumarRetardo(ar.getLeftChild());
        }
        if (ar.hasRightChild()){
            ladoDer = sumarRetardo(ar.getRightChild());
        }
        
        return (ar.getData() + Math.max(ladoDer, ladoIzq));
    }
}
