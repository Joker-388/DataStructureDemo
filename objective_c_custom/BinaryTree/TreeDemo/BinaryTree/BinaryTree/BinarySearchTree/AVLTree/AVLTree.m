//
//  AVLTree.m
//  TreeDemo
//
//  Created by Joker on 2019/5/6.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "AVLTree.h"

@implementation AVLTree

- (Node *)createNodeWithObject:(id)object parent:(Node *)parent {
    return [[AVLNode alloc] initWithWithElement:object parent:parent];
}

#pragma mark - 添加一个新节点后平衡二叉树
/*
 添加复杂度: O(logn)，仅需O(1)次旋转操作
 */
- (void)afterAddWithNewNode:(Node *)node {
    while ((node = node.parent)) {
        // 依次向上检查新添加节点的父节点是否平衡，如果是平衡状态，就更新整从新添加节点到根节点的所有节点的高度值
        if ([self isBalancedWithNode:node]) {
            [self updateHeigthWithNode:node];
        } else { // 如果不平衡，就对这个高度最低的不平衡的点进行平衡
            [self rebalance:node];
            break;
        }
    }
}

#pragma mark - 删除一个节点后平衡二叉树
/*
 删除时旋转的复杂度: O(logn)，最多需要O(logn)次旋转
 */
- (void)afterRemoveWithNode:(Node *)node {
    while ((node = node.parent)) {
        if ([self isBalancedWithNode:node]) {
            [self updateHeigthWithNode:node];
        } else {
            [self rebalance:node];
        }
    }
}

#pragma mark - 统一旋转
- (void)rebalance:(Node *)grand {
    Node *parent = ((AVLNode *) grand).tallerChild;
    Node *node = ((AVLNode *) parent).tallerChild;
    if (parent.isLeftChild) { // L
        if (node.isLeftChild) { // LL 右旋转 grand
            NSLog(@"统一旋转:LL G:%@, P:%@, N:%@", grand.element, parent.element, node.element);
            [self rotateWithRoot:grand b:node c:node.right d:parent e:parent.right f:grand];
        } else { // LR
            NSLog(@"统一旋转:LR G:%@, P:%@, N:%@", grand.element, parent.element, node.element);
            [self rotateWithRoot:grand b:parent c:node.left d:node e:node.right f:grand];
        }
    } else { // R
        if (node.isLeftChild) { // RL
            NSLog(@"统一旋转:RL G:%@, P:%@, N:%@", grand.element, parent.element, node.element);
            [self rotateWithRoot:grand b:grand c:node.left d:node e:node.right f:parent];
        } else { // RR 左旋转 grand
            NSLog(@"统一旋转:RR G:%@, P:%@, N:%@", grand.element, parent.element, node.element);
            [self rotateWithRoot:grand b:grand c:parent.left d:parent e:node.left f:node];
        }
    }
}

- (void)rotateWithRoot:(Node *)root
                     b:(Node *)b
                     c:(Node *)c
                     d:(Node *)d
                     e:(Node *)e
                     f:(Node *)f {
    [super rotateWithRoot:root b:b c:c d:d e:e f:f];
    [self updateHeigthWithNode:b];
    [self updateHeigthWithNode:f];
    [self updateHeigthWithNode:d];
}

#pragma mark - 分情况旋转
- (void)rebalanceByClass:(Node *)grand {
    Node *parent = ((AVLNode *) grand).tallerChild;
    Node *node = ((AVLNode *) parent).tallerChild;
    if (parent.isLeftChild) { // L
        if (node.isLeftChild) { // LL 右旋转 grand
            [self rotateRight:grand];
        } else { // LR
            [self rotateLeft:parent];
            [self rotateRight:grand];
        }
    } else { // R
        if (node.isLeftChild) { // RL
            [self rotateRight:parent];
            [self rotateLeft:grand];
        } else { // RR 左旋转 grand
            [self rotateLeft:grand];
        }
    }
}

- (void)afterRotateWithGrand:(Node *)grand parent:(Node *)parent child:(Node *)child {
    [super afterRotateWithGrand:grand parent:parent child:child];
    [self updateHeigthWithNode:grand];
    [self updateHeigthWithNode:parent];
}

#pragma mark - 节点是否平衡
- (BOOL)isBalancedWithNode:(Node *)node {
    return labs(((AVLNode *) node).balanceFactor) <= 1;
}

#pragma mark - 更新节点高度
- (void)updateHeigthWithNode:(Node *)node {
    [((AVLNode *) node) updateHeight];
}

@end

@implementation AVLNode

- (instancetype)initWithWithElement:(id)element parent:(Node *)parent {
    self = [super init];
    self.height = 1;
    self.element = element;
    self.parent = parent;
    return self;
}

- (NSInteger)balanceFactor {
    NSInteger leftHeight = self.left ? ((AVLNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((AVLNode *)self.right).height : 0;
    return leftHeight - rightHeight;
}

- (void)updateHeight {
    NSInteger leftHeight = self.left ? ((AVLNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((AVLNode *)self.right).height : 0;
    self.height = 1 + MAX(leftHeight, rightHeight);
}

- (Node *)tallerChild {
    NSInteger leftHeight = self.left ? ((AVLNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((AVLNode *)self.right).height : 0;
    if (leftHeight > rightHeight) {
        return self.left;
    }
    if (leftHeight < rightHeight) {
        return self.right;
    }
    return self.isLeftChild ? self.left : self.right;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (p:%@) (h:%zd)", self.element, self.parent.element, self.height];
}

@end
