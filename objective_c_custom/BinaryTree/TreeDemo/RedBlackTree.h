//
//  RedBlackTree.h
//  TreeDemo
//
//  Created by Joker on 2019/5/16.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "BinarySearchTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface RedBlackTree : BinarySearchTree

@end

@interface RedBlackNode : Node

@property (nonatomic, assign) BOOL color;

- (instancetype)initWithElement:(id)element parent:(Node *)parent;

@end

NS_ASSUME_NONNULL_END
