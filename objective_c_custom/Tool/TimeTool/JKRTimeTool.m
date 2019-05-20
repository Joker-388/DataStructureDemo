//
//  JKRTimeTool.m
//  test
//
//  Created by Joker on 2019/5/7.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRTimeTool.h"

@implementation JKRTimeTool

+ (void)teskCodeWithBlock:(void (^)(void))block {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    block();
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    NSLog(@"耗时: %.2f ms", linkTime * 1000.0);
}

@end
