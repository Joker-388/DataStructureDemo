//
//  main.m
//  HashMapSet
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "JKRHashMap.h"
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

void check(BOOL pass, NSString *errorString) {
    if (!pass) {
        NSLog(@"!!! 发现错误 !!! :%@", errorString);
    }
}

void test2() {
    JKRHashMap *map = [JKRHashMap new];
    for (NSUInteger i = 1; i <= 20; i++) {
        [map setObject:[NSNumber numberWithInteger:i] forKey:[[Key alloc] initWithValue:i]];
    }
    for (NSUInteger i = 5; i <= 7; i++) {
        [map setObject:[NSNumber numberWithInteger:i + 5]  forKey:[[Key alloc] initWithValue:i]];
    }
    
    check(map.count == 20, [NSString stringWithFormat:@"20 : %zd", map.count]);
    check([[map objectForKey:[[Key alloc] initWithValue:4]] integerValue] == 4, [NSString stringWithFormat:@"4 : %@", [map objectForKey:[[Key alloc] initWithValue:4]]]);
    check([[map objectForKey:[[Key alloc] initWithValue:5]] integerValue] == 10, [NSString stringWithFormat:@"10 : %@", [map objectForKey:[[Key alloc] initWithValue:5]]]);
    check([[map objectForKey:[[Key alloc] initWithValue:6]] integerValue] == 11, [NSString stringWithFormat:@"11 : %@", [map objectForKey:[[Key alloc] initWithValue:6]]]);
    check([[map objectForKey:[[Key alloc] initWithValue:7]] integerValue] == 12, [NSString stringWithFormat:@"12 : %@", [map objectForKey:[[Key alloc] initWithValue:7]]]);
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
    check([[map objectForKey:nil] integerValue] == 8, @"");
    check([[map objectForKey:@"jack"] integerValue] == 6, @"");
    check([map objectForKey:@10] == nil, @"");
    check([map objectForKey:[NSObject new]] == nil, @"");
    check([map containsKey:@10], @"");
    check([map containsKey:nil], @"");
    check([map containsObject:nil], @"");
    check([map containsObject:@1] == false, @"");
}

void test4() {
    JKRHashMap *map = [JKRHashMap new];
    [map setObject:@1 forKey:@"jack"];
    [map setObject:@2 forKey:@"rose"];
    [map setObject:@3 forKey:@"jim"];
    [map setObject:@4 forKey:@"jake"];
    for (NSUInteger i = 1; i <= 10; i++) {
        [map setObject:[NSNumber numberWithInteger:i] forKey:[NSString stringWithFormat:@"test%zd", i]];
        [map setObject:[NSNumber numberWithInteger:i] forKey:[[Key alloc] initWithValue:i]];
    }
    
    for (NSUInteger i = 5; i <= 7; i++) {
        Key *key = [[Key alloc] initWithValue:i];
        NSNumber *number = [map objectForKey:key];
        check(number.integerValue == i, @"");
        [map removeObjectForKey:key];
    }
 
    for (NSUInteger i = 1; i <= 3; i++) {
        [map setObject:[NSNumber numberWithInteger:i + 5] forKey:[[Key alloc] initWithValue:i]];
    }
    
    check(map.count == 21, @"");
    check([[map objectForKey:[[Key alloc] initWithValue:1]] integerValue] == 6, @"");
    check([[map objectForKey:[[Key alloc] initWithValue:2]] integerValue] == 7, @"");
    check([[map objectForKey:[[Key alloc] initWithValue:3]] integerValue] == 8, @"");
    check([[map objectForKey:[[Key alloc] initWithValue:4]] integerValue] == 4, @"");
    check([map objectForKey:[[Key alloc] initWithValue:5]] == nil, @"");
    check([map objectForKey:[[Key alloc] initWithValue:6]] == nil, @"");
    check([map objectForKey:[[Key alloc] initWithValue:7]] == nil, @"");
    check([[map objectForKey:[[Key alloc] initWithValue:8]] integerValue] == 8, @"");
}

void test5() {
    JKRHashMap *map = [JKRHashMap new];
    for (NSUInteger i = 1; i <= 20; i++) {
        [map setObject:[NSNumber numberWithInteger:i] forKey:[[SubKey1 alloc] initWithValue:i]];
    }
    [map setObject:[NSNumber numberWithInteger:5] forKey:[[SubKey2 alloc] initWithValue:1]];
    check([[map objectForKey:[[SubKey1 alloc] initWithValue:1]] integerValue] == 5, @"");
    check([[map objectForKey:[[SubKey2 alloc] initWithValue:1]] integerValue] == 5, @"");
    check(map.count == 20, @"");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        //        Person *person0 = [Person new];
        //        person0.name = @"Joker";
        //        person0.age = 14;
        //        NSLog(@"%zd", person0.hash);
        //
        //        Person *person1 = [Person new];
        //        person1.name = @"Joker";
        //        person1.age = 14;
        //        NSLog(@"%zd", person1.hash);
        
        //        int i = 31;
        //        NSLog(@"%d", i * 31);
        //        NSLog(@"%d", (i<<5) - i);
        
        //        NSString *str1 = @"123";
        //        NSLog(@"%zd",str1.hash);
        //
        //        NSString *str2 = @"123";
        //        NSLog(@"%zd",str2.hash);
        
        //        Person *person0 = [Person new];
        //        person0.name = @"Joker";
        //        person0.age = 14;
        //
        //        Person *person1 = [Person new];
        //        person1.name = @"Joker";
        //        person1.age = 14;
        //
        //        NSLog(@"%d", [person0 isEqual:person1]);
        
//        id array[10] = {};
//        {
//            Person *p = [Person new];
//            array[3] = p;
//            array[5] = p;
//            array[0] = p;
//        }
        
//        NSMutableArray *b = [NSMutableArray arrayWithLength:18];
//        b[5] = [Person new];
//        b[18] = [NSObject new];
//        NSLog(@"%d", 1<<4);
//
//        NSLog(@"end");
        
//        JKRHashMap *map = [JKRHashMap new];
//        {
//            Person *person = [Person new];
//            [map setObject:person forKey:nil];
//        }
//        NSLog(@"%zd", map.count);
        
//        NSMutableArray *mutArr = [NSMutableArray array];
//        for (int i = 0; i < 1000; i++) {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                NSMutableArray *strArr = mutArr;
//                [strArr addObject:@"i"];
//            });
//        }
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSMutableArray *strArr = mutArr;
//            for (int i = 0; i < 1000; i++) {
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    [strArr addObject:@"i"];
//                });
//            }
//            NSLog(@"%zd", mutArr.count);
//        });
//
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            for (int i = 0; i < 1000; i++) {
//                NSMutableArray *strArr = mutArr;
//                [strArr addObject:@"i"];
//            }
//        });
        
        
//        JKRHashMap *map = [JKRHashMap new];
//        for (NSUInteger i = 0; i < 30; i++) {
//            Person *p = [Person new];
//            p.age = i + 1;
//            p.name = getRandomStr();
//            [map setObject:[NSNumber numberWithInteger:i] forKey:p];
//        }
//
//        NSLog(@"111111111111");


        
//        JKRArray<Person *> *array = [[JKRArray alloc] initWithLength:4];
//        for (NSUInteger i = 0; i < 4; i++) {
//            Person *p = [Person new];
//            p.name = getRandomStr();
//            p.age = i;
//            array[i] = p;
//            NSLog(@"%zd", p.jkr_addressIdentity);
//        }
//        array[3] = nil;
//        NSLog(@"打印 %@", array);
//        NSLog(@"%zd", [array indexOfObject:nil]);

//        for (Person *person in array) {
//            NSLog(@"for 遍历: %@",  person);
//        }
//
//        for (NSUInteger i = 0; i < 4; i++) {
//            NSLog(@"取值 array[%zd]: %@", i, array[i]);
//        }
//        NSLog(@"打印 %@", array);

//        for (NSUInteger i = 0; i < 4; i++) {
//            NSLog(@"置空 array[%zd]: nil", i, nil);
//            array[i] = nil;
//        }
//        NSLog(@"打印 %@", array);
        
//        JKRHashMap *map = [JKRHashMap new];
//        for (NSInteger i = 0; i < 100; i++) {
//            [map setObject:[NSString stringWithFormat:@"%zd", i] forKey:[NSNumber numberWithInteger:i / 10]];
////            [map setObject:[NSNumber numberWithInteger:i] forKey:getRandomStr()];
//        }
//
//        NSLog(@"%@", map);
//
//        for (NSInteger i = 0; i < 100; i++) {
//            NSLog(@"%@", [map objectForKey:[NSNumber numberWithInteger:i]]);
//        }
        
        test2();
        test3();
        test4();
        test5();
    }
    return 0;
}
