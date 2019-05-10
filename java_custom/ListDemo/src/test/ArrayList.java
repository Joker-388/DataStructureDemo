// 动态数组

package test;

@SuppressWarnings("unchecked")
public class ArrayList<E> {
	private static final int DEFAULT_CAPACITY = 10;
	static final int ELEMENT_NOT_FOUND = -1;
	private int size;
	
	// 动态数组
	private E[] elements;
	
	// 构造方法
	public ArrayList(int capacity) {
		capacity = (capacity < DEFAULT_CAPACITY) ? DEFAULT_CAPACITY : capacity;
		elements = (E[]) new Object[capacity];
	}
	
	public ArrayList() {
		this(DEFAULT_CAPACITY);
	}
	
	// 清空数组
	public void clear() {
		// 清空数组需要将数组内置空，释放数组中指向对象的内存
		for (int i = 0; i < size; i++) {
			elements[i] = null;
		}
		// 清空数组后size 为0
		size = 0;
	}
	
	// 一个对象在数组的index，如果未找到则返回ELEMENT_NOT_FOUND
	public int indexOf(E element) {
		if (element == null) { 
			// 先判断要查找的对象是否为空，为空则返回数组中的第一个空元素的index
			for (int i = 0; i < size; i++) {
				if (elements[i] == null) return i;
			}
		} else {
			// 要查找的对象不为空，遍历数组查找相等的对象的index
			for (int i = 0; i < size; i++) {
				// 用已经通过非空判断的查找的对象调用equals方法，方式空指针异常
				if (element.equals(elements[i])) return i;
			}
		}
		// 未找到匹配的对象，返回ELEMENT_NOT_FOUND
		return ELEMENT_NOT_FOUND;
	}
	
	// 通过数组的index位置添加一个元素
	// 最好复杂度：O(1)，添加到数组末尾，即index = size，这时不需要挪动元素
	// 最坏复杂度：O(n)，添加到数组头部，即index = 0，这时需要依次挪动所有元素
	// 平均复杂度：O(n)
	public void add(int index, E element) {
		// 越界检查
		rangeCheckForAdd(index);
		// 确保数组容量，不足则扩容
		// 复杂度分析：添加到数组末尾时，不需要扩容的情况下，最好复杂度O(1)，
		// 当需要扩容时，最好复杂度为O(n)，因为需要依次将元素复制到新数组
		// 但是扩容不是每次必须的操作，均摊复杂度依然为O(1),平均复杂度O(1)
		// 所以当在数组末尾添加元素时，复杂度可以计算成O(1)
		// 在其他位置添加元素时，也是如果，在计算时间复杂度不会给复杂度添加额外时间
		ensureCapacity(size + 1);
		// 先将从index起的元素全部后移一位，从数组尾部开始移动
		for (int i = size; i > index; i--) {
			elements[i] = elements[i - 1];
		}
		// 设置jndex位置的元素
		elements[index] = element;
		// 添加成功后size加1
		size++;
	}
	
	// 删除元素
	// 最好复杂度：O(1)，即index = size - 1，需要挪动元素
	// 最坏复杂度：O(n)，即index = 0，需要挪动所有元素 
	// 平均复杂度：O(n)
	public E remove(int index) {
		// 越界检查
		rangeCheck(index);
		// 保留就数据用于返回
		E old = elements[index];
		// 先将从index起的元素全部前移一位，从index + 1起移动
		for (int i = index + 1; i < size; i++) {
			elements[i - 1] = elements[i];
		}
		// 移动后将数据已用的段的末尾最后一个元素置空，然后size减1
		elements[--size] = null;
		
		trim();
		
		// 返回删除的元素
		return old;
	}
	
	public E remove(E element) {
		int index = indexOf(element);
		if (index != ELEMENT_NOT_FOUND) {
			return remove(index);
		}
		return null;
	}
	
	// 通过index获取元素
	// 复杂度：O(1) 从数组中取元素不需要任何遍历操作，直接通过计算获得内存地址
	public E get(int index) {
		// 越界检查
		rangeCheck(index);
		return elements[index];
	}
	
	// 通过index设置元素
	// 复杂度：O(1) 从数组中取元素不需要任何遍历操作，直接通过计算获得内存地址
	public E set(int index, E element) {
		// 越界检查
		rangeCheck(index);
		E old = elements[index];
		elements[index] = element;
		return old;
	}
	
	// 确保容量
	private void ensureCapacity(int capacity) {
		int oldCapacity = elements.length;
		if (oldCapacity >= capacity) {
			return;
		}
		// 右移相当于除以2
		int newCapacity = oldCapacity + (oldCapacity >> 1);
		System.out.println("扩容 " + newCapacity);
		E[] newElements = (E[]) new Object[newCapacity];
		for (int i = 0; i < size; i++) {
			newElements[i] = elements[i];
		}
		elements = newElements;
	}
	
	// 回收容量
	private void trim() {
		int oldCapacity = elements.length;
		int newCapacity = oldCapacity >> 1;
		if (oldCapacity <= DEFAULT_CAPACITY || size > newCapacity) return;
		E[] newElements = (E[]) new Object[newCapacity];
		for (int i = 0; i < size; i++) {
			newElements[i] = elements[i];
		}
		elements = newElements;
		System.out.println(oldCapacity + " 缩容 " + newCapacity);
	}
	
	// 重写打印
	@Override
	public String toString() {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("size=").append(size).append(", [");
		for (int i = 0; i < size; i++) {
			if (i != 0) {
				stringBuilder.append(", ");
			}
			stringBuilder.append(elements[i]);
		}
		stringBuilder.append("]");
		return stringBuilder.toString();
	}
	
	// 打印错误
		protected void outOfBounds(int index) {
			throw new IndexOutOfBoundsException("index:" + index + ", size:" + size);
		}
		
		// 越界检查
		protected void rangeCheck(int index) {
			if (index < 0 || index >= size) {
				outOfBounds(index);
			}
		}
		
		protected void rangeCheckForAdd(int index) {
			if (index < 0 || index > size) {
				outOfBounds(index);
			}
		}

		public int size() {
			return size;
		}

		public boolean isEmpty() {
			return size == 0;
		}

		public boolean contains(E element) {
			return indexOf(element) != ELEMENT_NOT_FOUND;
		}

		public void add(E element) {
			add(size, element);
		}
}
