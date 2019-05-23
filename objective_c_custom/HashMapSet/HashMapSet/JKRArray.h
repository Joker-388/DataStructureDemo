//
//  JKRArray.h
//  HashMapSet
//
//  Created by Joker on 2019/5/22.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRArray<ObjectType> : NSObject

+ (instancetype)arrayWithLength:(NSUInteger)length;
- (instancetype)initWithLength:(NSUInteger)length;
- (NSUInteger)length;
- (_Nullable ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(_Nullable ObjectType)obj atIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
