//
//  BinarySearchTree.m
//  TreeDemo
//
//  Created by Lucky on 2019/4/30.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "BinarySearchTree.h"

@implementation BinarySearchTree

- (instancetype)initWithCompare:(compareBlock)compare {
    self = [super init];
    _compareBlock = compare;
    return self;
}

#pragma mark - 添加元素
- (void)add:(id)element {
    [self elementNotNullCheck:element];
    
    if (!_root) {
        Node *newNode = [self createNodeWithElement:element parent:nil];
        _root = newNode;
        _size++;
        [self afterAddWithNewNode:newNode];
        return;
    }
    
    Node *parent = _root;
    Node *node = _root;
    int cmp = 0;
    while (node) {
        cmp = _compareBlock(element, node.element);
        parent = node;
        if (cmp < 0) {
            node = node.left;
        } else if (cmp > 0) {
            node = node.right;
        } else {
            node.element = element;
            return;
        }
    }
    
    Node *newNode = [self createNodeWithElement:element parent:parent];
    if (cmp < 0) {
        parent.left = newNode;
    } else {
        parent.right = newNode;
    }
    [self afterAddWithNewNode:newNode];
    _size++;
}

- (void)afterAddWithNewNode:(Node *)node {
    
}

- (void)elementNotNullCheck:(id)element {
    if (!element) {
        NSAssert(NO, @"element must not be null");
    }
}

#pragma mark - 删除元素
- (void)remove:(id)element {
    [self removeWithNode:[self nodeWithElement:element]];
}

#pragma mark - 删除节点
- (void)removeWithNode:(Node *)node {
    if (!node) {
        return;
    }
    _size--;
    
    if (node.hasTwoChildren) {
        Node *s = [self successorWithNode:node];
        node.element = s.element;
        node = s;
    }
    
    // 实际被删除节点的子节点
    Node *replacement = node.left ? node.left : node.right;
    if (replacement) { // 被删除的节点度为1
        replacement.parent = node.parent;
        if (!node.parent) {
            _root = replacement;
        } else if (node == node.parent.left) {
            node.parent.left = replacement;
        } else {
            node.parent.right = replacement;
        }
        [self afterRemoveWithNode:replacement];
    } else if(!node.parent) { // 被删除的节点度为0且没有父节点，被删除的节点是根节点且二叉树只有一个节点
        _root = nil;
        [self afterRemoveWithNode:node];
    } else { // 被删除的节点是叶子节点且不是根节点
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {
            node.parent.right = nil;
        }
        [self afterRemoveWithNode:node];
    }
}

- (void)afterRemoveWithNode:(Node *)node {
    
}

#pragma mark - 是否包含元素
- (BOOL)contains:(id)element {
    return [self nodeWithElement:element] != nil;
}

#pragma mark - 通过元素获取对应节点
- (Node *)nodeWithElement:(id)element {
    Node *node = _root;
    while (node) {
        int cmp = _compareBlock(element, node.element);
        if (!cmp) {
            return node;
        } else if (cmp > 0) {
            node = node.right;
        } else {
            node = node.left;
        }
    }
    return nil;
}

#pragma mark - 左旋转一个节点
- (void)rotateLeft:(Node *)grand {
    Node *parent = grand.right;
    Node *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 右旋转一个节点
- (void)rotateRight:(Node *)grand {
    Node *parent = grand.left;
    Node *child = parent.right;
    grand.left = child;
    parent.right = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 旋转后处理
- (void)afterRotateWithGrand:(Node *)grand parent:(Node *)parent child:(Node *)child {
    if (grand.isLeftChild) {
        grand.parent.left = parent;
    } else if (grand.isRightChild) {
        grand.parent.right = parent;
    } else {
        _root = parent;
    }
    
    if (child) {
        child.parent = grand;
    }
    
    parent.parent = grand.parent;
    grand.parent = parent;
}

#pragma mark - 统一旋转
- (void)rotateWithRoot:(Node *)root
                     b:(Node *)b
                     c:(Node *)c
                     d:(Node *)d
                     e:(Node *)e
                     f:(Node *)f {
    d.parent = root.parent;
    if (root.isLeftChild) root.parent.left = d;
    else if (root.isRightChild) root.parent.right = d;
    else _root = d;
    
    b.right = c;
    if (c) c.parent = b;
    
    f.left = e;
    if (e) e.parent = f;
    
    d.left = b;
    d.right = f;
    b.parent = d;
    f.parent = d;
}

@end
