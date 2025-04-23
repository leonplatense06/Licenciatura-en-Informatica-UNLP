/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tp2_ejercici3;

import tp2_binary_tree.BinaryTree;
import java.util.ArrayList;

public class ContadorArbol {
    private BinaryTree<Integer> ab;
    
    public ContadorArbol (){
        
    }
    
    public ContadorArbol (BinaryTree<Integer> abRecibido){
        this.ab = abRecibido;
    }
    
    public ArrayList<Integer> numerosParesInOrden(){
        ArrayList<Integer> list = new ArrayList<>();
        inOrden(ab, list);
        return list;
    }
    
    private void inOrden(BinaryTree<Integer> ar, ArrayList<Integer> list){
        if (ar.getData() == null){
            return;
        }
        if (ab.hasLeftChild()){
            inOrden(ar.getLeftChild(), list);
        }
        if (ar.getData() != null && ar.getData() % 2 == 0){
            list.add(ar.getData());
        }
        if (ab.hasRightChild()){
            inOrden(ar.getRightChild(), list);
        }
    }
    
    public ArrayList<Integer> numerosParesPostOrden(){
        ArrayList<Integer> list = new ArrayList<>();
        postOrden(ab, list);
        return list;
    }
    
    private void postOrden(BinaryTree<Integer> ar, ArrayList<Integer> list){
        if (ar.getData() == null){
            return;
        }
        if (ar.hasLeftChild()){
            postOrden(ar.getLeftChild(), list);
        }
        if (ar.hasRightChild()){
            postOrden(ar.getRightChild(), list);
        }
        list.add(ar.getData());
    }
}
