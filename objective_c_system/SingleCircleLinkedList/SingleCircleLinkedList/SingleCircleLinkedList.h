//
//  SingleCircleLinkedList.h
//  SingleCircleLinkedList
//
//  Created by Joker on 2019/5/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

NS_ASSUME_NONNULL_BEGIN

static const NSInteger ELEMETN_NOT_FOUND = -1;

@interface SingleCircleLinkedList<E> : NSObject

@property (nonatomic, strong, nullable) Node *first;

- (void)addObject:(nullable E)object;
- (void)addObject:(nullable E)object addIndex:(NSInteger)index;

- (E)removeObjectAtIndex:(NSInteger)index;
- (E)removeObject:(nullable E)object;

- (E)firstObject;
- (void)removeLastObject;

- (NSInteger)count;
- (NSInteger)indexOfObject:(nullable E)object;
- (void)removeAllObjects;

- (E)objectAtIndex:(NSInteger)index;
- (void)replaceObjectAtIndex:(NSInteger)index withObject:(E)object;

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
