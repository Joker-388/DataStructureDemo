//
//  LinkedCircleList.m
//  LinkedList
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "LinkedCircleList.h"

@implementation LinkedCircleListNode

- (instancetype)initWithPrev:(LinkedCircleListNode *)prev element:(id)element next:(LinkedCircleListNode *)next {
    self = [super init];
    self.element = element;
    self.next = next;
    self.prev = prev;
    return self;
}

- (LinkedCircleListNode *)next {
    if (_next) {
        return _next;
    } else {
        return _weakNext;
    }
}

- (void)dealloc {
//    NSLog(@"<%@: %p>: %@ dealloc", self.className, self, self.element);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@) -> %@ -> (%@)", self.prev.element, self.element, self.next.element];
}

@end

@interface LinkedCircleList ()

@property (nonatomic, assign) NSUInteger size;

@end

@implementation LinkedCircleList

- (void)addObject:(id)object {
    [self addObject:object addIndex:self.size];
}

- (void)addObject:(id)object addIndex:(NSUInteger)index {
    [self rangeCheckForAddWithIndex:index];
    // index == size 相当于 插入到表尾 或者 空链表添加第一个节点
    if (self.size == index) {
        LinkedCircleListNode *oldLast = self.last;
        LinkedCircleListNode *node = [[LinkedCircleListNode alloc] initWithPrev:self.last element:object next:self.first];
        self.last = node;
        if (!oldLast) { // 添加链表第一个元素
            self.first = self.last;
            self.first.prev = self.first;
            self.first.next = self.first;
        } else { // 插入到表尾
            oldLast.next = self.last;
            self.first.prev = self.last;
        }
    } else { // 插入到表的非空节点的位置上
        LinkedCircleListNode *next = [self nodeWithIndex:index];
        LinkedCircleListNode *prev = next.prev;
        LinkedCircleListNode *node = [[LinkedCircleListNode alloc] initWithPrev:prev element:object next:next];
        next.prev = node;
        prev.next = node;
        if (next == self.first) {
            self.first = node;
        }
    }
    if (self.first.next == self.first) {
        self.first.next = nil;
        self.first.weakNext = self.first;
    }
    self.size++;
}

- (id)removeObject:(id)object {
    NSInteger index = [self indexOfObject:object];
    if (index == LINKED_LIST_ELEMETN_NOT_FOUND) {
        return nil;
    } else {
        return [self removeObjectAtIndex:index];
    }
}

- (id)removeObjectAtIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index];
    LinkedCircleListNode *node = self.first;
    if (self.size == 1) {
        self.first = nil;
        self.last = nil;
    } else {
        node = [self nodeWithIndex:index];
        LinkedCircleListNode *prev = node.prev;
        LinkedCircleListNode *next = node.next;
        prev.next = next;
        next.prev = prev;
        if (node == self.first) {
            self.first = next;
        }
        if (node == self.last) {
            self.last = prev;
        }
    }
    if (self.first.next == self.first) {
        self.first.next = nil;
        self.first.weakNext = self.first;
    }
    self.size--;
    return node.element;
}

- (NSInteger)indexOfObject:(id)object {
    if (!object) {
        LinkedCircleListNode *node = self.first;
        for (NSUInteger i = 0; i < self.size; i++) {
            if (!node.element) {
                return i;
            }
            node = node.next;
        }
    } else {
        LinkedCircleListNode *node = self.first;
        for (NSUInteger i = 0; i < self.size; i++) {
            if ([object isEqual:node.element]) {
                return i;
            }
            node = node.next;
        }
    }
    return LINKED_LIST_ELEMETN_NOT_FOUND;
}

- (NSUInteger)count {
    return self.size;
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self nodeWithIndex:index].element;
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    LinkedCircleListNode *node = [self nodeWithIndex:index];
    node.element = object;
}

- (void)removeAllObjects {
    self.size = 0;
    // 防止循环引用造成无法清空
    self.last.next = nil;
    self.first = nil;
    self.last = nil;
}

- (id)firstObject {
    return [self objectAtIndex:0];
}

- (void)removeLastObject {
    [self removeObjectAtIndex:self.size - 1];
}

- (void)rangeCheckWithIndex:(NSInteger)index {
    if (index < 0 || index >= self.size) {
        [self outOfBoundsWithIndex:index];
    }
}

- (void)rangeCheckForAddWithIndex:(NSInteger)index {
    if (index < 0 || index > self.size) {
        [self outOfBoundsWithIndex:index];
    }
}

- (void)outOfBoundsWithIndex:(NSInteger)index {
    NSAssert(YES, @"Index: %zd, Size: %zd", index, self.size);
}

- (LinkedCircleListNode *)nodeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index];
    if (index < (self.size >> 1)) {
        LinkedCircleListNode *node = self.first;
        for (NSInteger i = 0; i < index; i++) {
            node = node.next;
        }
        return node;
    } else {
        LinkedCircleListNode *node = self.last;
        for (NSInteger i = self.size - 1; i > index; i--) {
            node = node.prev;
        }
        return node;
    }
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"Size: %zd [", self.size]];
    LinkedCircleListNode *node = self.first;
    for (NSInteger i = 0; i < self.size; i++) {
        if (i != 0) {
            [string appendString:@", "];
        }
        [string appendString:[NSString stringWithFormat:@"%@", node]];
        node = node.next;
    }
    [string appendString:@"]"];
    return string;
}

- (BOOL)containsObject:(id)object {
    return [self indexOfObject:object] != LINKED_LIST_ELEMETN_NOT_FOUND;
}

- (void)dealloc {
    NSLog(@"<%@: %p> dealloc", self.className, self);
}

@end
