// 循环双端队列

package test;

@SuppressWarnings("unchecked")
public class DequeWithArrayList<E> {
	private int front;
	private int size;
	private E[] elements;
	private static final int DEFAULT_CAPACITY = 5;
	
	public DequeWithArrayList() {
		elements = (E[]) new Object[DEFAULT_CAPACITY];
	}
	
	public int size() {
		return size;
	}
	
	public boolean isEmpty() {
		return size == 0;
	}

	// 从尾部入队
	public void enQueueRear(E element) {
		ensureCapacity(size + 1);
		elements[index(size)] = element;
		size++;
	}
	
	// 从头部出队
	public E deQueueFront() {
		E frontElement = elements[front];
		elements[front] = null;
		front = index(1);
		size--;
		return frontElement;
	}
	
	// 从头部入队
	// 从队列头部入队，那么front需要前移动一位，如果front已经无法继续前移
	// 那么需要退到数组的尾部循环向前移动
	public void enQueueFront(E element) {
		ensureCapacity(size + 1);
		front = index(-1);
		elements[front] = element;
		size++;
	}
	
	// 从尾部出队
	public E deQueueRear() {
		int rearIndex = index(size - 1);
		E rear = elements[rearIndex];
		elements[rearIndex] = null;
		size--;
		return rear;
	}
	
	public E front() {
		return elements[front];
	}
	
	
	public E rear() {
		return elements[index(size - 1)];
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
		if (index < 0) {
			return index + elements.length;
		}
		// n >= 0 , m> 0, n < 2m。 n % m 等价于 n - (m > n ? 0 : m)
		return index - (elements.length > index ? 0 : elements.length);
	}
}
