//
//  Person.m
//  SingleCircleLinkedList
//
//  Created by Joker on 2019/5/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
    return [NSString stringWithFormat:@"%zd", self.number];
}

- (void)dealloc {
    NSLog(@"<%@: %p>: %zd dealloc", self.className, self, self.number);
}

@end
