//
//  Person.m
//  TreeDemo
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithAge:(NSInteger)age {
    Person *p = [Person new];
    p.age = age;
    return p;
}

- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (!object || ![object isMemberOfClass:[Person class]])return NO;
    return self.age == ((Person *)object).age && (self.name ? [self.name isEqualToString:((Person *)object).name] : !((Person *)object).name);
}

//- (int)binaryTreeCompare:(id)object {
//    if (![object isMemberOfClass:[Person class]]) {
//        NSAssert(NO, @"object class must be Person!");
//    }
//    return (int)(self.age - ((Person *)object).age);
//}

- (NSString *)description {
    return [NSString stringWithFormat:@"%zd", self.age];
}

@end
