//
//  Person.h
//  TreeDemo
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JKRBinarySearchTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
// <JKRBinarySearchTreeCompare>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithAge:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
