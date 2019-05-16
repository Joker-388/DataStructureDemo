//
//  RedBlackTree.m
//  TreeDemo
//
//  Created by Joker on 2019/5/16.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "RedBlackTree.h"

@implementation RedBlackTree
static BOOL const RED = false;
static BOOL const BLACK = true;

// 默认新添加的节点是红色节点
- (void)afterAddWithNewNode:(Node *)node {
    Node *parent = node.parent;
    
    // 添加的节点是根节点 或者 上溢出到达根节点
    if (!parent) {
        [self black:node];
        return;
    }
    
    // 如果父节点是黑色节点，直接添加节点就可以，不需要平衡
    if ([self isBlack:parent]) {
        return;
    }
    
    // 叔父节点
    Node *uncle = parent.sibling;
    // 祖父节点
    Node *grand = [self red:parent.parent];
    
    
    // 叔父节点是红色的情况，B树节点上溢
    if ([self isRed:uncle]) {
        [self black:parent];
        [self black:uncle];
        // 把祖父节点当作是新添加的节点
        [self afterAddWithNewNode:grand];
        return;
    }
    
    // 叔父节点不是红色
    if (parent.isLeftChild) { // L
        if (node.isLeftChild) { // LL
            [self black:parent];
        } else { // LR
            [self black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { // R
        if (node.isLeftChild) { // RL
            [self black:node];
            [self rotateRight:parent];
        } else { // RR
            [self black:parent];
        }
        [self rotateLeft:grand];
    }
}

- (void)afterRemoveWithNode:(Node *)node {
    // 如果删除的节点是红色，或者用以取代删除节点的子节点是红色
    if ([self isRed:node]) {
        [self black:node];
        return;
    }
    
    Node *parent = node.parent;
    // 删除的是根节点
    if (!parent) {
        return;
    }
    
    // 删除的是黑色叶子节点，下溢，判定被删除的节点是左还是右
    BOOL left = !parent.left || node.isLeftChild;
    Node *sibling = left ? parent.right : parent.left;
    if (left) { // 被删除的节点在左边，兄弟节点在右边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            // 更换兄弟
            sibling = parent.right;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling.right]) {
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            [self dyeNode:sibling color:[self colorOf:parent]];
            [self black:sibling.right];
            [self black:parent];
            [self rotateLeft:parent];
        }
    } else { // 被删除的节点在右边，兄弟节点在左边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            // 更换兄弟
            sibling = parent.left;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling.left]) {
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            
            [self dyeNode:sibling color:[self colorOf:parent]];
            [self black:sibling.left];
            [self black:parent];
            [self rotateRight:parent];
        }
    }
}

- (Node *)dyeNode:(Node *)node color:(BOOL)color {
    if (!node) {
        return node;
    }
    ((RedBlackNode *) node).color = color;
    return node;
}

- (Node *)red:(Node *)node {
    return [self dyeNode:node color:RED];
}

- (Node *)black:(Node *)node {
    return [self dyeNode:node color:BLACK];
}

- (BOOL)colorOf:(Node *)node {
    return !node ? BLACK : ((RedBlackNode *)node).color;
}

- (BOOL)isBlack:(Node *)node {
    return [self colorOf:node] == BLACK;
}

- (BOOL)isRed:(Node *)node {
    return [self colorOf:node] == RED;
}

- (Node *)createNodeWithElement:(id)element parent:(Node *)parent {
    return [[RedBlackNode alloc] initWithElement:element parent:parent];
}

@end

@implementation RedBlackNode

- (instancetype)initWithElement:(id)element parent:(Node *)parent {
    self = [super init];
    self.element = element;
    self.parent = parent;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (p:%@) (c:%@)", self.element, self.parent.element, self.color == RED ? @"r" : @"b"];
}

@end
