//
//  LinkedCircleList.h
//  LinkedList
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger LINKED_LIST_ELEMETN_NOT_FOUND = -1;

NS_ASSUME_NONNULL_BEGIN

@interface LinkedCircleListNode : NSObject

@property (nonatomic, strong, nullable) id element;
@property (nonatomic, weak, nullable) LinkedCircleListNode *weakNext;
@property (nonatomic, strong, nullable) LinkedCircleListNode *next;
@property (nonatomic, weak, nullable) LinkedCircleListNode *prev;

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithPrev:(LinkedCircleListNode *)prev element:(nullable id)element next:(nullable LinkedCircleListNode *)next;

@end

@interface LinkedCircleList<ObjectType> : NSObject

@property (nonatomic, strong, nullable) LinkedCircleListNode *first;
@property (nonatomic, strong, nullable) LinkedCircleListNode *last;

- (void)addObject:(nullable ObjectType)object;
- (void)addObject:(nullable ObjectType)object addIndex:(NSUInteger)index;

- (ObjectType)removeObjectAtIndex:(NSInteger)index;
- (ObjectType)removeObject:(nullable ObjectType)object;

- (ObjectType)firstObject;
- (void)removeLastObject;

- (NSUInteger)count;
- (NSInteger)indexOfObject:(nullable ObjectType)object;
- (BOOL)containsObject:(nullable ObjectType)object;
- (void)removeAllObjects;

- (ObjectType)objectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)object;

- (void)insertValue:(id)value inPropertyWithKey:(NSString *)key __unavailable;
- (void)insertValue:(id)value atIndex:(NSUInteger)index inPropertyWithKey:(NSString *)key __unavailable;
- (void)removeValueAtIndex:(NSUInteger)index fromPropertyWithKey:(NSString *)key __unavailable;
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context __unavailable;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath __unavailable;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context __unavailable;
- (id)replacementObjectForCoder:(NSCoder *)aCoder __unavailable;
- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver __unavailable;
- (void)replaceValueAtIndex:(NSUInteger)index inPropertyWithKey:(NSString *)key withValue:(id)value __unavailable;
- (BOOL)respondsToSelector:(SEL)aSelector __unavailable;

@end

NS_ASSUME_NONNULL_END
