//
//  ListSet.m
//  Set
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "ListSet.h"
#import "LinkedCircleList.h"

@interface ListSet ()

@property (nonatomic, strong) LinkedCircleList *list;

@end

@implementation ListSet

- (NSUInteger)count {
    return self.list.count;
}

- (void)removeAllObjects {
    [self.list removeAllObjects];
}

- (BOOL)containsObject:(id)object {
    return [self.list containsObject:object];
}

- (void)addObject:(id)object {
    if (!object) {
        return;
    }
    NSUInteger index = [self.list indexOfObject:object];
    if (index != LINKED_LIST_ELEMETN_NOT_FOUND) {
        [self.list replaceObjectAtIndex:index withObject:object];
    } else {
        [self.list addObject:object];
    }
}

- (void)removeObject:(id)object {
    [self.list removeObject:object];
}

- (NSMutableArray<id> *)traversal {
    NSInteger size = self.list.count;
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < size; i++) {
        [array addObject:[self.list objectAtIndex:i]];
    }
    return array;
}

- (LinkedCircleList *)list {
    if (!_list) {
        _list = [LinkedCircleList new];
    }
    return _list;
}

@end
