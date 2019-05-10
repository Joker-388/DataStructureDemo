package test;

//import test.LinkedCircleList.Node;
import test.SingleCircleLinkedList.Node;

public class Main {
	public static void main(String[] args) {

//		Stack<Integer> stack = new Stack<Integer>();
//		
//		for (int i = 0; i < 10; i++) {
//			stack.push(i);
//		}
//		
//		while (stack.isEmpty() == false) {
//			System.out.println(stack.pop());
//		}
		
//		ArrayList<Integer> list = new ArrayList<Integer>();
//		for (int i = 0; i < 100; i++) {
//			list.add(i);
//		}
//		
//		System.out.println(list);
//		
//		for (int i = 0; i < 100; i++) {
//			list.remove(0);
//		}
//		
//		System.out.println(list);
//		
//		for (int i = 0; i < 100; i++) {
//			list.add(i);
//		}
//		
//		System.out.println(list);
//		
//		for (int i = 0; i < 100; i++) {
//			list.remove(0);
//		}
//		
//		System.out.println(list);
		
		
//		DequeWithArrayList<Integer> queue = new DequeWithArrayList<Integer>();
//
//		queue.enQueueRear(1);
//		queue.enQueueRear(2);
//		queue.enQueueRear(3);
//		queue.enQueueRear(4);
//		
//		System.out.println(queue);
//		
//		queue.enQueueFront(5);
//		System.out.println(queue);
//		
//		queue.enQueueFront(6);
//		System.out.println(queue);
//		
//		queue.enQueueRear(7);
//		queue.enQueueRear(8);
//		System.out.println(queue);
		
//		queue.deQueue();
//		queue.deQueue();
//		
//		System.out.println(queue);
//		
//		queue.enQueue(5);
//		
//		System.out.println(queue);
//		
//		queue.enQueue(6);
//		
//		System.out.println(queue);
//		
//		queue.enQueue(7);
//		
//		System.out.println(queue);
//		
//		queue.enQueue(8);
//		
//		System.out.println(queue);
		
		// 1, 2, 3
		
//		System.out.println(queue.deQueue()); // 1
//		
//		queue.enQueue(4);
//		// 2, 3, 4
//		
//		System.out.println(queue.front()); // 2
//		
//		queue.enQueue(5);
//		// 2, 3, 4, 5
//		
//		System.out.println("--------------------");
		
//		while(queue.isEmpty() == false) {
//			System.out.println(queue.deQueueFront());
//		}
		
		// 2, 3, 4, 5
		
		SingleCircleLinkedList<Integer> list = new SingleCircleLinkedList<Integer>();
        for (int i = 0; i < 8; i++) {
            list.add(i + 1);
        }
        System.out.println(list);
        Node<Integer> node = list.first;
        while(list.isEmpty() == false) {
            node = node.next;
            node = node.next;
            System.out.println(list.remove(node.element));
            node = node.next;
        }
	
	}
}
