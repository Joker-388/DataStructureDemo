//
//  JKRHashMap.m
//  HashMapSet
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRHashMap.h"
#import "Person.h"

@interface JKRHashMap () {
    id *_array;
}

@end

@implementation JKRHashMap

- (instancetype)init {
    self = [super init];
    _array = new id[100];
    
    return self;
}

- (void)setObject:(id)object forKey:(id<NSCopying>)key {
    [object retain];
    _array[3] = object;
    _size++;
}

- (void)dealloc {
    [_array[3] release];
    delete [] _array;
    NSLog(@"<%@: %p> dealloc", self.className, self);
    [super dealloc];
}

- (NSUInteger)count {
    NSLog(@"%@", _array[3]);
    return 0;
}

@end
