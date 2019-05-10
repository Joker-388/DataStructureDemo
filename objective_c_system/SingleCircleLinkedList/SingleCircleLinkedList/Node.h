//
//  Node.h
//  SingleCircleLinkedList
//
//  Created by Joker on 2019/5/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Node : NSObject

@property (nonatomic, strong, nullable) id element;
@property (nonatomic, weak, nullable) Node *weakNext;
@property (nonatomic, strong, nullable) Node *next;

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithElement:(nullable id)element next:(nullable Node *)next;

@end

NS_ASSUME_NONNULL_END
