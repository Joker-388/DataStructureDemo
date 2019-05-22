//
//  JKRArray.h
//  HashMapSet
//
//  Created by Joker on 2019/5/22.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRArray : NSObject

+ (instancetype)arrayWithLength:(NSUInteger)length;
- (instancetype)initWithLength:(NSUInteger)length;

- (NSUInteger)length;
- (void)setObject:(nullable NSObject *)object AtIndex:(NSUInteger)index;
- (nullable id)objectAtIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
