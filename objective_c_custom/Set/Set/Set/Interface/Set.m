//
//  Set.m
//  Set
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "Set.h"

#define SetAbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
                               reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                             userInfo:nil]

@implementation Set

- (NSUInteger)count {
    SetAbstractMethodNotImplemented();
}

- (void)removeAllObjects {
    SetAbstractMethodNotImplemented();
}

- (BOOL)containsObject:(id)object {
    SetAbstractMethodNotImplemented();
}

- (void)addObject:(id)object {
    SetAbstractMethodNotImplemented();
}

- (void)removeObject:(id)object {
    SetAbstractMethodNotImplemented();
}

- (NSMutableArray<id> *)traversal {
    SetAbstractMethodNotImplemented();
}

@end
