//
//  JKRHashMap.m
//  HashMapSet
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRHashMap.h"
#import "Person.h"
#import "JKRArray.h"

@interface JKRHasMapNode : NSObject

@property (nonatomic, assign) NSUInteger keyHashCode;
@property (nonatomic, assign) BOOL color;
@property (nonatomic, strong, nonnull) id key;
@property (nonatomic, strong, nonnull) id value;
@property (nonatomic, strong, nullable) JKRHasMapNode *left;
@property (nonatomic, strong, nullable) JKRHasMapNode *right;
@property (nonatomic, weak, nullable) JKRHasMapNode *parent;

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRHasMapNode *)parent;
/// 是否是叶子节点
- (BOOL)isLeaf;
/// 是否有度为2
- (BOOL)hasTwoChildren;
/// 是否是父节点的左子树
- (BOOL)isLeftChild;
/// 是否是父节点的右子树
- (BOOL)isRightChild;
/// 返回兄弟节点
- (JKRHasMapNode *)sibling;

@end

@interface JKRHashMap ()

@property (nonatomic, strong) JKRArray *array;

@end

@implementation JKRHashMap

static BOOL const HASH_MAP_COLOR_RED = false;
static BOOL const HASH_MAP_COLOR_BLACK = true;
static int const HASH_MAP_DEAFULT_CAPACITY = 1>>4;

- (instancetype)init {
    self = [super init];
    self.array = [JKRArray arrayWithLength:HASH_MAP_DEAFULT_CAPACITY];
    return self;
}

- (void)removeAllObjects {
    _size = 0;
    self.array = [JKRArray arrayWithLength:HASH_MAP_DEAFULT_CAPACITY];
}

- (void)setObject:(id)object forKey:(id)key {
    NSUInteger index = [self indexWithKey:key];
    JKRHasMapNode *root = [self.array objectAtIndex:index];
    if ([root isEqual:[NSNull new]]) {
        root = [[JKRHasMapNode alloc] initWithKey:key value:object parent:nil];
        [self.array setObject:root AtIndex:index];
        [self afterAddWithNewNode:root];
        _size++;
    } else {
        if (!root) {
            JKRHasMapNode *newNode = [[JKRHasMapNode alloc] initWithKey:key value:object parent:nil];
            root = newNode;
            _size++;
            [self afterAddWithNewNode:newNode];
            return;
        }
        
        JKRHasMapNode *parent = root;
        JKRHasMapNode *node = root;
        int cmp = 0;
        do {
            cmp = 1;
            parent = node;
            if (cmp < 0) {
                node = node.left;
            } else if (cmp > 0) {
                node = node.right;
            } else {
                node.value = object;
                return;
            }
        } while (root);
        
        JKRHasMapNode *newNode = [[JKRHasMapNode alloc] initWithKey:key value:object parent:parent];
        if (cmp < 0) {
            parent.left = newNode;
        } else {
            parent.right = newNode;
        }
        
        [self afterAddWithNewNode:newNode];
    }
}

- (id)objectForKey:(id)key {
    JKRHasMapNode *node = [self nodeWithKey:key];
    return node ? node.value : nil;
}

- (BOOL)containsKey:(id)key {
    return [self nodeWithKey:key] != nil;
}

- (BOOL)containsObject:(id)object {
    return NO;
}

- (void)removeObjectForKey:(id)key {
    [self removeWithNode:[self nodeWithKey:key]];
}

- (NSUInteger)count {
    return _size;
}

- (void)removeWithNode:(JKRHasMapNode *)node {
    if (!node) {
        return;
    }
    _size--;
    
    if (node.hasTwoChildren) {
        JKRHasMapNode *s = [self successorWithNode:node];
        node.key = s.key;
        node.value = s.value;
        node = s;
    }
    
    // 实际被删除节点的子节点
    JKRHasMapNode *replacement = node.left ? node.left : node.right;
    NSUInteger index = [self indexWithNode:replacement];
    if (replacement) { // 被删除的节点度为1
        replacement.parent = node.parent;
        if (!node.parent) {
            [self.array setObject:replacement AtIndex:index];
        } else if (node == node.parent.left) {
            node.parent.left = replacement;
        } else {
            node.parent.right = replacement;
        }
        [self afterRemoveWithNode:replacement];
    } else if(!node.parent) { // 被删除的节点度为0且没有父节点，被删除的节点是根节点且二叉树只有一个节点
        [self.array setObject:nil AtIndex:0];
        [self afterRemoveWithNode:node];
    } else { // 被删除的节点是叶子节点且不是根节点
        if (node == node.parent.left) {
            node.parent.left = nil;
        } else {
            node.parent.right = nil;
        }
        [self afterRemoveWithNode:node];
    }
}

- (void)afterRemoveWithNode:(JKRHasMapNode *)node {
    // 如果删除的节点是红色，或者用以取代删除节点的子节点是红色
    if ([self isRed:node]) {
        [self black:node];
        return;
    }
    
    JKRHasMapNode *parent = node.parent;
    // 删除的是根节点
    if (!parent) {
        return;
    }
    
    // 删除的是黑色叶子节点，下溢，判定被删除的节点是左还是右
    BOOL left = !parent.left || node.isLeftChild;
    JKRHasMapNode *sibling = left ? parent.right : parent.left;
    if (left) { // 被删除的节点在左边，兄弟节点在右边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateLeft:parent];
            // 更换兄弟
            sibling = parent.right;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling.right]) {
                [self rotateRight:sibling];
                sibling = parent.right;
            }
            [self dyeNode:sibling color:[self colorOf:parent]];
            [self black:sibling.right];
            [self black:parent];
            [self rotateLeft:parent];
        }
    } else { // 被删除的节点在右边，兄弟节点在左边
        if ([self isRed:sibling]) { // 兄弟节点是红色
            [self black:sibling];
            [self red:parent];
            [self rotateRight:parent];
            // 更换兄弟
            sibling = parent.left;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlack:sibling.left] && [self isBlack:sibling.right]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlack:parent];
            [self black:parent];
            [self red:sibling];
            if (parentBlack) {
                [self afterRemoveWithNode:parent];
            }
        } else { // 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlack:sibling.left]) {
                [self rotateLeft:sibling];
                sibling = parent.left;
            }
            
            [self dyeNode:sibling color:[self colorOf:parent]];
            [self black:sibling.left];
            [self black:parent];
            [self rotateRight:parent];
        }
    }
}

#pragma mark - 节点的后继节点
- (JKRHasMapNode *)successorWithNode:(JKRHasMapNode *)node {
    if (!node) {
        return nil;
    }
    
    if (node.right) {
        JKRHasMapNode *p = node.right;
        while (p.left) {
            p = p.left;
        }
        return p;
    }
    
    while (node.parent && node == node.parent.right) {
        node = node.parent;
    }
    
    return node.parent;
}

- (void)afterAddWithNewNode:(JKRHasMapNode *)node {
    JKRHasMapNode *parent = node.parent;
    
    // 添加的节点是根节点 或者 上溢出到达根节点
    if (!parent) {
        [self black:node];
        return;
    }
    
    if ([self isBlack:parent]) {
        return;
    }
    
    // 叔父节点
    JKRHasMapNode *uncle = parent.sibling;
    // 祖父节点
    JKRHasMapNode *grand = [self red:parent.parent];
    
    
    // 叔父节点是红色的情况，B树节点上溢
    if ([self isRed:uncle]) {
        [self black:parent];
        [self black:uncle];
        // 把祖父节点当作是新添加的节点
        [self afterAddWithNewNode:grand];
        return;
    }
    
    // 叔父节点不是红色
    if (parent.isLeftChild) { // L
        if (node.isLeftChild) { // LL
            [self black:parent];
        } else { // LR
            [self black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { // R
        if (node.isLeftChild) { // RL
            [self black:node];
            [self rotateRight:parent];
        } else { // RR
            [self black:parent];
        }
        [self rotateLeft:grand];
    }
}

#pragma mark - 左旋转一个节点
- (void)rotateLeft:(JKRHasMapNode *)grand {
    JKRHasMapNode *parent = grand.right;
    JKRHasMapNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 右旋转一个节点
- (void)rotateRight:(JKRHasMapNode *)grand {
    JKRHasMapNode *parent = grand.left;
    JKRHasMapNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 旋转后处理
- (void)afterRotateWithGrand:(JKRHasMapNode *)grand parent:(JKRHasMapNode *)parent child:(JKRHasMapNode *)child {
    if (grand.isLeftChild) {
        grand.parent.left = parent;
    } else if (grand.isRightChild) {
        grand.parent.right = parent;
    } else {
        [self.array setObject:parent AtIndex:[self indexWithNode:grand]];
    }
    
    if (child) {
        child.parent = grand;
    }
    
    parent.parent = grand.parent;
    grand.parent = parent;
}

#pragma mark - 为一个节点染色
- (JKRHasMapNode *)dyeNode:(JKRHasMapNode *)node color:(BOOL)color {
    if (!node) {
        return node;
    }
    node.color = color;
    return node;
}

#pragma mark - 将一个节点染成红色
- (JKRHasMapNode *)red:(JKRHasMapNode *)node {
    return [self dyeNode:node color:HASH_MAP_COLOR_RED];
}

#pragma mark - 将一个节点染成黑色
- (JKRHasMapNode *)black:(JKRHasMapNode *)node {
    return [self dyeNode:node color:HASH_MAP_COLOR_BLACK];
}

#pragma mark - 返回节点颜色
- (BOOL)colorOf:(JKRHasMapNode *)node {
    return !node ? HASH_MAP_COLOR_BLACK : node.color;
}

#pragma mark - 节点是否为黑色
- (BOOL)isBlack:(JKRHasMapNode *)node {
    return [self colorOf:node] == HASH_MAP_COLOR_BLACK;
}

#pragma mark - 节点是否为红色
- (BOOL)isRed:(JKRHasMapNode *)node {
    return [self colorOf:node] == HASH_MAP_COLOR_RED;
}

- (NSUInteger)indexWithKey:(id)key {
    if (!key) {
        return 0;
    }
    NSUInteger hash = [key hash];
    return (hash ^ (hash >> 16)) & (self.array.length - 1);
}

- (NSUInteger)indexWithNode:(JKRHasMapNode *)node {
    NSUInteger hash = node.hash;
    return (hash ^ (hash >> 16)) & (self.array.length - 1);
}

- (JKRHasMapNode *)nodeWithKey:(id)key {
    NSUInteger index = [self indexWithKey:key];
    JKRHasMapNode *root = [self.array objectAtIndex:index];
    return root;
}

@end

@implementation JKRHasMapNode

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRHasMapNode *)parent {
    self = [super init];
    self.key = key;
    self.value = value;
    self.parent = parent;
    self.keyHashCode = key ? [key hash] : 0;
    return self;
}

- (BOOL)isLeaf {
    return !self.left && !self.right;
}

- (BOOL)hasTwoChildren {
    return self.left && self.right;
}

- (BOOL)isLeftChild {
    return self.parent && self.parent.left == self;
}

- (BOOL)isRightChild {
    return self.parent && self.parent.right == self;
}

- (JKRHasMapNode *)sibling {
    if ([self isLeftChild]) {
        return self.parent.right;
    }
    if ([self isRightChild]) {
        return self.parent.left;
    }
    return nil;
}

- (void)dealloc {
    //    NSLog(@"<%@: %p> dealloc", self.className, self);
}

@end