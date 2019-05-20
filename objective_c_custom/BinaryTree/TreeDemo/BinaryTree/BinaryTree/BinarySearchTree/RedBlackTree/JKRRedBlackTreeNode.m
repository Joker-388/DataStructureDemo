//
//  JKRRedBlackTreeNode.m
//  TreeDemo
//
//  Created by Joker on 2019/5/20.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRRedBlackTreeNode.h"

@implementation JKRRedBlackTreeNode

- (instancetype)initWithElement:(id)element parent:(JKRBinaryTreeNode *)parent {
    self = [super init];
    self.element = element;
    self.parent = parent;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@", self.color == RBT_Color_RED ? @"R_" : @"", self.element];
}

@end
