//
//  JKRBinaryTree.m
//  TreeDemo
//
//  Created by Joker on 2019/5/6.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinaryTree.h"
#import "LevelOrderPrinter.h"
#import "JKRBinaryTreeNode.h"

typedef void(^orderBlock)(id element);

@interface JKRBinaryTree ()<LevelOrderPrinterDelegate>

@end

@implementation JKRBinaryTree

#pragma mark - 节点个数
- (NSUInteger)size {
    return _size;
}

#pragma mark - 二叉树是否为空
- (BOOL)isEmpty {
    return self.size == 0;
}

#pragma mark - 清空二叉树
- (void)clear {
    _root = nil;
    _size = 0;
}

#pragma mark - 二叉树高度
- (NSInteger)height {
    NSInteger height = 0;
    if (_root) {
        NSMutableArray *queue = [NSMutableArray array];
        [queue addObject:_root];
        while (queue.count) {
            height++;
            for (NSInteger i = 0, n = queue.count; i < n; i++) {
                JKRBinaryTreeNode *node = queue.firstObject;
                [queue removeObjectAtIndex:0];
                if (node.left) [queue addObject:node.left];
                if (node.right) [queue addObject:node.right];
            }
        }
    }
    return height;
}

#pragma mark - 二叉树遍历
- (NSMutableArray *)preorderTraversal {
    NSMutableArray *elements = [NSMutableArray array];
    [self preorderTraversal:_root block:^(id element) {
        [elements addObject:element];
    }];
    return elements;
}

- (void)preorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block{
    //    if (node) {
    //        block(node.element);
    //        [self preOrderTraversal:node.left block:block];
    //        [self preOrderTraversal:node.right block:block];
    //    }
    if (node) {
        NSMutableArray *stack = [NSMutableArray array];
        [stack addObject:node];
        while (stack.count) {
            JKRBinaryTreeNode *n = [stack lastObject];
            block(n.element);
            [stack removeLastObject];
            if (n.right) {
                [stack addObject:n.right];
            }
            if (n.left) {
                [stack addObject:n.left];
            }
        }
    }
}

- (NSMutableArray *)postorderTraversal {
    NSMutableArray *elements = [NSMutableArray array];
    [self postorderTraversal:_root block:^(id element) {
        //        [elements addObject:element];
        [elements insertObject:element atIndex:0];
    }];
    return elements;
}

- (void)postorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block {
    //    if (node) {
    //        [self postorderTraversal:node.left block:block];
    //        [self postorderTraversal:node.right block:block];
    //        block(node.element);
    //    }
    if (node) {
        NSMutableArray *stack = [NSMutableArray array];
        [stack addObject:node];
        while (stack.count) {
            JKRBinaryTreeNode *node = [stack lastObject];
            block(node.element);
            [stack removeLastObject];
            if (node.left) {
                [stack addObject:node.left];
            }
            if (node.right) {
                [stack addObject:node.right];
            }
        }
    }
}

- (NSMutableArray *)inorderTraversal {
    NSMutableArray *elements = [NSMutableArray array];
    [self inorderTraversal:_root block:^(id element) {
        [elements addObject:element];
    }];
    return elements;
}

- (void)inorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block {
    //    if (node) {
    //        [self inorderTraversal:node.left block:block];
    //        block(node.element);
    //        [self inorderTraversal:node.right block:block];
    //    }
    if (node) {
        NSMutableArray *stack = [NSMutableArray array];
        do {
            while (node) {
                [stack addObject:node];
                node = node.left;
            }
            if (stack.count) {
                JKRBinaryTreeNode *n = [stack lastObject];
                block(n.element);
                [stack removeLastObject];
                node = n.right;
            }
        } while(stack.count || node);
    }
}

- (NSMutableArray *)levelOrderTraversal {
    NSMutableArray *elements = [NSMutableArray array];
    [self levelOrderTraversal:_root block:^(id element) {
        [elements addObject:element];
    }];
    return elements;
}

- (void)levelOrderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block {
    if (node) {
        NSMutableArray *queue = [NSMutableArray array];
        [queue addObject:node];
        while (queue.count) {
            for (NSInteger i = 0, n = queue.count; i < n; i++) {
                JKRBinaryTreeNode *n = [queue firstObject];
                block(n.element);
                [queue removeObjectAtIndex:0];
                if (n.left) {
                    [queue addObject:n.left];
                }
                if (n.right) {
                    [queue addObject:n.right];
                }
            }
        }
    }
}

#pragma mark - 翻转二叉树
- (void)invertByRecursion {
    [self invertByRecursion:_root];
}

- (void)invertByIteration {
    [self invertByIteration:_root];
}

- (void)invertByRecursion:(JKRBinaryTreeNode *)root {
    if (root) {
        JKRBinaryTreeNode *tmp = root.left;
        root.left = root.right;
        root.right = tmp;
        [self invertByRecursion:root.left];
        [self invertByRecursion:root.right];
    }
}

- (void)invertByIteration:(JKRBinaryTreeNode *)root {
    if (root) {
        NSMutableArray *queue = [NSMutableArray array];
        [queue addObject:root];
        while (queue.count) {
            for (NSInteger i = 0, n = queue.count; i < n; i++) {
                JKRBinaryTreeNode *node = [queue firstObject];
                JKRBinaryTreeNode *tmp = node.left;
                node.left = node.right;
                node.right = tmp;
                [queue removeObjectAtIndex:0];
                if (node.left) [queue addObject:node.left];
                if (node.right) [queue addObject:node.right];
            }
        }
    }
}

#pragma mark - 节点的前驱节点
- (JKRBinaryTreeNode *)predecessorWithNode:(JKRBinaryTreeNode *)node {
    if (!node) {
        return nil;
    }
    // 节点有左子树的情况下，前驱节点在它的左子树中
    if (node.left) {
        // 前驱节点是 node.left.right.right...
        JKRBinaryTreeNode *p = node.left;
        while (p.right) {
            p = p.right;
        }
        return p;
    }
    // 节点没有左子树的情况下，如果有父节点，在父节点往上找
    while (node.parent && node == node.parent.left) {
        node = node.parent;
    }
    
    // 没有左子树，也没有父节点，就没有前驱节点
    // !node.left && (!node.parent || node == node.parent.right)
    return node.parent;
}

#pragma mark - 节点的后继节点
- (JKRBinaryTreeNode *)successorWithNode:(JKRBinaryTreeNode *)node {
    if (!node) {
        return nil;
    }
    
    if (node.right) {
        JKRBinaryTreeNode *p = node.right;
        while (p.left) {
            p = p.left;
        }
        return p;
    }
    
    while (node.parent && node == node.parent.right) {
        node = node.parent;
    }
    
    return node.parent;
}

#pragma mark - LevelOrderPrinterDelegate
- (id)print_root {
    return _root;
}

- (id)print_left:(id)node {
    JKRBinaryTreeNode *n = (JKRBinaryTreeNode *)node;
    return n.left;
}

- (id)print_right:(id)node {
    JKRBinaryTreeNode *n = (JKRBinaryTreeNode *)node;
    return n.right;
}

- (id)print_string:(id)node {
//    Node *n = (Node *)node;
//    return [NSString stringWithFormat:@"%@ (%@)", [n.element description], [n.parent.element description]];
    return [NSString stringWithFormat:@"%@", node];
}

#pragma mark - 创建节点
- (JKRBinaryTreeNode *)createNodeWithElement:(id)element parent:(JKRBinaryTreeNode *)parent {
    JKRBinaryTreeNode *node = [[JKRBinaryTreeNode alloc] init];
    node.element = element;
    node.parent = parent;
    return node;;
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"<%@: %p> dealloc", self.className, self);
}

#pragma mark - 格式化输出
- (NSString *)description {
    return [LevelOrderPrinter printStringWithTree:self];
}

- (void)printTree {
    NSLog(@"%@", self);
}

@end


