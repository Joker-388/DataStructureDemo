//
//  main.m
//  LinkedList
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleCircleLinkedList.h"


void testSingleCircleLinkedLis() {
    SingleCircleLinkedList *linkList = [SingleCircleLinkedList new];
    for (NSInteger i = 0; i < 8; i++) {
        [linkList addObject:[NSNumber numberWithInteger:i + 1]];
    }
    
    SingleCircleLinkedListNode *node = linkList.first;
    while (linkList.count) {
        node = node.next;
        node = node.next;
        NSLog(@"%@", [linkList removeObject:node.element]);
        node = node.next;
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testSingleCircleLinkedLis();
    }
    return 0;
}
