// 用栈实现一个队列

package test;

public class QueueWithStack<E> {
	// 使用两个栈来实现一个队列
	// 入队时，向inStack入栈一个元素
	private Stack<E> inStack = new Stack<E>();
	// 出队时，从outStack出栈一个元素
	private Stack<E> outStack = new Stack<E>();
	
	// 关键逻辑，当需要出队或者查看队头元素时，先查看outStack是否有值，第一次肯定是空的
	// 这时将inStack的元素全部依次出栈并入栈到outStack后，outStack就是反向放置了inStack的元素
	// 此时outStack出栈的元素顺序刚好就是之前inStack的入栈顺序
	// 当需要出队时，如果outStack不为空，那么直接从outStack出栈
	private void checkStack() {
		if (outStack.isEmpty()) {
			 while(inStack.isEmpty() == false) {
				 outStack.push(inStack.pop());
			 }
		} 
	}

	// 两个栈的数据数量相加是队列的数据数量
	public int sise() {
		return inStack.size() + outStack.size();
	}
	
	// 两个栈都为空队列为空
	public boolean isEmpty() {
		return inStack.isEmpty() && outStack.isEmpty();
	}
	
	// 入队就是在链表尾部添加元素
	public void enQueue(E element) {
		inStack.push(element);
	}
	
	// 出队就是删除链表头部元素
	public E deQueue() {
		checkStack();
		return outStack.pop();
	}
	
	// 获取队头就是获取链表头部元素
	public E front() {
		checkStack();
		return outStack.peek();
	}
}
