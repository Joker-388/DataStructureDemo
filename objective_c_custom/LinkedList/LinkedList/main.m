//
//  main.m
//  LinkedList
//
//  Created by Joker on 2019/5/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleCircleLinkedList.h"
#import "LinkedCircleList.h"

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

void testLinkedCircleList() {
    LinkedCircleList *linkList = [LinkedCircleList new];
    for (NSInteger i = 0; i < 8; i++) {
        [linkList addObject:[NSNumber numberWithInteger:i + 1]];
    }
    NSLog(@"%@", linkList);
    LinkedCircleListNode *node = linkList.first;
    while (linkList.count) {
        node = node.next;
        node = node.next;
        NSLog(@"%@", [linkList removeObject:node.element]);
        NSLog(@"%@", linkList);
        node = node.next;
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testLinkedCircleList();
    }
    return 0;
}
