//
//  BinaryTree.h
//  TreeDemo
//
//  Created by Joker on 2019/5/6.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelOrderPrinter.h"

NS_ASSUME_NONNULL_BEGIN

@class Node;

@interface BinaryTree<E> : NSObject<LevelOrderPrinterDelegate> {
@protected
    NSUInteger _size;
    Node *_root;
}

/// 节点个数
- (NSUInteger)count;
/// 二叉树是否为空
- (BOOL)isEmpty;
/// 清空二叉树
- (void)removeAllObjects;;
/// 二叉树高度
- (NSUInteger)height;
/// 前序遍历
- (NSMutableArray<E> *)preorderTraversal;
/// 后序遍历
- (NSMutableArray<E> *)postorderTraversal;
/// 中序遍历
- (NSMutableArray<E> *)inorderTraversal;
/// 层序遍历
- (NSMutableArray<E> *)levelOrderTraversal;
/// 翻转二叉树 递归
- (void)invertByRecursion;
/// 翻转二叉树 迭代
- (void)invertByIteration;
/// 前驱节点
- (Node *)predecessorWithNode:(Node *)node;
/// 后继节点
- (Node *)successorWithNode:(Node *)node;
/// 创建一个节点
- (Node *)createNodeWithObject:(nonnull id)object parent:(nullable Node *)parent;

- (void)insertValue:(id)value inPropertyWithKey:(NSString *)key __unavailable;
- (void)insertValue:(id)value atIndex:(NSUInteger)index inPropertyWithKey:(NSString *)key __unavailable;
- (void)removeValueAtIndex:(NSUInteger)index fromPropertyWithKey:(NSString *)key __unavailable;
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context __unavailable;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath __unavailable;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context __unavailable;
- (id)replacementObjectForCoder:(NSCoder *)aCoder __unavailable;
- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver __unavailable;
- (void)replaceValueAtIndex:(NSUInteger)index inPropertyWithKey:(NSString *)key withValue:(id)value __unavailable;
- (BOOL)respondsToSelector:(SEL)aSelector __unavailable;

@end

@interface Node : NSObject

@property (nonatomic, strong, nonnull) id element;
@property (nonatomic, strong, nullable) Node *left;
@property (nonatomic, strong, nullable) Node *right;
@property (nonatomic, weak, nullable) Node *parent;

/// 是否是叶子节点
- (BOOL)isLeaf;
/// 是否有度为2
- (BOOL)hasTwoChildren;
/// 是否是父节点的左子树
- (BOOL)isLeftChild;
/// 是否是父节点的右子树
- (BOOL)isRightChild;
/// 返回兄弟节点
- (Node *)sibling;

@end

NS_ASSUME_NONNULL_END
