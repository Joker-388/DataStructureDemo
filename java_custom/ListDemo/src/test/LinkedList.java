// 双向链表

package test;

public class LinkedList<E> {
	// 需要提供的外部属性，用来定义如果没有找到一个元素对应的index返回的值
	static final int ELEMENT_NOT_FOUND = -1;
	
	// 用于记录当前链表的长度
	private int size;
	// 用于存储头节点
	private Node<E> first;
	// 用于存储尾节点
	private Node<E> last;
	// 节点的数据结构
	private static class Node<E> {
		// 节点的上一个节点 
		Node<E> prev;
		// 节点中存储的元素
		E element; 
		// 节点的下一个节点
		Node<E> next;
		// 节点的构造方法
		public Node(Node<E> prev, E element, Node<E> next) {
			this.element = element;
			this.next = next;
			this.prev = prev;
		}
		
		@Override
		public String toString() {
			StringBuffer stringBuffer  = new StringBuffer();
			if (prev != null) {
				stringBuffer.append(prev.element);
			} else {
				stringBuffer.append("null");
			}			
			stringBuffer.append("_").append(element).append("_");
			if (next != null) {
				stringBuffer.append(next.element);
			} else {
				stringBuffer.append("null");
			}
			return stringBuffer.toString();
		}
	}
	
	// 单向链表的长度就是size
	public int size() {
		return size;
	}
	
	// isEmpty就是size是否为空
	public boolean isEmpty() {
		return size == 0;
	}
	
	// 包含某个元素就是这个元素在链表中的index不为ELEMENT_NOT_FOUND
	public boolean contains(E element) {
		return indexOf(element) != ELEMENT_NOT_FOUND;
	}
	
	// 表尾添加元素就是向index为size的位置插入元素
	public void add(E element) {
		add(size, element);
	}
	
	// 插入元素
	public void add(int index, E element) {
		rangeCheckForAdd(index);
		// index == size 相当于 插入到表尾 或者 空链表添加第一个节点
		if (index == size) {
			Node<E> oldLast = last;
			Node<E> node = new Node<E>(last, element, null);
			last = node;
			if (oldLast == null) {
				first = last;
			} else {
				oldLast.next = last;
			}
		} else { // 插入到表的非空节点的位置上
			// 被插入的index位置的当前节点，会成为新节点的next
			Node<E> next = node(index);
			// 被插入的index位置的前一个节点，会成为新节点的prev
			// 当插入一个非空链表的index为0的位置时，这个节点为null。
			Node<E> prev = next.prev;
			// 新节点
			Node<E> node = new Node<E>(prev, element, next);
			// 新节点下一个节点的prev指向新节点
			next.prev = node;
			// index == 0的情况
			if (prev == null) { // index == 0
				// 将first指向新节点
				first = node;
			} else {
				// prev的next指向新节点
				prev.next = node;
			}
		}		
		// 插入之后不要忘记size++
		size++;
	}
	
	// 移除指定位置的节点
	public E remove(int index) {
		rangeCheck(index);
		
		// 双向链表删除一个节点
		// 就是将被删除的节点的上一个节点的next指向他的next
		// 将被删除节点的下一个节点的prev指向他的prve
		// 这样被删除节点的引用都断掉，被删除节点自然就被回收了
		// 需要额外处理就是删除头节点和尾节点的特殊情况
		
		// 移除双向链表的节点，需要先或者这个节点
		Node<E> node = node(index);
		// 拿到这个节点的prev
		Node<E> prev = node.prev;
		// 拿到这个节点的next
		Node<E> next = node.next;
		
		if (node == first) {
			// 如果删除的是头节点，将first指针后移
			first = next;
		} else {
			// 如果删除不是头节点，将被删除节点的上一节点的next指向被删除节点的next
			prev.next = next;
		}
		
		if (node == last) {
			// 如果删除的是尾节点，将last指针前移
			last = prev;
		} else {
			// 如果删除不是尾节点，将被删除的节点的下一个节点的prev指向被删除节点的prev
			next.prev = prev;
		}
		
		size--;
		return node.element;
	}
	
	// 移除指定的元素
	public E remove(E element) {
		// 获取这个元素的index
		int index = indexOf(element);
		// 如果链表不包含这个元素，就返回null
		if (index == ELEMENT_NOT_FOUND) {
			return null;
		} else {
			// 如果包含这个元素，就通过它对应的index删除它
			return remove(index);
		}
	}
	
	// 清空链表
	public void clear() {
		size = 0;
		first = null;
		last = null;
	}
	
	// 获取一个元素在链表中的index
	public int indexOf(E element) {
		// 如果element为null，需要通过==判断，防止java空指针错误
		if (element == null) {
			// 遍历所有节点
			Node<E> node = first;
			for(int i = 0; i < size; i++) {
				if (node.element == null) {
					return i;
				}
				node = node.next;
			}
		} else {
			// 不为空的情况用equals方法查找
			// 遍历所有节点
			Node<E> node = first;
			for(int i = 0; i < size; i++) {
				// 用已经非空判断后的element来调用equals方法
				if (element.equals(node.element)) {
					return i;
				}
				node = node.next;
			}
		}
		
		return ELEMENT_NOT_FOUND;
	}
	
	public E get(int index) {
		return node(index).element;
	}
	
	public E set(int index, E element) {
		Node<E> node = node(index);
		E old = node.element;
		node.element = element;
		return old;
	}
	
	// 通过index获取链表中对应的节点
	private Node<E> node(int index) {
		rangeCheck(index);
		// 遍历链表元素知道找到对应的节点
		if (index < (size >> 1)) {
			Node<E> node = first;
			for (int i = 0; i < index; i++) {
				node = node.next;
			}
			return node;
		} else {
			 Node<E> node = last;
			 for (int i = size - 1; i > index; i--) {
				node = node.prev;
			 }
			 return node;
		}
	}
	
	private void outOfBounds(int index) {
		throw new IndexOutOfBoundsException("Index:" + index + ", Size:" + size);
	}
	
	private void rangeCheck(int index) {
		if (index < 0 || index >= size) {
			outOfBounds(index);
		}
	}
	
	private void rangeCheckForAdd(int index) {
		if (index < 0 || index > size) {
			outOfBounds(index);
		}
		
	}
	
	@Override
	public String toString() {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("Size:").append(size).append(" [");
		Node<E> node = first;
		for (int i = 0; i < size; i++) {
			if (i != 0) {
				stringBuffer.append(", ");
			}
			stringBuffer.append(node);
			node = node.next;
		}
		stringBuffer.append("]");
		return stringBuffer.toString();
	}
}
