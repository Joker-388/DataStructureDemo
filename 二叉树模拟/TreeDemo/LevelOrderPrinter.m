//
//  LevelOrderPrinter.m
//  TreeDemo
//
//  Created by Lucky on 2019/5/1.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "LevelOrderPrinter.h"

#define TOP_LINE_SPACE 1
#define MIN_SPACE 1

@implementation PrintNode

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    [self _initWithString:string];
    return self;
}

- (instancetype)initWithBtNode:(id)btNode tree:(id<LevelOrderPrinterDelegate>)tree {
    self = [super init];
    [self _initWithString:[[tree print_string:btNode] description]];
    self.btNode = btNode;
    return self;
}

- (void)_initWithString:(NSString *)string {
    string = string ?  string : @"null";
    string = string.length == 0 ? @" " : string;
    self.width = (int)string.length;
    self.string = string;
}

- (void)balanceWithLeft:(PrintNode *)left right:(PrintNode *)right {
    if (!left || !right) return;
    
    int deltaLeft = self.x - [self.left rightX];
    int deltaRight = self.right.x - [self rightX];
    
    int delta= MAX(deltaLeft, deltaRight);
    int newRightX = [self rightX] + delta;
    [right translateX:(newRightX - right.x)];
    
    int newLeftX = self.x - delta - left.width;
    [left translateX:(newLeftX - left.x)];
}

- (int)rightX {
    return self.x + self.width;
}

- (void)translateX:(int)deltaX {
    if (deltaX == 0) return;
    
    self.x += deltaX;
    if (!self.btNode) return;
    
    if (self.left) [self.left translateX:deltaX];
    if (self.right) [self.right translateX:deltaX];
}

- (int)topLineX {
    int delta = self.width;
    if (delta % 2 == 0) delta--;
    delta >>= 1;
    
    if (self.parent && self.parent.left == self) return [self rightX] - 1 - delta;
    else return self.x + delta;
}

- (int)rightBound {
    if (!self.right) return [self rightX];
    return [self.right topLineX] + 1;
}

- (int)leftBound {
    if (!self.left) return self.x;
    return [self.left topLineX];
}

- (int)leftBoundLength {
    return self.x - [self leftBound];
}

- (int)rightBoundLength {
    return [self rightBound] - [self rightX];
}

- (int)leftBoundEmptyLength {
    return [self leftBoundLength] - 1 - TOP_LINE_SPACE;
}

- (int)rightBoundEmptyLength {
    return [self rightBoundLength] - 1 - TOP_LINE_SPACE;
}

- (int)treeHeigh:(PrintNode *)node {
    if (!node) return 0;
    if (node.treeHeight != 0) return node.treeHeight;
    
    node.treeHeight = 1 + MAX([self treeHeigh:node.left], [self treeHeigh:node.right]);
    return node.treeHeight;
}

- (int)minLevelSpaceToRight:(PrintNode *)right {
    int thisHeight = [self treeHeigh:self];
    int rightHeight = [self treeHeigh:right];
    int minSpace = INT_MAX;
    for (int i = 0; i < thisHeight && i < rightHeight; i++) {
        int space = [right levelInfo:i].leftX - [self levelInfo:i].rightX;
        minSpace = MIN(minSpace, space);
    }
    return minSpace;;
}

- (LevelInfo *)levelInfo:(int)level {
    if (level < 0) return nil;
    int levelY = self.y + level;
    if (level >= [self treeHeigh:self]) return nil;
    
    NSMutableArray<PrintNode *> *list = [NSMutableArray array];
    NSMutableArray<PrintNode *> *queue = [NSMutableArray array];
    [queue addObject:self];
    while (queue.count) {
        PrintNode *node = [queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        if (levelY == node.y) [list addObject:node];
        else if (node.y > levelY) break;
        
        if (node.left) [queue addObject:node.left];
        if (node.right) [queue addObject:node.right];
    }
    
    PrintNode *left = list[0];
    PrintNode *right = list.lastObject;
    return [[LevelInfo alloc] initWithLeft:left right:right];
}

@end


@implementation LevelInfo

- (instancetype)initWithLeft:(PrintNode *)left right:(PrintNode *)right {
    self = [super init];
    self.leftX = [left leftBound];
    self.rightX = [right rightBound];
    return self;
}

@end

@interface LevelOrderPrinter ()

@property (nonatomic, strong) PrintNode *root;
@property (nonatomic, assign) int minX;
@property (nonatomic, assign) int maxWidth;

@end

@implementation LevelOrderPrinter

+ (void)printTree:(id<LevelOrderPrinterDelegate>)tree {
    LevelOrderPrinter *printer = [[LevelOrderPrinter alloc] initWithTree:tree];
    [printer print];
}

+ (NSString *)printStringWithTree:(id<LevelOrderPrinterDelegate>)tree {
    LevelOrderPrinter *printer = [[LevelOrderPrinter alloc] initWithTree:tree];
    return [printer printString];
}

- (instancetype)initWithTree:(id<LevelOrderPrinterDelegate>)tree {
    self = [super init];
    self.tree = tree;
    self.root = [[PrintNode alloc] initWithBtNode:tree.print_root tree:tree];
    self.maxWidth = self.root.width;
    return self;
}

- (NSString *)printString {
    NSMutableArray <NSMutableArray<PrintNode *> *> *nodes = [NSMutableArray array];
    [self fillNodes:nodes];
    [self cleanNodes:nodes];
    [self compressNodes:nodes];
    [self addLineNodes:nodes];
    
    int rowCont = (int)nodes.count;
    NSMutableString *mutableString = [NSMutableString string];
    [mutableString appendString:@"\n"];
    for (int i = 0; i < rowCont; i++) {
        if (i != 0) [mutableString appendString:@"\n"];
        
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        NSMutableString *rowMutableSting = [NSMutableString string];
        for (PrintNode *node in rowNodes) {
            int leftSpace = (int)(node.x - rowMutableSting.length - self.minX);
            for (int i = 0; i < leftSpace; i++) [rowMutableSting appendString:@" "];
            [rowMutableSting appendString:node.string];
        }
        
        [mutableString appendString:rowMutableSting];
    }
    
    return mutableString;
}

- (PrintNode *)addNodeWithNodes:(NSMutableArray<PrintNode *> *)nodes btNode:(id)btNode {
    if (btNode) {
        PrintNode *node = [[PrintNode alloc] initWithBtNode:btNode tree:self.tree];
        self.maxWidth = MAX(self.maxWidth, node.width);
        [nodes addObject:node];
        return node;
    } else {
        NSNull *null = [NSNull new];
        [nodes addObject:(PrintNode *)null];
        return (PrintNode *)null;
    }
}

- (void)fillNodes:(NSMutableArray <NSMutableArray<PrintNode *> *> *)nodes  {
    if (!nodes) return;
    NSMutableArray<PrintNode *> *firstRowNodes = [NSMutableArray array];
    [firstRowNodes addObject:self.root];
    [nodes addObject:firstRowNodes];
    
    while (true) {
        NSMutableArray<PrintNode *> *preRowNodes = [nodes objectAtIndex:nodes.count - 1];
        NSMutableArray<PrintNode *> *rowNodes = [NSMutableArray array];
        BOOL notNull = false;
        for (PrintNode *node in preRowNodes) {
            if ([node isKindOfClass:[NSNull class]]) {
                [rowNodes addObject:(PrintNode *)[NSNull new]];
                [rowNodes addObject:(PrintNode *)[NSNull new]];
            } else {
                PrintNode *left = [self addNodeWithNodes:rowNodes btNode:[self.tree print_left:node.btNode]];
                if (![left isKindOfClass:[NSNull class]]) {
                    node.left = left;
                    left.parent = node;
                    notNull = true;
                }
                PrintNode *right = [self addNodeWithNodes:rowNodes btNode:[self.tree print_right:node.btNode]];
                if (![right isKindOfClass:[NSNull class]]) {
                    node.right = right;
                    right.parent = node;
                    notNull = true;
                }
            }
        }
        if (!notNull) break;
        
        [nodes addObject:rowNodes];
    }
}

- (void)cleanNodes:(NSMutableArray <NSMutableArray<PrintNode *> *> *)nodes {
    if (!nodes) return;
    
    int rowCount = (int)nodes.count;
    if (rowCount < 2) return;
    
    int lastRowNodeCount = (int)nodes[rowCount - 1].count;
    int nodeSpace = self.maxWidth + 2;
    
    int lastRowLength = lastRowNodeCount * self.maxWidth + nodeSpace * (lastRowNodeCount - 1);
    for (int i = 0; i < rowCount; i++) {
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        
        int rowNodeCount = (int)rowNodes.count;
        int allSpace = lastRowLength - (rowNodeCount - 1) * nodeSpace;
        int cornerSpace = allSpace / rowNodeCount - self.maxWidth;
        cornerSpace = cornerSpace >> 1;
        
        int rowLength = 0;
        for (int j = 0; j < rowNodeCount; j++) {
            if (j != 0) rowLength += nodeSpace;
            
            rowLength += cornerSpace;
            PrintNode *node = rowNodes[j];
            if (![node isKindOfClass:[NSNull class]]) {
                int deltaX = (self.maxWidth - node.width) >> 1;
                node.x = rowLength + deltaX;
                node.y = i;
            }
            rowLength += self.maxWidth;
            rowLength += cornerSpace;
        }
        
        NSMutableArray *removeRows = [NSMutableArray array];
        for (int m = 0; m < rowNodes.count; m++) {
            if ([rowNodes[m] isKindOfClass:[NSNull class]]) [removeRows addObject:rowNodes[m]];
        }
        
        [rowNodes removeObjectsInArray:removeRows];
    }
}

- (void)compressNodes:(NSMutableArray <NSMutableArray<PrintNode *> *> *)nodes {
    if (!nodes) return;
    int rowCount = (int)nodes.count;
    if (rowCount < 2) return;
    
    for (int i = rowCount - 2; i >= 0; i--) {
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        for (PrintNode *node in rowNodes) {
            PrintNode *left = node.left;
            PrintNode *right = node.right;
            if (!left && !right) continue;
            
            if (left && right) {
                [node balanceWithLeft:left right:right];
                
                int leftEmpty = [node leftBoundEmptyLength];
                int rightEmpty = [node rightBoundEmptyLength];
                int empty = MIN(leftEmpty, rightEmpty);
                empty = MIN(empty, (right.x - [left rightX])>> 1);
                
                int space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                space = MIN(space >> 1, empty);
                
                if (space > 0) {
                    [left translateX:space];
                    [right translateX:-space];
                }
                space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                if (space < 1) continue;
                
                leftEmpty = [node leftBoundEmptyLength];
                rightEmpty = [node rightBoundEmptyLength];
                if (leftEmpty < 1 && rightEmpty < 1) continue;
                
                if (leftEmpty > rightEmpty) [left translateX:MIN(leftEmpty, space)];
                else [right translateX:(-MIN(rightEmpty, space))];
            } else if (left) {
                [left translateX:[node leftBoundEmptyLength]];
            } else {
                [right translateX:(-[node rightBoundEmptyLength])];
            }
        }
    }
}

- (void)addXLineNode:(NSMutableArray<PrintNode *> *)curRow parent:(PrintNode *)parent x:(int)x {
    PrintNode *line = [[PrintNode alloc] initWithString:@"-"];
    line.x = x;
    line.y = parent.y;
    [curRow addObject:line];
}

- (PrintNode *)addLineNode:(NSMutableArray<PrintNode *> *)curRow nextRow:(NSMutableArray<PrintNode *> *)nextRow parent:(PrintNode *)parent child:(PrintNode *)child {
    if (!child) return nil;
    
    PrintNode *top = nil;
    int topX = [child topLineX];
    if (child == parent.left) {
        top = [[PrintNode alloc] initWithString:@"┌"];
        [curRow addObject:top];
        for (int x = topX + 1; x < parent.x; x++) [self addXLineNode:curRow parent:parent x:x];
    } else {
        for (int x = [parent rightX]; x < topX; x++) [self addXLineNode:curRow parent:parent x:x];
        top = [[PrintNode alloc] initWithString:@"┐"];
        [curRow addObject:top];
    }
    
    top.x = topX;
    top.y = parent.y;
    child.y = parent.y + 2;
    self.minX = MIN(self.minX, child.x);
    
    PrintNode *bottom = [[PrintNode alloc] initWithString:@"│"];
    bottom.x = topX;
    bottom.y = parent.y + 1;
    [nextRow addObject:bottom];
    
    return top;
}

- (void)addLineNodes:(NSMutableArray<NSMutableArray<PrintNode *> *> *)nodes {
    NSMutableArray<NSMutableArray<PrintNode *> *> *newNodes = [NSMutableArray array];
    int rowCount = (int)nodes.count;
    if (rowCount < 2) return;
    
    self.minX = self.root.x;
    
    for (int i = 0; i < rowCount; i++) {
        NSMutableArray<PrintNode *> *rowNodes = nodes[i];
        if (i == rowCount - 1) {
            [newNodes addObject:rowNodes];
            continue;
        }
        
        NSMutableArray<PrintNode *> *newRowNodes = [NSMutableArray array];
        [newNodes addObject:newRowNodes];
        
        NSMutableArray<PrintNode *> *lineNodes = [NSMutableArray array];
        [newNodes addObject:lineNodes];
        
        for (PrintNode *node in rowNodes) {
            [self addLineNode:newRowNodes nextRow:lineNodes parent:node child:node.left];
            [newRowNodes addObject:node];
            [self addLineNode:newRowNodes nextRow:lineNodes parent:node child:node.right];
        }
    }
    
    [nodes removeAllObjects];
    [nodes addObjectsFromArray:newNodes];
}

- (void)println {
    NSLog(@"%@\n", [self printString]);
}

- (void)print {
    NSLog(@"%@", [self printString]);
}

//- (void)dealloc {
//    NSLog(@"<%@: %p> dealloc", self.className, self);
//}

@end
