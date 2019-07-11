//
//  BPHashTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/6/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHashTableViewController.h"

@interface BPHashTableViewController ()

@end

@implementation BPHashTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     
     NSHashTable是更广泛意义的NSSet
     
     NSHashTableStrongMemory:等同于NSPointerFunctionsStrongMemory. 对成员变量进行强引用。这是一个默认值。如果采用这个默认值,NSHashTable和NSSet就没什么区别了。
     
     NSHashTableWeakMemory: 等同于NSPointerFunctionsWeakMemory.对成员变量进行弱引用;
     
     NSHashTableCopyIn: 在对象被加入集合之前进行复制。

     
     */
    //创建一个NSHashTableWeakMemory特性的HashTable对象
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    
    //将该对象添加到HashTable容器中
    [hashTable addObject:@"1"];
    
    //释放之后打印hash_tab
    NSLog(@"after pool:%@",hashTable);
}



@end
