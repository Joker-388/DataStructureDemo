//
//  main.m
//  HashMapSet
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRTimeTool.h"
#import "JKRTreeMap.h"
#import "JKRTreeSet.h"
#import "Person.h"
#import "JKRHashMap.h"
#import "JKRHashSet.h"
#import "NSObject+JKRDataStructure.h"
#import "SubKey1.h"
#import "SubKey2.h"

#import "JKRArray.h"

NSString * getRandomStr() {
    char data[6];
    for (int i = 0; i < 6; i++) data[i] = (char)((i ? 'a' : 'A') + (arc4random_uniform(26)));
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    return string;
}

NSMutableArray * allFileStrings() {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileManagerError;
    NSString *fileDirectory = @"/Users/joker/Documents/DataStructureDemo/objective_c_custom/Resource/runtime";
    NSArray<NSString *> *array = [fileManager subpathsOfDirectoryAtPath:fileDirectory error:&fileManagerError];
    if (fileManagerError) {
        NSLog(@"读取文件夹失败");
        nil;
    }
    NSLog(@"文件路径: %@", fileDirectory);
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

void check(BOOL pass, NSString *errorString) {
    if (!pass) {
        NSLog(@"!!! 发现错误 !!! :%@", errorString);
    }
}

void testJKRArray() {
    JKRArray<Person *> *array = [JKRArray arrayWithLength:4];
    for (NSUInteger i = 0; i < 4; i++) {
        Person *p = [Person new];
        p.name = getRandomStr();
        p.age = i;
        array[i] = p;
        NSLog(@"%zd", p.jkr_addressIdentity);
    }
    
    for (Person *person in array) {
        NSLog(@"for 遍历: %@",  person);
    }
    
    for (NSUInteger i = 0; i < 4; i++) {
        NSLog(@"取值 array[%zd]: %@", i, array[i]);
    }
    NSLog(@"打印 %@", array);
    
    for (NSUInteger i = 0; i < 4; i++) {
        NSLog(@"置空 array[%zd]: nil", i, nil);
        array[i] = nil;
    }
    NSLog(@"打印 %@", array);
}

void test2() {
    JKRHashMap *map = [JKRHashMap new];
    for (NSUInteger i = 1; i <= 20; i++) {
        map[[[Key alloc] initWithValue:i]] = [NSNumber numberWithInteger:i];
    }
    for (NSUInteger i = 5; i <= 7; i++) {
        map[[[Key alloc] initWithValue:i]] = [NSNumber numberWithInteger:i + 5];
    }
    
    check(map.count == 20, [NSString stringWithFormat:@"20 : %zd", map.count]);
    check([map[[[Key alloc] initWithValue:4]] integerValue] == 4, [NSString stringWithFormat:@"4 : %@", map[[[Key alloc] initWithValue:4]]]);
    check([map[[[Key alloc] initWithValue:5]] integerValue] == 10, [NSString stringWithFormat:@"10 : %@",map[[[Key alloc] initWithValue:5]]]);
    check([map[[[Key alloc] initWithValue:6]] integerValue] == 11, [NSString stringWithFormat:@"11 : %@", map[[[Key alloc] initWithValue:6]]]);
    check([map[[[Key alloc] initWithValue:7]] integerValue] == 12, [NSString stringWithFormat:@"12 : %@", map[[[Key alloc] initWithValue:7]]]);
}

void test3() {
    JKRHashMap *map = [JKRHashMap new];
    [map setObject:@1 forKey:nil];
    [map setObject:@2 forKey:[NSObject new]];
    [map setObject:@3 forKey:@"jack"];
    [map setObject:@4 forKey:@10];
    [map setObject:@5 forKey:[NSObject new]];
    [map setObject:@6 forKey:@"jack"];
    [map setObject:@7 forKey:@10];
    [map setObject:@8 forKey:nil];
    [map setObject:nil forKey:@10];
    check(map.count == 5, [NSString stringWithFormat:@"20 : %zd", map.count]);
    check([map[nil] integerValue] == 8, @"");
    check([map[@"jack"] integerValue] == 6, @"");
    check(map[@10] == nil, @"");
    check(map[[NSObject new]] == nil, @"");
    check([map containsKey:@10], @"");
    check([map containsKey:nil], @"");
    check([map containsObject:nil], @"");
    check([map containsObject:@1] == false, @"");
}

void test4() {
    JKRHashMap *map = [JKRHashMap new];
    map[@"jack"] = @1;
    map[@"rose"] = @2;
    map[@"jim"] = @3;
    map[@"jake"] = @4;
    for (NSUInteger i = 1; i <= 10; i++) {
        map[[NSString stringWithFormat:@"test%zd", i]] = [NSNumber numberWithInteger:i];
        map[[[Key alloc] initWithValue:i]] = [NSNumber numberWithInteger:i];
    }
    
    for (NSUInteger i = 5; i <= 7; i++) {
        Key *key = [[Key alloc] initWithValue:i];
        NSNumber *number = [map objectForKey:key];
        check(number.integerValue == i, @"");
        [map removeObjectForKey:key];
    }
 
    for (NSUInteger i = 1; i <= 3; i++) {
        map[[[Key alloc] initWithValue:i]] = [NSNumber numberWithInteger:i + 5];
    }
    
    check(map.count == 21, @"");
    check([map[[[Key alloc] initWithValue:1]] integerValue] == 6, @"");
    check([map[[[Key alloc] initWithValue:2]] integerValue] == 7, @"");
    check([map[[[Key alloc] initWithValue:3]] integerValue] == 8, @"");
    check([map[[[Key alloc] initWithValue:4]] integerValue] == 4, @"");
    check(map[[[Key alloc] initWithValue:5]] == nil, @"");
    check(map[[[Key alloc] initWithValue:6]] == nil, @"");
    check(map[[[Key alloc] initWithValue:7]] == nil, @"");
    check([map[[[Key alloc] initWithValue:8]] integerValue] == 8, @"");
}

void test5() {
    JKRHashMap *map = [JKRHashMap new];
    for (NSUInteger i = 1; i <= 20; i++) {
        map[[[SubKey1 alloc] initWithValue:i]] = [NSNumber numberWithInteger:i];
    }
    map[[[SubKey2 alloc] initWithValue:1]] = [NSNumber numberWithInteger:5];
    check([map[[[SubKey1 alloc] initWithValue:1]] integerValue] == 5, @"");
    check([map[[[SubKey2 alloc] initWithValue:1]] integerValue] == 5, @"");
    check(map.count == 20, @"");
}

void test1() {
    NSMutableArray *allStrings = allFileStrings();

    __block NSUInteger hashMapCount = 0;
    __block NSUInteger treeMapCount = 1;
    __block NSUInteger treeSetCount = 2;
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashMap *map = [JKRHashMap new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        hashMapCount = map.count;
        NSLog(@"JKRHashMap 计算不重复单词数量和出现次数 %zd", map.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRHashSet *set = [JKRHashSet new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        treeMapCount = set.count;
        NSLog(@"JKRHashSet 计算不重复单词数量和出现次数 %zd", set.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        NSMutableDictionary *map = [NSMutableDictionary new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        treeMapCount = map.count;
        NSLog(@"NSMutableDictionary 计算不重复单词数量和出现次数 %zd", map.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        NSMutableSet *set = [NSMutableSet new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        treeMapCount = set.count;
        NSLog(@"NSMutableSet 计算不重复单词数量和出现次数 %zd", set.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRTreeMap *map = [JKRTreeMap new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *count = map[obj];
            if (count) {
                count = [NSNumber numberWithInteger:count.integerValue+1];
            } else {
                count = [NSNumber numberWithInteger:1];
            }
            map[obj] = count;
        }];
        treeMapCount = map.count;
        NSLog(@"JKRTreeMap 计算不重复单词数量和出现次数 %zd", map.count);
    }];
    
    [JKRTimeTool teskCodeWithBlock:^{
        JKRTreeSet *set = [JKRTreeSet new];
        [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:obj];
        }];
        treeSetCount = set.count;
        NSLog(@"JKRTreeSet 计算不重复单词数量 %zd", set.count);
    }];
    
    check(hashMapCount == treeMapCount && treeMapCount == treeSetCount, @"计算不重复单词数量结果不一致！");
}

void test6() {
    JKRHashMap *map = [JKRHashMap new];
    NSMutableArray *allStrings = allFileStrings();
//    allStrings = [allStrings subarrayWithRange:NSMakeRange(0, 100)];
    [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *count = map[obj];
        if (count) {
            count = [NSNumber numberWithInteger:count.integerValue+1];
        } else {
            count = [NSNumber numberWithInteger:1];
        }
        map[obj] = count;
    }];
    NSLog(@"HashMap 计算不重复单词数量和出现次数 %zd", map.count);
    
    __block NSUInteger allCount = 0;
    [allStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        allCount += [map[obj] integerValue];
        [map removeObjectForKey:obj];
    }];
    
    NSLog(@"HashMap 累加计算所有单词数量 %zd", allCount);
    
    check(allCount == allStrings.count, @"统计所有单词出现的数量和错误！");
    check(map.count == 0, @"哈希表没有清空！");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testJKRArray();
        
        test1();
        test2();
        test3();
        test4();
        test5();
        test6();
    }
    NSLog(@"end");
    return 0;
}
