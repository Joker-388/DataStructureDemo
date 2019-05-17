//
//  main.m
//  Set
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListSet.h"
#import "SingleCircleLinkedList.h"
#import "JKRTimeTool.h"
#import "TreeSet.h"

void testListSet() {
    [JKRTimeTool teskCodeWithBlock:^{
        ListSet *set = [ListSet new];
        for (NSInteger i = 0; i < 1000; i++) {
            [set addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSInteger i = 0; i < 1000; i++) {
            [set addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSInteger i = 0; i < 1000; i++) {
            [set addObject:[NSNumber numberWithInteger:i]];
        }
//        NSLog(@"%@", set.traversal);
        for (NSInteger i = 0; i < 1000; i++) {
            [set removeObject:[NSNumber numberWithInteger:i]];
        }
//        NSLog(@"%@", set.traversal);
    }];
    
}

void testTreeSet() {
    [JKRTimeTool teskCodeWithBlock:^{
        TreeSet *set = [TreeSet new];
        for (NSInteger i = 0; i < 1000; i++) {
            [set addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSInteger i = 0; i < 1000; i++) {
            [set addObject:[NSNumber numberWithInteger:i]];
        }
        for (NSInteger i = 0; i < 1000; i++) {
            [set addObject:[NSNumber numberWithInteger:i]];
        }
        
//        NSLog(@"%@", set.traversal);
        for (NSInteger i = 0; i < 1000; i++) {
            [set removeObject:[NSNumber numberWithInteger:i]];
        }
//        NSLog(@"%@", set.traversal);
    }];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testListSet(); // 114.24ms
        testTreeSet(); // 7.94ms
    }
    return 0;
}
