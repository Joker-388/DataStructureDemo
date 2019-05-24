//
//  main.m
//  TreeMapSet
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRTreeMap.h"
#import "JKRTreeSet.h"
#import "JKRTimeTool.h"

NSMutableArray * allFileStrings() {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileManagerError;
    NSString *fileDirectory = @"/Users/joker/Documents/Stu/DataStructureDemo/objective_c_custom/Resource/runtime";
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

void test1() {
    JKRTreeMap *map = [JKRTreeMap new];
    [map setObject:@"1" forKey:@"a"];
    [map setObject:@"2" forKey:@"b"];
    [map setObject:@"3" forKey:@"c"];
    [map setObject:@"5" forKey:@"b"];
    [map setObject:@"5" forKey:@"b"];
    [map setObject:@"8" forKey:@"b"];
    [map setObject:nil forKey:@"d"];
    [map setObject:@"8" forKey:@"d"];
    [map setObject:nil forKey:@"d"];
    
    [map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@: %@", key, obj);
        if ([key isEqualToString:@"b"]) {
            //            *stop = YES;
        }
    }];
}

void test2() {
    [JKRTimeTool teskCodeWithBlock:^{
        JKRTreeMap *map = [JKRTreeMap new];
        NSMutableArray *allStrings = allFileStrings();
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        NSLog(@"Map 计算不重复单词数量 %zd", map.count);
    }];
}

void test3() {
    JKRTreeSet *set = [JKRTreeSet new];
    for (NSInteger i = 0; i < 10; i++) {
        [set addObject:[NSNumber numberWithInteger:i]];
    }
    for (NSInteger i = 0; i < 10; i++) {
        [set addObject:[NSNumber numberWithInteger:i]];
    }
    for (NSInteger i = 0; i < 10; i++) {
        [set addObject:[NSNumber numberWithInteger:i]];
    }
    
    //        NSLog(@"%@", set.traversal);
    //    for (NSInteger i = 0; i < 10; i++) {
    //        [set removeObject:[NSNumber numberWithInteger:i]];
    //    }
    //        NSLog(@"%@", set.traversal);
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
        if ([obj integerValue] == 6) {
            *stop = YES;
        }
    }];
}

void test4() {
    [JKRTimeTool teskCodeWithBlock:^{
        JKRTreeSet *set = [JKRTreeSet new];
        NSMutableArray *allStrings = allFileStrings();
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        NSLog(@"Set 计算不重复单词数量 %zd", set.count);
    }];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test2();
        test4();
    }
    return 0;
}
