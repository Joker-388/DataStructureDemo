//
//  Set.h
//  Set
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SetProtocol <NSObject>

@required
- (NSUInteger)count;
- (void)removeAllObjects;
- (BOOL)containsObject:(id)object;
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (NSMutableArray<id> *)traversal;

@end

@interface Set : NSObject<SetProtocol>

@end

NS_ASSUME_NONNULL_END
