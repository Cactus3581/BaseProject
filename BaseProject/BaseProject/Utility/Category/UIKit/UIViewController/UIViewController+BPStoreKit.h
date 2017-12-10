//
//  UIViewController+StoreKit.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Constants

#define affiliateToken @"10laQX"

#pragma mark - Interface

@interface UIViewController (BPStoreKit)

@property NSString *bp_campaignToken;
@property (nonatomic, copy) void (^bp_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^bp_loadedStoreKitItemBlock)(void);

- (void)bp_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (NSURL*)bp_appURLForIdentifier:(NSInteger)identifier;

+ (void)bp_openAppURLForIdentifier:(NSInteger)identifier;
+ (void)bp_openAppReviewURLForIdentifier:(NSInteger)identifier;

+ (BOOL)bp_containsITunesURLString:(NSString*)URLString;
+ (NSInteger)bp_IDFromITunesURL:(NSString*)URLString;

@end
