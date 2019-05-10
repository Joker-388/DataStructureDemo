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

typedef int(^compareBlock)(id e1, id e2);

@interface BinarySearchTree<E> : BinaryTree {
@protected
    compareBlock _compareBlock;
}

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithCompare:(_Nonnull compareBlock)compare;

/// 添加元素
- (void)add:(E)element;
/// 删除元素
- (void)remove:(E)element;
/// 是否包含元素
- (BOOL)contains:(E)element;

/// 添加节点后的处理
- (void)afterAddWithNewNode:(Node *)node;

///// 通过元素获取对应节点
//- (Node *)nodeWithElement:(id)element;
///// 删除节点
//- (void)removeWithNode:(Node *)node;

@end



NS_ASSUME_NONNULL_END
