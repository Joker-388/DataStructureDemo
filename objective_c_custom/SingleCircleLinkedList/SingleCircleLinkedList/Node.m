//
//  Node.m
//  SingleCircleLinkedList
//
//  Created by Joker on 2019/5/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithElement:(id)element next:(Node *)next {
    self = [super init];
    self.element = element;
    self.next = next;
    return self;
}

- (Node *)next {
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
