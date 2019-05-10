// 双向链表实现的队列

package test;

public class Queue<E> {
	// 队列需要频繁的进行头尾操作，优先使用双向链表实现。
	LinkedList<E> list = new LinkedList<E>();
	
	public int sise() {
		return list.size();
	}
	
	public boolean isEmpty() {
		return list.isEmpty();
	}
	
	// 入队就是在链表尾部添加元素
	public void enQueue(E element) {
		list.add(element);
	}
	
	// 出队就是删除链表头部元素
	public E deQueue() {
		return list.remove(0);
	}
	
	// 获取队头就是获取链表头部元素
	public E front() {
		return list.get(0);
	}
}
