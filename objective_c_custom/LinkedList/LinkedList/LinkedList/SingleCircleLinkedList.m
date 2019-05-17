//
//  SingleCircleLinkedList.m
//  LinkedList
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "SingleCircleLinkedList.h"

@implementation SingleCircleLinkedListNode

- (instancetype)initWithElement:(id)element next:(SingleCircleLinkedListNode *)next {
    self = [super init];
    self.element = element;
    self.next = next;
    return self;
}

- (SingleCircleLinkedListNode *)next {
    if (_next) {
        return _next;
    } else {
        return _weakNext;
    }
}

- (void)dealloc {
    NSLog(@"<%@: %p>: %@ dealloc", self.className, self, self.element);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ -> (%@)", self.element, self.next.element];
}

@end

@interface SingleCircleLinkedList ()

@property (nonatomic, assign) NSInteger size;

@end

@implementation SingleCircleLinkedList

- (void)addObject:(id)object {
    [self addObject:object addIndex:self.size];
}

- (void)addObject:(id)object addIndex:(NSInteger)index {
    [self rangeCheckForAddWithIndex:index];
    
    if (index == 0) {
        SingleCircleLinkedListNode *node = [[SingleCircleLinkedListNode alloc] initWithElement:object next:self.first];
        SingleCircleLinkedListNode *last = (self.size == 0) ? node : [self nodeWithIndex:self.size - 1];
        last.next = node;
        last.weakNext = nil;
        self.first = node;
    } else {
        SingleCircleLinkedListNode *prev = [self nodeWithIndex:index - 1];
        SingleCircleLinkedListNode *node = [[SingleCircleLinkedListNode alloc] initWithElement:object next:prev.next];
        prev.next = node;
        prev.weakNext = nil;
    }
    
    if (self.first.next == self.first) {
        self.first.next = nil;
        self.first.weakNext = self.first;
    }
    self.size++;
}

- (id)removeObjectAtIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index];
    SingleCircleLinkedListNode *node = self.first;
    if (index == 0) {
        if (self.size == 1) {
            self.first = nil;
        } else {
            SingleCircleLinkedListNode *last = [self nodeWithIndex:self.size - 1];
            self.first = self.first.next;
            last.next = self.first;
            last.weakNext = nil;
        }
    } else {
        SingleCircleLinkedListNode *prev = [self nodeWithIndex:index - 1];
        node = prev.next;
        prev.next = node.next;
        prev.weakNext = nil;
    }
    
    if (self.first.next == self.first) {
        self.first.next = nil;
        self.first.weakNext = self.first;
    }
    self.size--;
    return node.element;
}

- (id)removeObject:(id)object {
    NSInteger index = [self indexOfObject:object];
    if (index == SINGLE_LINKED_LIST_ELEMETN_NOT_FOUND) {
        return nil;
    } else {
        return [self removeObjectAtIndex:index];
    }
}

- (NSInteger)indexOfObject:(id)object {
    if (!object) {
        SingleCircleLinkedListNode *node = self.first;
        for (int i = 0; i < self.size; i++) {
            if (!node.element) {
                return i;
            }
            node = node.next;
        }
    } else {
        SingleCircleLinkedListNode *node = self.first;
        for (int i = 0; i < self.size; i++) {
            if ([object isEqual:node.element]) {
                return i;
            }
            node = node.next;
        }
    }
    return SINGLE_LINKED_LIST_ELEMETN_NOT_FOUND;
}

- (NSInteger)count {
    return self.size;
}

- (id)objectAtIndex:(NSInteger)index {
    return [self nodeWithIndex:index].element;
}

- (void)replaceObjectAtIndex:(NSInteger)index withObject:(id)object {
    SingleCircleLinkedListNode *node = [self nodeWithIndex:index];
    node.element = object;
}

- (void)removeAllObjects {
    self.size = 0;
    self.first = nil;
}

- (SingleCircleLinkedListNode *)nodeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index];
    SingleCircleLinkedListNode *node = self.first;
    for (NSInteger i = 0; i < index; i++) {
        node = node.next;
    }
    return node;
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

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"Size: %zd [", self.size]];
    SingleCircleLinkedListNode *node = self.first;
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

- (void)dealloc {
    NSLog(@"<%@: %p> dealloc", self.className, self);
}

@end


