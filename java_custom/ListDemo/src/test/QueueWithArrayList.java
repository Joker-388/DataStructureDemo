// 循环队列

package test;

// 队列底层也可以使用动态数组实现，并且将各项接口优化为O(1)
// 如果不优化，出队的时候需要删除数组第一个元素，那么就需要将数组后面的每一个元素都前移一位，出队的复杂度为O(n)
@SuppressWarnings("unchecked")
public class QueueWithArrayList<E> {
	private int front;
	private int size;
	private E[] elements;
	private static final int DEFAULT_CAPACITY = 10;
	
	public QueueWithArrayList() {
		elements = (E[]) new Object[DEFAULT_CAPACITY];
	}
	
	public int size() {
		return size;
	}
	
	public boolean isEmpty() {
		return size == 0;
	}
	
	public void enQueue(E element) {
		ensureCapacity(size + 1);
		
		elements[index(size)] = element; // (front + size) % elements.length
		size++;
	}
	
	public E deQueue() {
		E frontElementE = elements[front];
		elements[front] = null;
		front = index(1); // (front + 1) % elements.length
		size--;
		return frontElementE;
	}
	
	public E front() {
		return elements[front];
	}
	
	private void ensureCapacity(int capacity) {
		int oldCapacity = elements.length;
		if (oldCapacity >= capacity) {
			return;
		}
		
		int newCapacity = oldCapacity + (oldCapacity >> 1);
		E[] newElements = (E[]) new Object[newCapacity];
		for (int i = 0; i < size; i++) {
			newElements[i] = elements[index(i)]; // (front + i) % elements.length
		}
		elements = newElements;
		front = 0;
	}
	
	@Override
	public String toString() {
		StringBuilder string = new StringBuilder();
		string.append("capcacity=").append(elements.length)
		.append(" size=").append(size)
		.append(" front=").append(front)
		.append(", [");
		for (int i = 0; i < elements.length; i++) {
			if (i != 0) {
				string.append(", ");
			}
			
			string.append(elements[i]);
		}
		string.append("]");
		return string.toString();
	}
	
	private int index(int index) {
		index += front;
		// n >= 0 , m> 0, n < 2m。 n % m 等价于 n - (m > n ? 0 : m)
		return index - (elements.length > index ? 0 : elements.length);
	}
}
