//
//  JKRAVLTreeNode.m
//  TreeDemo
//
//  Created by Joker on 2019/5/20.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRAVLTreeNode.h"

@implementation JKRAVLTreeNode

- (instancetype)initWithWithElement:(id)element parent:(JKRBinaryTreeNode *)parent {
    self = [super init];
    self.height = 1;
    self.element = element;
    self.parent = parent;
    return self;
}

- (NSInteger)balanceFactor {
    NSInteger leftHeight = self.left ? ((JKRAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((JKRAVLTreeNode *)self.right).height : 0;
    return leftHeight - rightHeight;
}

- (void)updateHeight {
    NSInteger leftHeight = self.left ? ((JKRAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((JKRAVLTreeNode *)self.right).height : 0;
    self.height = 1 + MAX(leftHeight, rightHeight);
}

- (JKRBinaryTreeNode *)tallerChild {
    NSInteger leftHeight = self.left ? ((JKRAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((JKRAVLTreeNode *)self.right).height : 0;
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
