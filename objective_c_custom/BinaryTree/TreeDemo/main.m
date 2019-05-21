//
//  main.m
//  TreeDemo
//
//  Created by Lucky on 2019/4/30.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRBinarySearchTree.h"
#import "JKRAVLTree.h"
#import "JKRRedBlackTree.h"
#import "JKRTimeTool.h"


NSString * getRandomStr() {
    char data[6];
    for (int i = 0; i < 6; i++) data[i] = (char)((i ? 'a' : 'A') + (arc4random_uniform(26)));
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    return string;
}

void testBinarySearchTree() {
    JKRBinarySearchTree<NSNumber *> *tree = [[JKRBinarySearchTree alloc] initWithCompare:^int(NSNumber *  _Nonnull e1, NSNumber *  _Nonnull e2) {
        return e1.intValue - e2.intValue;
    }];
    
    NSSet *set;
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];
    [set allObjects];
    
    int nums[] = {7,4,2,1,3,5,9,8,11,10,12};
    NSMutableArray *numbers = [NSMutableArray array];
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
        printf("%d ", nums[i]);
        [numbers addObject:[NSNumber numberWithInt:nums[i]]];
    }
    printf("\n");
    
    for (NSNumber *number in numbers) {
        [tree addObject:number];
    }
    
    /// 打印二叉树
    NSLog(@"\n-------- 原二叉树 --------");
    [tree printTree];
    
//    NSLog(@"\n-------- 递归翻转 --------");
//    [tree invertByRecursion];
//    [tree printTree];
//
//    NSLog(@"\n前序 %@", tree.preorderTraversal);
//
//    /// 后序 1 3 2 5 4 8 10 12 11 9 7
//    NSLog(@"\n后序 %@", tree.postorderTraversal);
//
//    /// 中序 1 2 3 4 5 7 8 9 10 11 12
//    NSLog(@"\n中序 %@", tree.inorderTraversal);
//
//    /// 层序
//    NSLog(@"\n层序 %@", tree.levelOrderTraversal);
//
//    NSLog(@"\n-------- 迭代翻转 --------");
//    [tree invertByIteration];
//    [tree printTree];
    
    NSLog(@"\n二叉树高度: %zd", tree.height);
    
    NSLog(@"\n二叉树节点个数: %zd", tree.count);
    /// 前序 7 4 2 1 3 5 9 8 11 10 12
    NSLog(@"\n前序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypePreorder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypePreorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@4]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];
    
    /// 后序 1 3 2 5 4 8 10 12 11 9 7
    NSLog(@"\n后序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypePostorder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypePostorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@4]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];

    /// 中序 1 2 3 4 5 7 8 9 10 11 12
    NSLog(@"\n中序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypeInorder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypeInorder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@4]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];

    /// 层序 7 4 9 2 5 8 11 1 3 10 12
    NSLog(@"\n层序 %@", [tree allObjectsWithTraversalType:JKRBinaryTreeTraversalTypeLevelOrder]);
    [tree enumerateObjectsWithTraversalType:JKRBinaryTreeTraversalTypeLevelOrder usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@11]) {
            *stop = YES;
        }
        NSLog(@"%@", obj);
    }];
    
    /// 清空
    [tree removeAllObjects];
}

void testAVLTree() {
    JKRBinarySearchTree<NSNumber *> *avl = [JKRAVLTree new];
    avl.debugPrint = YES;
    
    int nums[] = {26, 32, 27, 38, 4, 9, 37, 45, 3, 6, 13, 2, 43, 40, 25, 46, 23, 10, 41, 11, 1, 24};
    NSMutableArray *numbers = [NSMutableArray array];
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
        printf("%d ", nums[i]);
        [numbers addObject:[NSNumber numberWithInt:nums[i]]];
    }

    for (NSNumber *number in numbers) {
        [avl addObject:number];
        printf("--- 平衡后结果 ---\n%s\n\n", [avl.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
}

void testRedBlackTree() {
    JKRBinarySearchTree<NSNumber *> *rb = [JKRRedBlackTree new];
    rb.debugPrint = YES;
    int nums[] = {55,38,80,25,46,76,88,17,33,50,72,20,52,60};
    
    NSMutableArray *numbers = [NSMutableArray array];
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
        printf("%d ", nums[i]);
        [numbers addObject:[NSNumber numberWithInt:nums[i]]];
    }
    
    for (NSNumber *number in numbers) {
        printf("Add: %d\n\n", number.intValue);
        [rb addObject:number];
        printf("--- 最终平衡后结果 ---\n%s\n\n", [rb.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
    
    for (NSNumber *number in numbers) {
        printf("Remove: %d\n\n", number.intValue);
        [rb removeObject:number];
        printf("--- 最终平衡后结果 ---\n%s\n\n", [rb.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
}

void compare() {
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 10000; i++) {
//        [data addObject:getRandomStr()];
        [data addObject:[NSNumber numberWithInteger:i]];
    }
    
    @autoreleasepool {
        [JKRTimeTool teskCodeWithBlock:^{
            JKRBinarySearchTree *tree = [JKRBinarySearchTree new];
            for (int i = 0; i < data.count; i++) {
                [tree addObject:data[i]];
            }
            for (int i = 0; i < data.count; i++) {
                [tree removeObject:data[i]];
            }
        }];
    }
    
    @autoreleasepool {
        [JKRTimeTool teskCodeWithBlock:^{
            JKRBinarySearchTree *tree = [JKRAVLTree new];
            for (int i = 0; i < data.count; i++) {
                [tree addObject:data[i]];
            }
            for (int i = 0; i < data.count; i++) {
                [tree removeObject:data[i]];
            }
        }];
    }
    
    @autoreleasepool {
        [JKRTimeTool teskCodeWithBlock:^{
            JKRBinarySearchTree *tree = [JKRRedBlackTree new];
            for (int i = 0; i < data.count; i++) {
                [tree addObject:data[i]];
            }
            for (int i = 0; i < data.count; i++) {
                [tree removeObject:data[i]];
            }
        }];
    }
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testBinarySearchTree();
//        testAVLTree();
        testRedBlackTree();
//        compare();
    }
    
    return 0;
}
