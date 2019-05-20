//
//  BinarySearchTree.h
//  TreeDemo
//
//  Created by Lucky on 2019/4/30.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTree.h"

NS_ASSUME_NONNULL_BEGIN

@class Node;

typedef int(^jkrbinarytree_compareBlock)(id e1, id e2);

@interface BinarySearchTree<E> : BinaryTree {
@protected
    jkrbinarytree_compareBlock _compareBlock;
}

- (instancetype)initWithCompare:(_Nonnull jkrbinarytree_compareBlock)compare;

@property (nonatomic, strong) void(^rotateBlock)(void);

/// 添加元素
- (void)addObject:(nullable E)object;
/// 删除元素
- (void)removeObject:(E)object;
/// 是否包含元素
- (BOOL)containsObject:(nullable E)object;
/// 添加节点后的处理
- (void)afterAddWithNewNode:(Node *)node;
/// 删除节点后的处理
- (void)afterRemoveWithNode:(Node *)node;
/// 通过元素获取对应节点
- (Node *)nodeWithObject:(id)object;
/// 删除节点
- (void)removeWithNode:(Node *)node;
/// 左旋转一个节点
- (void)rotateLeft:(Node *)grand;
/// 右旋转一个节点
- (void)rotateRight:(Node *)grand;
/// 旋转后处理
- (void)afterRotateWithGrand:(Node *)grand parent:(Node *)parent child:(Node *)child;
/// 统一旋转
- (void)rotateWithRoot:(Node *)root
                     b:(Node *)b
                     c:(Node *)c
                     d:(Node *)d
                     e:(Node *)e
                     f:(Node *)f;

@end



NS_ASSUME_NONNULL_END
