//
//  BPHashTableViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/6/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHashTableViewController.h"

@interface BPHashTableViewController ()

@end

@implementation BPHashTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     
     NSHashTable是更广泛意义的NSMutableSet，是可变的，没有不可变的对应类。

     
     Options：
        NSHashTableStrongMemory：等同于NSPointerFunctionsStrongMemory. 对成员变量进行强引用。这是一个默认值。如果采用这个默认值,NSHashTable和NSSet就没什么区别了。
        NSHashTableWeakMemory：等同于NSPointerFunctionsWeakMemory。对成员变量进行弱引用;
        NSHashTableCopyIn：在对象被加入集合之前进行复制。
        NSHashTableZeroingWeakMemory：
     */
    
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    
    [hashTable addObject:@"hello"];
    [hashTable addObject:@"world"];

    [hashTable removeObject:@"world"];

    [[hashTable allObjects] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    //释放之后打印hash_tab
    NSLog(@"after pool:%@",hashTable);
}



@end
