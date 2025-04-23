package tp2_binary_tree;


import Colas.Queue;
import java.util.LinkedList;
public class BinaryTree <T> {
	
	private T data;
	private BinaryTree<T> leftChild;   
	private BinaryTree<T> rightChild; 

	
	public BinaryTree() {
		super();
	}

	public BinaryTree(T data) {
		this.data = data;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
	/**
	 * Preguntar antes de invocar si hasLeftChild()
	 * @return
	 */
	public BinaryTree<T> getLeftChild() {
		return leftChild;
	}
	/**
	 * Preguntar antes de invocar si hasRightChild()
	 * @return
	 */
	public BinaryTree<T> getRightChild() {
		return this.rightChild;
	}

	public void addLeftChild(BinaryTree<T> child) {
		this.leftChild = child;
	}

	public void addRightChild(BinaryTree<T> child) {
		this.rightChild = child;
	}

	public void removeLeftChild() {
		this.leftChild = null;
	}

	public void removeRightChild() {
		this.rightChild = null;
	}

	public boolean isEmpty(){
		return (this.isLeaf() && this.getData() == null);
	}

	public boolean isLeaf() {
		return (!this.hasLeftChild() && !this.hasRightChild());

	}
		
	public boolean hasLeftChild() {
		return this.leftChild!=null;
	}

	public boolean hasRightChild() {
		return this.rightChild!=null;
	}
	@Override
	public String toString() {
		return this.getData().toString();
	}

	public int contarHojas(){
            if (this.getData() == null){
                return 0;
            }
            if (this.isLeaf()){
                return 1;
            }
            int ladoIzquierdo = 0;
            int ladoDerecho = 0;
            if (this.hasLeftChild()){
                ladoIzquierdo = this.getLeftChild().contarHojas();
            }
            if (this.hasRightChild()){
                ladoDerecho = this.getRightChild().contarHojas();
            }            
            return (ladoIzquierdo + ladoDerecho);
	}
		
		
    	 
    public BinaryTree<T> espejo(){
        if (this.getData() == null){
            return null;
        }
        BinaryTree<T> mirror = new BinaryTree<>(this.getData());
        if (this.hasRightChild()){
            mirror.addLeftChild(this.getRightChild().espejo());
        }
        if (this.hasLeftChild()){
            mirror.addRightChild(this.getLeftChild().espejo());
        }
      
 	return mirror;
    }

	// 0<=n<=m
	public void entreNiveles(int n, int m){
            //ESTO ES 'POR NIVELES', ESTO PEDIA 'ENTRE NIVELES'
            //ESTO ES 'POR NIVELES', ESTO PEDIA 'ENTRE NIVELES'
            //ESTO ES 'POR NIVELES', ESTO PEDIA 'ENTRE NIVELES'
            
            if (this.isEmpty()){
                return;
            }
            Queue<BinaryTree<T>> cola = new Queue<>();
            cola.enqueue(this);
            while (!cola.isEmpty()){
                BinaryTree<T> nodoAct = cola.dequeue();
                System.out.println(nodoAct.getData() + " ");
                if (nodoAct.hasLeftChild()){
                    cola.enqueue(nodoAct.getLeftChild());
                }
                if (nodoAct.hasRightChild()){
                    cola.enqueue(nodoAct.getRightChild());
                }
            }
   } 
		
}

