//
//  Set.h
//  Set
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 集合的统一接口
@protocol SetProtocol <NSObject>

@required
/// 集合元素个数
- (NSUInteger)count;
/// 移除所有元素
- (void)removeAllObjects;
/// 是否包含某元素
- (BOOL)containsObject:(id)object;
/// 添加元素
- (void)addObject:(id)object;
/// 移除元素
- (void)removeObject:(id)object;
/// 集合的全部元素
- (NSMutableArray<id> *)traversal;

@end

@interface Set : NSObject<SetProtocol>

@end

NS_ASSUME_NONNULL_END
