package Colas;
import java.util.LinkedList;

public class Queue<T> {
protected LinkedList<T> cola;

	public Queue () {
		cola = new LinkedList<>();
	}
	
	// Encola al final 
	public void enqueue (T dato) {
		cola.addLast(dato);
	}
	
	// Desencola el primero
	public T dequeue () {
		if (cola.isEmpty()) {
			throw new IllegalStateException("La cola está vacía");
		}
		return cola.removeFirst();
	}
	
	// Devuelve el primer elemento
	public T head () {
		if (cola.isEmpty()) {
			throw new IllegalStateException("La cola está vacía");
		}
		return cola.getFirst();
	}
	
	public boolean isEmpty() {
		return cola.isEmpty();
	}
	
	public int size () {
		return cola.size();
	}
	
	public String toString() {
		return cola.toString();
	}
	
}
