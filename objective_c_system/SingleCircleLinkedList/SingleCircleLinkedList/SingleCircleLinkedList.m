//
//  SingleCircleLinkedList.m
//  SingleCircleLinkedList
//
//  Created by Joker on 2019/5/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "SingleCircleLinkedList.h"

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
        Node *node = [[Node alloc] initWithElement:object next:self.first];
        Node *last = (self.size == 0) ? node : [self nodeWithIndex:self.size - 1];
        last.next = node;
        last.weakNext = nil;
        self.first = node;
    } else {
        Node *prev = [self nodeWithIndex:index - 1];
        Node *node = [[Node alloc] initWithElement:object next:prev.next];
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
    Node *node = self.first;
    if (index == 0) {
        if (self.size == 1) {
            self.first = nil;
        } else {
            Node *last = [self nodeWithIndex:self.size - 1];
            self.first = self.first.next;
            last.next = self.first;
            last.weakNext = nil;
        }
    } else {
        Node *prev = [self nodeWithIndex:index - 1];
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
    if (index == ELEMETN_NOT_FOUND) {
        return nil;
    } else {
        return [self removeObjectAtIndex:index];
    }
}

- (NSInteger)indexOfObject:(id)object {
    if (!object) {
        Node *node = self.first;
        for (int i = 0; i < self.size; i++) {
            if (!node.element) {
                return i;
            }
            node = node.next;
        }
    } else {
        Node *node = self.first;
        for (int i = 0; i < self.size; i++) {
            if ([object isEqual:node.element]) {
                return i;
            }
            node = node.next;
        }
    }
    return ELEMETN_NOT_FOUND;
}

- (NSInteger)count {
    return self.size;
}

- (id)objectAtIndex:(NSInteger)index {
    return [self nodeWithIndex:index].element;
}

- (void)replaceObjectAtIndex:(NSInteger)index withObject:(id)object {
    Node *node = [self nodeWithIndex:index];
    node.element = object;
}

- (void)removeAllObjects {
    self.size = 0;
    self.first = nil;
}

- (Node *)nodeWithIndex:(NSInteger)index {
    [self rangeCheckWithIndex:index];
    Node *node = self.first;
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
    Node *node = self.first;
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
