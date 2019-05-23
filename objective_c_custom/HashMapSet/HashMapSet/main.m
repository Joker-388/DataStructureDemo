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

#import "JKRArray.h"

NSString * getRandomStr() {
    char data[6];
    for (int i = 0; i < 6; i++) data[i] = (char)((i ? 'a' : 'A') + (arc4random_uniform(26)));
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    return string;
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
    }
    return 0;
}
