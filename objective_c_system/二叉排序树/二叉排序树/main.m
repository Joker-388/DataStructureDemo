//
//  main.m
//  二叉排序树
//
//  Created by Joker on 2019/5/9.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <search.h>

//定义一个树节点类型，节点必须按这个格式定义
typedef struct _node
{
    char *key;    //树节点的内容。
    struct _node *left;
    struct _node *right;
}node_t;

//树排序比较器函数
int bintreecompar(const char *key1, const char *key2)
{
    return strcmp(key1, key2);
}

//树遍历函数，这里进行中序遍历，按树节点升序输出。
void action(node_t *node, VISIT order, int level)
{
    if (order == postorder || order == leaf)
    {
        printf("node's key = %s\n", node->key);
    }
}

void main()
{
    node_t *root = NULL;   //定义树的根节点，最开始时根节点为空。
    
    //添加
    
    //看这里对root参数传递的规则，因为每次插入都有可能会改变根节点的值。
    node_t *p1 = tsearch("Bob", &root, bintreecompar);   //返回节点对象，我们不需要负责节点对象的销毁，而是通过调用tdelete函数来销毁。
    node_t *p2 = tsearch("Alice", &root, bintreecompar);
    node_t *p3 = tsearch("Max", &root, bintreecompar);
    node_t *p4 = tsearch("Lucy", &root, bintreecompar);
    
//    //查找
//    node_t *p = tfind("Lily", &root, bintreecompar);
////    NSAssert(p == NULL, @"oops!");
//    p =  tfind("Lucy", &root, bintreecompar);
////    NSAssert(p != NULL, @"oops!");
    
//    //删除
//    p = tdelete("Jone", &root, bintreecompar);
////    NSAssert(p == NULL, @"oops!");
//    p = tdelete("Lucy", &root, bintreecompar);
////    NSAssert(p != NULL, @"oops!");
    
    //遍历树
    twalk(root, action);
}
