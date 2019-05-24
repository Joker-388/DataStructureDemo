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
#import "NSObject+JKRDataStructure.h"
#import "LevelOrderPrinter.h"

@interface JKRHashMapNode : NSObject

@property (nonatomic, assign) NSUInteger keyHashCode;
@property (nonatomic, assign) BOOL color;
@property (nonatomic, strong, nonnull) id key;
@property (nonatomic, strong, nonnull) id value;
@property (nonatomic, strong, nullable) JKRHashMapNode *left;
@property (nonatomic, strong, nullable) JKRHashMapNode *right;
@property (nonatomic, weak, nullable) JKRHashMapNode *parent;

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRHashMapNode *)parent;
/// 是否是叶子节点
- (BOOL)isLeaf;
/// 是否有度为2
- (BOOL)hasTwoChildren;
/// 是否是父节点的左子树
- (BOOL)isLeftChild;
/// 是否是父节点的右子树
- (BOOL)isRightChild;
/// 返回兄弟节点
- (JKRHashMapNode *)sibling;

@end

@interface JKRHashTempTree : NSObject<LevelOrderPrinterDelegate>

@property (nonatomic, strong) JKRHashMapNode *root;
- (instancetype)initWithRoot:(JKRHashMapNode *)root;

@end

@interface JKRHashMap ()

@property (nonatomic, strong) JKRArray *array;

@end

@implementation JKRHashMap

static BOOL const HASH_MAP_COLOR_RED = false;
static BOOL const HASH_MAP_COLOR_BLACK = true;
static NSUInteger const HASH_MAP_DEAFULT_CAPACITY = 1<<4;

- (instancetype)init {
    self = [super init];
    self.array = [[JKRArray alloc] initWithLength:HASH_MAP_DEAFULT_CAPACITY];
    return self;
}

- (void)removeAllObjects {
    if (_size == 0) return;
    _size = 0;
    self.array = [[JKRArray alloc] initWithLength:HASH_MAP_DEAFULT_CAPACITY];
}

- (void)setObject:(id)object forKey:(id)key {
    NSUInteger index = [self indexWithKey:key];
    JKRHashMapNode *root = self.array[index];
    if (!root) {
        root = [[JKRHashMapNode alloc] initWithKey:key value:object parent:nil];
        self.array[index] = root;
        _size++;
        [self afterAddWithNewNode:root];
        return;
    }
    
    JKRHashMapNode *parent = root;
    JKRHashMapNode *node = root;
    NSInteger cmp = 0;
    id k1 = key;
    NSUInteger h1 = k1 ? [k1 hash] : 0;
    JKRHashMapNode *result = nil;
    BOOL searched = false;
    
    do {
        parent = node;
        id k2 = node.key;
        NSUInteger h2 = node.keyHashCode;
        if (h1 > h2) {
            cmp = 1;
        } else if (h1 < h2) {
            cmp = -1;
        } else if (k1 == k2 || [k1 isEqual:k2]) {
            cmp = 0;
        } else if (k1 && k2 && [k1 class] == [k2 class] && [k1 respondsToSelector:@selector(compare:)] && (cmp = [k1 compare:k2])) {
            
        } else if (searched) {
            cmp = [k1 jkr_addressIdentity] - [k2 jkr_addressIdentity];
        } else {
            if ((node.left && (result = [self nodeWithNode:node.left key:k1])) || (node.right && (result = [self nodeWithNode:node.right key:k1]))) {
                node = result;
                cmp = 0;
            } else {
                searched = true;
                cmp = [k1 jkr_addressIdentity] - [k2 jkr_addressIdentity];
            }
        }
        
        if (cmp < 0) {
            node = node.left;
        } else if (cmp > 0) {
            node = node.right;
        } else {
            node.key = key;
            node.value = object;
            return;
        }
    } while (node);
    
    JKRHashMapNode *newNode = [[JKRHashMapNode alloc] initWithKey:key value:object parent:parent];
    if (cmp < 0) {
        parent.left = newNode;
    } else {
        parent.right = newNode;
    }
    _size++;
    [self afterAddWithNewNode:newNode];
}

- (id)objectForKey:(id)key {
    JKRHashMapNode *node = [self nodeWithKey:key];
    return node ? node.value : nil;
}

- (BOOL)containsKey:(id)key {
    return [self nodeWithKey:key] != nil;
}

- (BOOL)containsObject:(id)object {
    if (_size == 0) return NO;
    NSMutableArray *queue = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.array.length; i++) {
        if (self.array[i] == nil) continue;
        [queue addObject:self.array[i]];
        while (queue.count) {
            JKRHashMapNode *node = queue.firstObject;
            if (object == node.value || [object isEqual:node.value]) return YES;
            [queue removeObjectAtIndex:0];
            if (node.left) [queue addObject:node.left];
            if (node.right) [queue addObject:node.right];
        }
    }
    
    return NO;
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block {
    if (_size == 0) return;
    BOOL stop = NO;
    NSMutableArray *queue = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.array.length && !stop; i++) {
        if (self.array[i] == nil) continue;
        [queue addObject:self.array[i]];
        while (queue.count && !stop) {
            JKRHashMapNode *node = queue.firstObject;
            block(node.key, node.value, &stop);
            [queue removeObjectAtIndex:0];
            if (node.left) {
                [queue addObject:node.left];
            }
            if (node.right) {
                [queue addObject:node.right];
            }
        }
    }
    
//    NSMutableArray *stack = [NSMutableArray array];
//    for (NSUInteger i = 0; i < self.array.length && !stop; i++) {
//        JKRHashMapNode *node = self.array[i];
//        if (!node) continue;
//        do {
//            while (node) {
//                [stack addObject:node];
//                node = node.left;
//            }
//            if (stack.count) {
//                JKRHashMapNode *n = [stack lastObject];
//                block(n.key, n.value, &stop);
//                [stack removeLastObject];
//                node = n.right;
//            }
//        } while (stack.count || node);
//    }
}

- (void)removeObjectForKey:(id)key {
    JKRHashMapNode *node = [self nodeWithKey:key];
    if (!node) {
        NSLog(@"未找到节点");
    }
    [self removeWithNode:node];
}

- (NSUInteger)count {
    return _size;
}

- (void)removeWithNode:(JKRHashMapNode *)node {
    if (!node) {
        return;
    }
    _size--;
    
    if (node.hasTwoChildren) {
        JKRHashMapNode *s = [self successorWithNode:node];
        node.key = s.key;
        node.value = s.value;
        node = s;
    }
    
    // 实际被删除节点的子节点
    JKRHashMapNode *replacement = node.left ? node.left : node.right;
    NSUInteger index = [self indexWithNode:node];
    if (replacement) { // 被删除的节点度为1
        replacement.parent = node.parent;
        if (!node.parent) {
            self.array[index] = replacement;
        } else if (node == node.parent.left) {
            node.parent.left = replacement;
        } else {
            node.parent.right = replacement;
        }
        [self afterRemoveWithNode:replacement];
    } else if(!node.parent) { // 被删除的节点度为0且没有父节点，被删除的节点是根节点且二叉树只有一个节点
        self.array[index] = nil;
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

- (void)afterRemoveWithNode:(JKRHashMapNode *)node {
    // 如果删除的节点是红色，或者用以取代删除节点的子节点是红色
    if ([self isRed:node]) {
        [self black:node];
        return;
    }
    
    JKRHashMapNode *parent = node.parent;
    // 删除的是根节点
    if (!parent) {
        NSUInteger index = [self indexWithNode:node];
        [self.array removeObjectAtIndex:index];
        return;
    }
    
    // 删除的是黑色叶子节点，下溢，判定被删除的节点是左还是右
    BOOL left = !parent.left || node.isLeftChild;
    JKRHashMapNode *sibling = left ? parent.right : parent.left;
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
- (JKRHashMapNode *)successorWithNode:(JKRHashMapNode *)node {
    if (!node) {
        return nil;
    }
    
    if (node.right) {
        JKRHashMapNode *p = node.right;
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

#pragma mark - 添加后平衡
- (void)afterAddWithNewNode:(JKRHashMapNode *)node {
    JKRHashMapNode *parent = node.parent;
    
    // 添加的节点是根节点 或者 上溢出到达根节点
    if (!parent) {
        [self black:node];
        return;
    }
    
    if ([self isBlack:parent]) return;
    
    // 叔父节点
    JKRHashMapNode *uncle = parent.sibling;
    // 祖父节点
    JKRHashMapNode *grand = [self red:parent.parent];
    
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
- (void)rotateLeft:(JKRHashMapNode *)grand {
    JKRHashMapNode *parent = grand.right;
    JKRHashMapNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 右旋转一个节点
- (void)rotateRight:(JKRHashMapNode *)grand {
    JKRHashMapNode *parent = grand.left;
    JKRHashMapNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    [self afterRotateWithGrand:grand parent:parent child:child];
}

#pragma mark - 旋转后处理
- (void)afterRotateWithGrand:(JKRHashMapNode *)grand parent:(JKRHashMapNode *)parent child:(JKRHashMapNode *)child {
    if (grand.isLeftChild) {
        grand.parent.left = parent;
    } else if (grand.isRightChild) {
        grand.parent.right = parent;
    } else {
        self.array[[self indexWithNode:grand]] = parent;
    }
    
    if (child) {
        child.parent = grand;
    }
    
    parent.parent = grand.parent;
    grand.parent = parent;
}

#pragma mark - 为一个节点染色
- (JKRHashMapNode *)dyeNode:(JKRHashMapNode *)node color:(BOOL)color {
    if (!node) {
        return node;
    }
    node.color = color;
    return node;
}

#pragma mark - 将一个节点染成红色
- (JKRHashMapNode *)red:(JKRHashMapNode *)node {
    return [self dyeNode:node color:HASH_MAP_COLOR_RED];
}

#pragma mark - 将一个节点染成黑色
- (JKRHashMapNode *)black:(JKRHashMapNode *)node {
    return [self dyeNode:node color:HASH_MAP_COLOR_BLACK];
}

#pragma mark - 返回节点颜色
- (BOOL)colorOf:(JKRHashMapNode *)node {
    return !node ? HASH_MAP_COLOR_BLACK : node.color;
}

#pragma mark - 节点是否为黑色
- (BOOL)isBlack:(JKRHashMapNode *)node {
    return [self colorOf:node] == HASH_MAP_COLOR_BLACK;
}

#pragma mark - 节点是否为红色
- (BOOL)isRed:(JKRHashMapNode *)node {
    return [self colorOf:node] == HASH_MAP_COLOR_RED;
}

- (NSUInteger)indexWithKey:(id)key {
    if (!key) {
        return 0;
    }
    NSUInteger hash = [key hash];
    return (hash ^ (hash >> 16)) & (self.array.length - 1);
}

- (NSUInteger)indexWithNode:(JKRHashMapNode *)node {
    NSUInteger hash = node.keyHashCode;
    return (hash ^ (hash >> 16)) & (self.array.length - 1);
}

#pragma mark - 通过key获取节点
- (JKRHashMapNode *)nodeWithKey:(id)key {
    NSUInteger index = [self indexWithKey:key];
    JKRHashMapNode *root = self.array[index];
    return root ? [self nodeWithNode:root key:key] : nil;
}

- (JKRHashMapNode *)nodeWithNode:(JKRHashMapNode *)node key:(id)key {
    NSUInteger hash1 = key ? [key hash] : 0;
    JKRHashMapNode *result = nil;
    NSInteger cmp = 0;
    while (node) {
        id key2 = node.key;
        NSUInteger hash2 = node.keyHashCode;
        if (hash1 > hash2) {
            node = node.right;
        } else if (hash1 < hash2) {
            node = node.left;
        } else if (key == key2 || [key isEqual:key2]) {
            return node;
        } else if (key && key2 && [key class] == [key2 class] && [key respondsToSelector:@selector(compare:)] && (cmp = [key compare:key2])) {
            node = cmp > 0 ? node.right : node.left;
        } else if (node.right && (result = [self nodeWithNode:node.right key:key])) {
            return result;
        } else {
            node = node.left;
        }
    }
    return nil;
}

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self setObject:obj forKey:key];
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"<%@, %p>: \ncount:%zd\n{\n", self.className, self, _size]];
    [self.array enumerateObjectsUsingBlock:^(JKRHashMapNode*  _Nullable node, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx) {
            [string appendString:@"\n----------------------------------------------\n"];
        }
        if (node) {
            JKRHashTempTree *tree = [[JKRHashTempTree alloc] initWithRoot:node];
            [string appendString:[LevelOrderPrinter printStringWithTree:tree]];
        } else {
            [string appendString:@"   "];
            [string appendString:@"Null"];
        }
    }];
    return string;
}

- (void)dealloc {
//    NSLog(@"<%@, %p>: dealloc", self.className, self);
}

@end

@implementation JKRHashMapNode

- (instancetype)initWithKey:(id)key value:(id)value parent:(JKRHashMapNode *)parent {
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

- (JKRHashMapNode *)sibling {
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

- (NSString *)description {
    return [NSString stringWithFormat:@"%@: %@", self.key, self.value];
}

@end

@implementation JKRHashTempTree

- (instancetype)initWithRoot:(JKRHashMapNode *)root {
    self = [super init];
    self.root = root;
    return self;
}

- (id)print_root {
    return self.root;
}

- (id)print_left:(id)node {
    JKRHashMapNode *n = (JKRHashMapNode *)node;
    return n.left;
}

- (id)print_right:(id)node {
    JKRHashMapNode *n = (JKRHashMapNode *)node;
    return n.right;
}

- (id)print_string:(id)node {
    return [NSString stringWithFormat:@"%@", node];
}

@end

