//
//  Person.m
//  Hash
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "Person.h"

@implementation Person

/// 作为key，hash冲突时，key是否相等
- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (!object || ![object isMemberOfClass:[Person class]])return NO;
    return self.age == ((Person *)object).age && (self.name ? [self.name isEqualToString:((Person *)object).name] : !((Person *)object).name);
}

/// 作为key，决定哈希表中的索引值
- (NSUInteger)hash {
    NSUInteger hashCode = self.age;
    hashCode = (hashCode<<5) - hashCode + [self.name hash];
    return hashCode;
}

@end
