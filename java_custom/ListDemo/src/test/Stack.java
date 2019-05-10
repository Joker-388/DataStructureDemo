// 栈

package test;

public class Stack<E> {
	// 栈只需要在表尾进行添加和删除操作，动态数组和双向链表都可以实现，平均复杂度都是O(1)
	private LinkedList<E> list = new LinkedList<E>();
	
	public int size() {
		return list.size();
	}
	
	public boolean isEmpty() {
		return list.isEmpty();
	}
	
	public void push(E element) {
		list.add(element);
	}
	
	public E pop() {
		return list.remove(list.size() - 1);
	}
	
	public E peek() {
		return list.get(list.size() - 1);
	}
}
