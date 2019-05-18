//
//  SingleCircleLinkedList.h
//  LinkedList
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static const NSInteger SINGLE_LINKED_LIST_ELEMETN_NOT_FOUND = -1;

@interface SingleCircleLinkedListNode : NSObject

/// 节点保存的元素
@property (nonatomic, strong, nullable) id element;
/// 下一个节点，防止只有一个节点的时候出现循环引用
@property (nonatomic, weak, nullable) SingleCircleLinkedListNode *weakNext;
/// 下一个节点
@property (nonatomic, strong, nullable) SingleCircleLinkedListNode *next;

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
/// 初始化节点
- (instancetype)initWithElement:(nullable id)element next:(nullable SingleCircleLinkedListNode *)next;

@end


@interface SingleCircleLinkedList<ObjectType> : NSObject

/// 头节点
@property (nonatomic, strong, nullable) SingleCircleLinkedListNode *first;

/// 添加一个元素
- (void)addObject:(nullable ObjectType)object;
/// 插入一个元素
- (void)addObject:(nullable ObjectType)object addIndex:(NSUInteger)index;
/// 删除index对应的元素
- (ObjectType)removeObjectAtIndex:(NSUInteger)index;
/// 删除元素
- (ObjectType)removeObject:(nullable ObjectType)object;
/// 第一个元素
- (ObjectType)firstObject;
/// 删除最后一个元素
- (void)removeLastObject;
/// 元素个数
- (NSUInteger)count;
/// 获取元素的index
- (NSInteger)indexOfObject:(nullable ObjectType)object;
/// 是否包含元素
- (BOOL)containsObject:(nullable ObjectType)object;
/// 删除所有元素
- (void)removeAllObjects;
/// 获取对应index的元素
- (ObjectType)objectAtIndex:(NSUInteger)index;
/// 替换对应index的元素
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)object;

@end

NS_ASSUME_NONNULL_END
