//
//  JKRBinaryTreeNode.m
//  TreeDemo
//
//  Created by Joker on 2019/5/20.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRBinaryTreeNode.h"

@implementation JKRBinaryTreeNode

- (BOOL)isLeaf {
    return !self.left && !self.right;
}

- (BOOL)hasTwoChildren {
    return self.left && self.right;
}

- (BOOL)isLeftChild {
    return self.parent && self.parent.left == self;
}

- (BOOL)isRightChild {
    return self.parent && self.parent.right == self;
}

- (JKRBinaryTreeNode *)sibling {
    if ([self isLeftChild]) {
        return self.parent.right;
    }
    if ([self isRightChild]) {
        return self.parent.left;
    }
    return nil;
}

- (void)dealloc {
    //    NSLog(@"<%@: %p> dealloc", self.className, self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (p: %@)", self.element, self.parent.element];
}

@end
