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
- (NSUInteger)count {
    return _size;
}

#pragma mark - 二叉树是否为空
- (BOOL)isEmpty {
    return _size == 0;
}

#pragma mark - 清空二叉树
- (void)removeAllObjects {
    _root = nil;
    _size = 0;
}

#pragma mark - 二叉树高度
- (NSUInteger)height {
    NSUInteger height = 0;
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



#pragma mark - 获取所有元素（默认中序遍历）
- (NSMutableArray *)allObjects {
    return [self inorderTraversal];
}

#pragma mark -获取所有元素（指定二叉树遍历方式）
- (NSMutableArray *)allObjectsWithTraversalType:(JKRBinaryTreeTraversalType)traversalType {
    switch (traversalType) {
        case JKRBinaryTreeTraversalTypePreorder:
            return [self preorderTraversal];
            break;
        case JKRBinaryTreeTraversalTypeInorder:
            return [self inorderTraversal];
            break;
        case JKRBinaryTreeTraversalTypePostorder:
            return [self postorderTraversal];
            break;
        case JKRBinaryTreeTraversalTypeLevelOrder:
            return [self levelOrderTraversal];
            break;
        default:
            return [self inorderTraversal];
            break;
    }
}

#pragma mark - 枚举元素（默认中序遍历）
- (void)enumerateObjectsUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    [self enumerateObjectsWithInorderTraversalUsingBlock:block];
}

#pragma mark - 枚举元素（指定二叉树遍历方式）
- (void)enumerateObjectsWithTraversalType:(JKRBinaryTreeTraversalType)traversalType usingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    switch (traversalType) {
        case JKRBinaryTreeTraversalTypePreorder:
            [self enumerateObjectsWithPreorderTraversalUsingBlock:block];
            break;
        case JKRBinaryTreeTraversalTypeInorder:
            [self enumerateObjectsWithInorderTraversalUsingBlock:block];
            break;
        case JKRBinaryTreeTraversalTypePostorder:
            [self enumerateObjectsWithPostorderTraversalUsingBlock:block];
            break;
        case JKRBinaryTreeTraversalTypeLevelOrder:
            [self enumerateObjectsWithLevelOrderTraversalUsingBlock:block];
            break;
        default:
            [self enumerateObjectsWithInorderTraversalUsingBlock:block];
            break;
    }
}

#pragma mark - 前序遍历
/*
 非自平衡的二叉搜索树，前序遍历会按照添加节点的顺序输出，AVL树、红黑树则不是
 */
- (NSMutableArray *)preorderTraversal {
    __block BOOL stop = NO;
    NSMutableArray *elements = [NSMutableArray array];
    [self preorderTraversal:_root block:^(id element) {
        [elements addObject:element];
    } stop:&stop];
    return elements;
}

- (void)enumerateObjectsWithPreorderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    [self preorderTraversal:_root block:^(id element) {
        block(element, &stop);
    } stop:&stop];
}

- (void)preorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block stop:(BOOL *)stop {
    //    if (node) {
    //        block(node.element);
    //        [self preOrderTraversal:node.left block:block];
    //        [self preOrderTraversal:node.right block:block];
    //    }
    if (node) {
        NSMutableArray *stack = [NSMutableArray array];
        [stack addObject:node];
        while (stack.count && !*stop) {
            JKRBinaryTreeNode *n = [stack lastObject];
            block(n.object);
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

#pragma mark - 后序遍历
- (NSMutableArray *)postorderTraversal {
    __block BOOL stop = NO;
    NSMutableArray *elements = [NSMutableArray array];
    [self postorderTraversal:_root block:^(id element) {
        [elements addObject:element];
//        [elements insertObject:element atIndex:0];
    } stop:&stop];
    return elements;
}

- (void)enumerateObjectsWithPostorderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    [self postorderTraversal:_root block:^(id element) {
        block(element, &stop);
    } stop:&stop];
}

- (void)postorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block stop:(BOOL *)stop {
    if (node && !*stop) {
        [self postorderTraversal:node.left block:block stop:stop];
        [self postorderTraversal:node.right block:block stop:stop];
        if (*stop) return;
        block(node.object);
    }
//    if (node) {
//        NSMutableArray *stack = [NSMutableArray array];
//        [stack addObject:node];
//        while (stack.count && !*stop) {
//            JKRBinaryTreeNode *node = [stack lastObject];
//            block(node.element);
//            [stack removeLastObject];
//            if (node.left) {
//                [stack addObject:node.left];
//            }
//            if (node.right) {
//                [stack addObject:node.right];
//            }
//        }
//    }
}

#pragma mark - 中序遍历
/*
 二叉搜索树中序遍历，会按照定义的比较规则升序或者降序输出
 */
- (NSMutableArray *)inorderTraversal {
    __block BOOL stop = NO;
    NSMutableArray *elements = [NSMutableArray array];
    [self inorderTraversal:_root block:^(id element) {
        [elements addObject:element];
    } stop:&stop];
    return elements;
}

- (void)enumerateObjectsWithInorderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    [self inorderTraversal:_root block:^(id element) {
        block(element, &stop);
    } stop:&stop];
}

- (void)inorderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block stop:(BOOL *)stop {
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
                block(n.object);
                [stack removeLastObject];
                node = n.right;
            }
        } while((stack.count || node) && !*stop);
    }
}

#pragma mark - 层序遍历
- (NSMutableArray *)levelOrderTraversal {
    __block BOOL stop = NO;
    NSMutableArray *elements = [NSMutableArray array];
    [self levelOrderTraversal:_root block:^(id element) {
        [elements addObject:element];
    } stop:&stop];
    return elements;
}

- (void)enumerateObjectsWithLevelOrderTraversalUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    __block BOOL stop = NO;
    [self levelOrderTraversal:_root block:^(id element) {
        block(element, &stop);
    } stop:&stop];
}

- (void)levelOrderTraversal:(JKRBinaryTreeNode *)node block:(orderBlock)block stop:(BOOL *)stop {
    if (node) {
        NSMutableArray *queue = [NSMutableArray array];
        [queue addObject:node];
        while (queue.count && !*stop) {
            for (NSInteger i = 0, n = queue.count; i < n; i++) {
                if (*stop) return;
                JKRBinaryTreeNode *n = [queue firstObject];
                block(n.object);
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
    return [NSString stringWithFormat:@"%@", node];
}

#pragma mark - 创建节点
- (JKRBinaryTreeNode *)createNodeWithObject:(id)object parent:(JKRBinaryTreeNode *)parent {
    return [[JKRBinaryTreeNode alloc] initWithObject:object parent:parent];
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

- (void)debugPrintTree {
    printf("\n%s\n\n", [self.description UTF8String]);
    printf("-------------------------------------------------------------------\n\n");
}

@end


