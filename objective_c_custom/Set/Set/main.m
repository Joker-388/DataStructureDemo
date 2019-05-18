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

void compareListSetAndTreeSet(NSArray *params) {
//    [JKRTimeTool teskCodeWithBlock:^{
//        ListSet *set = [ListSet new];
//        [params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [set addObject:obj];
//        }];
//        NSLog(@"ListSet计算不重复单词数量：%zd", set.count);
//    }];
    [JKRTimeTool teskCodeWithBlock:^{
        TreeSet *set = [TreeSet new];
        [params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        NSLog(@"TreeSet计算不重复单词数量：%zd", set.count);
    }];
}

NSMutableArray * allFileStrings() {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileManagerError;
    NSString *fileDirectory = @"/Users/lucky/Documents/JKRCode/DataStructureDemo/objective_c_custom/Set/runtime";
    NSArray<NSString *> *array = [fileManager subpathsOfDirectoryAtPath:fileDirectory error:&fileManagerError];
    if (fileManagerError) {
        NSLog(@"读取文件夹失败");
        nil;
    }
    NSLog(@"文件个数: %zd", array.count);
    NSMutableArray *allStrings = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filePath = [fileDirectory stringByAppendingPathComponent:obj];
        NSError *fileReadError;
        NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&fileReadError];
        if (fileReadError) {
            return;
        }
        [str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            [allStrings addObject:substring];
        }];
    }];
    NSLog(@"所有单词的数量: %zd", allStrings.count);
    return allStrings;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // testListSet(); // 114.24ms
        // testTreeSet(); // 7.94ms
        NSMutableArray *allStrings = allFileStrings();
        compareListSetAndTreeSet(allStrings);
    }
    return 0;
}
