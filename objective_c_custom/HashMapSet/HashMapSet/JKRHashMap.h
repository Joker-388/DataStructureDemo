//
//  JKRHashMap.h
//  HashMapSet
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRHashMap<__covariant KeyType, __covariant ObjectType> : NSObject {
@protected
    /// 节点个数
    NSUInteger _size;
}

/// 元素个数
- (NSUInteger)count;
/// 清空所有元素
- (void)removeAllObjects;
/// 删除元素
- (void)removeObjectForKey:(KeyType)key;
/// 添加一个元素
- (void)setObject:(nullable ObjectType)object forKey:(KeyType <NSCopying>)key;
/// 获取元素
- (nullable ObjectType)objectForKey:(KeyType)key;
/// 是否包含元素
- (BOOL)containsObject:(nullable ObjectType)object;
/// 是否包含key
- (BOOL)containsKey:(KeyType)key;
/// 遍历所有元素，stop为停止遍历标记
- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
