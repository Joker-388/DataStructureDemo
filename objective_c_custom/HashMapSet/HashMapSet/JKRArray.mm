//
//  JKRArray.m
//  HashMapSet
//
//  Created by Joker on 2019/5/22.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRArray.h"

@interface JKRArray () {
    void ** _array;
}

@property (nonatomic, assign) NSUInteger length;

@end

@implementation JKRArray

+ (instancetype)arrayWithLength:(NSUInteger)length {
    JKRArray *array = [[JKRArray alloc] initWithLength:length];
    return array;
}

- (instancetype)initWithLength:(NSUInteger)length {
    self = [super init];
    self.length = length;
    _array = new void*[length]();
    return self;;
}

- (void)setObject:(id)object AtIndex:(NSUInteger)index {
    [self checkRangeWithIndex:index];
    if (object) [object retain];
    *(_array + index) = (__bridge void *)object;
}

- (id)objectAtIndex:(NSUInteger)index {
    [self checkRangeWithIndex:index];
    id object = (__bridge id)(*(_array + index));
    return object;
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self checkRangeWithIndex:index];
    id object = (__bridge id)(*(_array + index));
    if (object) [object release];
    *(_array + index) = 0;
}

- (void)checkRangeWithIndex:(NSUInteger)index {
    if (index < 0 || index >= self.length) {
        NSAssert(NO, @"Index: %zd, Length: %zd", index, self.length);
    }
}

- (NSUInteger)length {
    return _length;
}

- (void)dealloc {
    for (NSUInteger i = 0; i < self.length; i++) {
        id object = [self objectAtIndex:i];
        if (object) [object release];
    }
    [super dealloc];
}

@end

