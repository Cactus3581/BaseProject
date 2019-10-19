//
//  BPDesignPatternsViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDesignPatternsViewController.h"
#import "BPFactory.h"
#import "BPCarProduct.h"
#import "BPSUVProduct.h"
#import "BPFordFactory.h"
#import "BPBMWFactory.h"
#import "BPCarFactory.h"
#import "BPSuvFactory.h"

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
    BPProduct *car = [BPFactory produceWithType:BPProductCarType];
    [car productName];
    
    // BPSuvProduct
    BPProduct *suv = [BPFactory produceWithType:BPProductSuvType];
    [suv productName];
}

#pragma mark - 工厂模式
- (void)factory {
    // BPCarProduct
    BPProduct *card = [BPCarFactory produce];
    [card productName];

    // BPSuvProduct
    BPProduct *suv = [BPSUVFactory produce];
    [suv productName];
}

#pragma mark - 抽象工厂模式
- (void)abstractFactory {
    BPCarProduct *fordCar = [BPFordFactory produceCar];
    [fordCar productName];

    BPSUVProduct *fordSUV = [BPFordFactory produceSuv];
    [fordSUV productName];

    BPCarProduct *bmwCar = [BPBMWFactory produceCar];
    [bmwCar productName];

    BPSUVProduct *bmwSUV = [BPBMWFactory produceSuv];
    [bmwSUV productName];
}

@end
