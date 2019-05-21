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
//
//            array[5] = p;
//        }
//
//        NSLog(@"%@", array[5]);
//
//        NSLog(@"end");
        
        JKRHashMap *map = [JKRHashMap new];
        {
            Person *person = [Person new];
            [map setObject:person forKey:nil];
        }
        NSLog(@"%zd", map.count);
        
        
    }
    return 0;
}
