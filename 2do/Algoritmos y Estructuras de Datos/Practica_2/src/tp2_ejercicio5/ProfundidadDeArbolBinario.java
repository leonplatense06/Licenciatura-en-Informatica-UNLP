/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tp2_ejercicio5;

import tp2_binary_tree.BinaryTree;
public class ProfundidadDeArbolBinario {
    private BinaryTree<Integer> ar;
    
    public ProfundidadDeArbolBinario(){
        
    }
    public ProfundidadDeArbolBinario(BinaryTree<Integer> ar){
        this.ar = ar;
    }
    
    public int sumaElementosProfundidad(int p){
        if (ar.getData() == null){
            return 0;
        }
        return sumaElemProf(ar, p, 0);
    }
    
    private int sumaElemProf(BinaryTree<Integer> nodo, int p, int prof){
        if (nodo == null){
            return 0;
        }
        if (prof == p){
            return ar.getData();
        }
        
        return sumaElemProf(ar.getRightChild(), p, prof+1) + sumaElemProf(ar.getLeftChild(), p, prof+1);
    }
}
