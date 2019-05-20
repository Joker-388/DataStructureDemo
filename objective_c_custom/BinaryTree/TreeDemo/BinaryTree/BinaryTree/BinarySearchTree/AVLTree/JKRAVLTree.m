//
//  JKRAVLTree.m
//  TreeDemo
//
//  Created by Joker on 2019/5/6.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRAVLTree.h"
#import "JKRAVLTreeNode.h"

@implementation JKRAVLTree

- (JKRBinaryTreeNode *)createNodeWithElement:(id)element parent:(JKRBinaryTreeNode *)parent {
    return [[JKRAVLTreeNode alloc] initWithWithElement:element parent:parent];
}

#pragma mark - 添加一个新节点后平衡二叉树
/*
 添加复杂度: O(logn)，仅需O(1)次旋转操作
 */
- (void)afterAddWithNewNode:(JKRBinaryTreeNode *)node {
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
- (void)afterRemoveWithNode:(JKRBinaryTreeNode *)node {
    while ((node = node.parent)) {
        if ([self isBalancedWithNode:node]) {
            [self updateHeigthWithNode:node];
        } else {
            [self rebalance:node];
        }
    }
}

#pragma mark - 统一旋转
- (void)rebalance:(JKRBinaryTreeNode *)grand {
    JKRBinaryTreeNode *parent = ((JKRAVLTreeNode *) grand).tallerChild;
    JKRBinaryTreeNode *node = ((JKRAVLTreeNode *) parent).tallerChild;
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

- (void)rotateWithRoot:(JKRBinaryTreeNode *)root
                     b:(JKRBinaryTreeNode *)b
                     c:(JKRBinaryTreeNode *)c
                     d:(JKRBinaryTreeNode *)d
                     e:(JKRBinaryTreeNode *)e
                     f:(JKRBinaryTreeNode *)f {
    [super rotateWithRoot:root b:b c:c d:d e:e f:f];
    [self updateHeigthWithNode:b];
    [self updateHeigthWithNode:f];
    [self updateHeigthWithNode:d];
}

#pragma mark - 分情况旋转
- (void)rebalanceByClass:(JKRBinaryTreeNode *)grand {
    JKRBinaryTreeNode *parent = ((JKRAVLTreeNode *) grand).tallerChild;
    JKRBinaryTreeNode *node = ((JKRAVLTreeNode *) parent).tallerChild;
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

- (void)afterRotateWithGrand:(JKRBinaryTreeNode *)grand parent:(JKRBinaryTreeNode *)parent child:(JKRBinaryTreeNode *)child {
    [super afterRotateWithGrand:grand parent:parent child:child];
    [self updateHeigthWithNode:grand];
    [self updateHeigthWithNode:parent];
}

#pragma mark - 节点是否平衡
- (BOOL)isBalancedWithNode:(JKRBinaryTreeNode *)node {
    return labs(((JKRAVLTreeNode *) node).balanceFactor) <= 1;
}

#pragma mark - 更新节点高度
- (void)updateHeigthWithNode:(JKRBinaryTreeNode *)node {
    [((JKRAVLTreeNode *) node) updateHeight];
}

@end