// 双端队列

package test;

public class DequeWithLinkedList<E> {
	// 使用双向链表可以非常方便的实现双端队列
	LinkedList<E> list = new LinkedList<E>();
	
	// 元素的数量
	public int size() {
		return list.size();
	}
	
	// 是否为空
	public boolean isEmpty() {
		return list.isEmpty();
	}
	
	// 从队尾入队
	public void enQueueRear(E element) {
		list.add(element);
	}
	
	// 从对头出队
	public E deQueueFront() {
		return list.remove(0);
	}
	
	// 从队头入队
	public void enQueueFront(E element) {
		list.add(0, element);
	}
	
	// 从队尾出队
	public E deQueueRear() {
		return list.remove(list.size() - 1);
	}
	
	// 获取队头
	public E front() {
		return list.get(0);
	}
	
	// 获取队尾
	public E rear() {
		return list.get(list.size() - 1);
	}
}
