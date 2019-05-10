// 单向循环链表

package test;

public class SingleCircleLinkedList<E> {
	// 需要提供的外部属性，用来定义如果没有找到一个元素对应的index返回的值
	static final int ELEMENT_NOT_FOUND = -1;
	
	// 用于记录当前链表的长度
	private int size;
	// 用于存储头节点
	public Node<E> first;
	// 节点的数据结构
	public static class Node<E> {
		// 节点中存储的元素
		E element; 
		// 节点的下一个节点
		Node<E> next;
		// 节点的构造方法
		public Node(E element, Node<E> next) {
			this.element = element;
			this.next = next;
		}
		
		@Override
		public String toString() {
			StringBuffer stringBuffer  = new StringBuffer();
			stringBuffer.append(element).append("_");
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
	// 单向循环链表中，相比单向链表需要在插入表头的时候，重新连尾节点的next指向新的first
	public void add(int index, E element) {
		rangeCheckForAdd(index);
		
		// 表头插入需要特殊处理
		// 单向循环链表中，要重新将最末尾的节点的next指向新的first
		if (index == 0) {
			Node<E> node = new Node<E>(element, first);
			// 获取末尾节点一定要在重置first指针之前做，不然出现错误
			Node<E> last = (size == 0) ? node : node(size - 1);
			last.next = node;
			first = node;
		} else {
			// 添加一个节点需要得到当前index位置节点的上一个节点
			// 然后新节点的next指向当前位置的节点
			// 上一个节点next指向新节点
			Node<E> prev = node(index - 1);
			Node<E> node = new Node<E>(element, prev.next);
			prev.next = node;
		}
		// 插入之后不要忘记size++
		size++;
	}
	
	// 移除指定位置的节点
	// 单向循环链表中，相比单向链表需要在移除头节点的时候，额外进行处理
	public E remove(int index) {
		rangeCheck(index);
		
		Node<E> node = first;
		// 移除头节点，就是改变fist的指向fist的next
		if (index == 0) {
			// 如果size == 1，移除头节点直接将first置空，因为first = first.next相当于没操作
			if (size == 1) {
				first = null;
			} else {
				// 移除头节点，需要获取当前的尾节点
				Node<E> last = node(size - 1);
				// first指针后移
				first = first.next;
				// 尾节点的next指向新的first
				last.next = first;
			}
		} else {
			// 非表头插入元素就是获取这个index对应节点的上一个节点
			// 然后让上一个节点的next指向这个节点的next
			Node<E> prev = node(index - 1);
			node = prev.next;
			prev.next = node.next;
		}
		// 删除之后不要忘记size--
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
		// 遍历链表所有元素知道找到对应的节点
		Node<E> node = first;
		for (int i = 0; i < index; i++) {
			node = node.next;
		}
		return node;
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
