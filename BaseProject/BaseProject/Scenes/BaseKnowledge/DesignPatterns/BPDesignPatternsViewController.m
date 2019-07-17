//
//  BPDesignPatternsViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDesignPatternsViewController.h"
#import "BPFactory.h"
#import "BPCarProduct.h"
#import "BPSUVProduct.h"
#import "BPFordFactory.h"
#import "BPBMWFactory.h"

@interface BPDesignPatternsViewController ()

@end

@implementation BPDesignPatternsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self simpleFactory];//简单工厂模式
            }
                break;
                
            case 1:{
                [self factory];//工厂模式
            }
                break;
                
            case 2:{
                [self abstractFactory];//抽象工厂模式
            }
                break;
        }
    }
}

#pragma mark - 简单工厂模式
- (void)simpleFactory {
    // BPCarProduct
    BPProduct *product1 = [BPFactory productWithType:BPProductCarType];
    [product1 productName];
    
    // BPSuvProduct
    BPProduct *product2 = [BPFactory productWithType:BPProductSuvType];
    [product2 productName];
}

#pragma mark - 工厂模式
- (void)factory {
    // BPCarProduct
    BPProduct *product1 = [BPFordFactory product];
    [product1 productName];

    // BPSuvProduct
    BPProduct *product2 = [BPBMWFactory product];
    [product2 productName];
}

#pragma mark - 抽象工厂模式
- (void)abstractFactory {
    // BPCarProduct
    BPFactory *factory1 = [BPFordFactory factory];
    BPCarProduct *factory1_product1 = [factory1 carProduct];
    BPSUVProduct *factory1_product2 = [factory1 suvProduct];
    [factory1_product1 productName];
    [factory1_product2 productName];

    BPFactory *factory2 = [BPBMWFactory factory];
    BPCarProduct *factory2_product1 = [factory2 carProduct];
    BPSUVProduct *factory2_product2 = [factory2 suvProduct];
    [factory2_product1 productName];
    [factory2_product2 productName];
}

@end
