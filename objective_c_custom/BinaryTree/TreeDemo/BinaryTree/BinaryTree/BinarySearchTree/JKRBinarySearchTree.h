//
//  JKRBinarySearchTree.h
//  TreeDemo
//
//  Created by Lucky on 2019/4/30.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinaryTree.h"

NS_ASSUME_NONNULL_BEGIN

@class JKRBinaryTreeNode;

typedef int(^jkrbinarytree_compareBlock)(id e1, id e2);

@interface JKRBinarySearchTree<E> : JKRBinaryTree {
@protected
    jkrbinarytree_compareBlock _compareBlock;
}

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithCompare:(_Nonnull jkrbinarytree_compareBlock)compare;

@property (nonatomic, strong) void(^rotateBlock)(void);

/// 添加元素
- (void)addObject:(id)object;
/// 删除元素
- (void)removeObject:(id)object;
/// 是否包含元素
- (BOOL)containsObject:(id)object;
/// 添加节点后的处理
- (void)afterAddWithNewNode:(JKRBinaryTreeNode *)node;
/// 删除节点后的处理
- (void)afterRemoveWithNode:(JKRBinaryTreeNode *)node;
/// 通过元素获取对应节点
- (JKRBinaryTreeNode *)nodeWithObject:(id)object;
/// 删除节点
- (void)removeWithNode:(JKRBinaryTreeNode *)node;
/// 左旋转一个节点
- (void)rotateLeft:(JKRBinaryTreeNode *)grand;
/// 右旋转一个节点
- (void)rotateRight:(JKRBinaryTreeNode *)grand;
/// 旋转后处理
- (void)afterRotateWithGrand:(JKRBinaryTreeNode *)grand parent:(JKRBinaryTreeNode *)parent child:(JKRBinaryTreeNode *)child;
/// 统一旋转
- (void)rotateWithRoot:(JKRBinaryTreeNode *)root
                     b:(JKRBinaryTreeNode *)b
                     c:(JKRBinaryTreeNode *)c
                     d:(JKRBinaryTreeNode *)d
                     e:(JKRBinaryTreeNode *)e
                     f:(JKRBinaryTreeNode *)f;

@end



NS_ASSUME_NONNULL_END
