//
//  TreeSet.m
//  Set
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "TreeSet.h"
#import "RedBlackTree.h"

@interface TreeSet ()

@property (nonatomic, strong) RedBlackTree *tree;

@end

@implementation TreeSet

- (NSUInteger)count {
    return self.tree.size;
}

- (void)removeAllObjects {
    [self.tree clear];
}

- (BOOL)containsObject:(id)object {
    return [self.tree contains:object];
}

- (void)addObject:(id)object {
    if (!object) {
        return;
    }
    [self.tree add:object];
}

- (void)removeObject:(id)object {
    [self.tree remove:object];
}

- (NSMutableArray<id> *)traversal {
    return [self.tree inorderTraversal];
}

- (RedBlackTree *)tree {
    if (!_tree) {
        _tree = [[RedBlackTree alloc] initWithCompare:^int(id  _Nonnull e1, id  _Nonnull e2) {
            return [e1 compare:e2];
        }];
    }
    return _tree;
}

@end
