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
    id oldObject = [self objectAtIndex:index];
    if (oldObject == object) {
        return;
    } else if (oldObject != nil) {
        [oldObject release];
    }
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

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    [self setObject:obj AtIndex:idx];
}

- (void)dealloc {
    for (NSUInteger i = 0; i < self.length; i++) {
        id object = [self objectAtIndex:i];
        if (object) [object release];
    }
    [super dealloc];
}

- (NSString *)description {
    NSMutableString *mutableString = [NSMutableString string];
    [mutableString appendString:[NSString stringWithFormat:@"<%@: %p>: \n   {\n", self.className, self]];
    for (NSUInteger i = 0; i < self.length; i++) {
        if (i) {
            [mutableString appendString:@"\n"];
        }
        id object = [self objectAtIndex:i];
        if (object) {
            [mutableString appendString:@"      "];
            [mutableString appendString:[object description]];
        } else {
            [mutableString appendString:@"      "];
            [mutableString appendString:@"Null"];
        }
    }
    [mutableString appendString:@"\n   }"];
    return mutableString;
}

@end

