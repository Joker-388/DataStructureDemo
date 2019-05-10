//
//  main.m
//  SingleCircleLinkedList
//
//  Created by Joker on 2019/5/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "SingleCircleLinkedList.h"

void test() {
    SingleCircleLinkedList *linkList = [SingleCircleLinkedList new];
    for (NSInteger i = 0; i < 8; i++) {
        [linkList addObject:[NSNumber numberWithInteger:i + 1]];
    }
    
    Node *node = linkList.first;
    while (linkList.count) {
        node = node.next;
        node = node.next;
        NSLog(@"%@", [linkList removeObject:node.element]);
        node = node.next;
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test();
    }
    return 0;
}
