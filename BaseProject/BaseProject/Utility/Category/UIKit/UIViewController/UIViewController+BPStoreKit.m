//
//  UIViewController+StoreKit.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIViewController+BPStoreKit.h"

#import <objc/runtime.h>

#import <StoreKit/StoreKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

NSString* const bp_affiliateTokenKey = @"at";
NSString* const bp_campaignTokenKey = @"ct";
NSString* const bp_iTunesAppleString = @"itunes.apple.com";

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (SKStoreProductViewControllerDelegate) <SKStoreProductViewControllerDelegate>

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation

@implementation UIViewController (BPStoreKit)

- (void)bp_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier
{
    SKStoreProductViewController* storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;

    NSString* campaignToken = self.bp_campaignToken ?: @"";

    NSDictionary* parameters = @{
        SKStoreProductParameterITunesItemIdentifier : @(itemIdentifier),
        bp_affiliateTokenKey : bp_affiliateTokenKey,
        bp_campaignTokenKey : campaignToken,
    };

    if (self.bp_loadingStoreKitItemBlock) {
        self.bp_loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError* error) {
        if (self.bp_loadedStoreKitItemBlock) {
            self.bp_loadedStoreKitItemBlock();
        }

        if (result && !error)
        {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation - SKStoreProductViewControllerDelegate

- (void)bp_productViewControllerDidFinish:(SKStoreProductViewController*)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

+ (NSURL*)bp_appURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%li", (long)identifier];
    return [NSURL URLWithString:appURLString];
}

+ (void)bp_openAppReviewURLForIdentifier:(NSInteger)identifier
{
    NSString* reviewURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%li", (long)identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURLString]];
}

+ (void)bp_openAppURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%li", (long)identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURLString]];
}

+ (BOOL)bp_containsITunesURLString:(NSString*)URLString
{
    return ([URLString rangeOfString:bp_iTunesAppleString].location != NSNotFound);
}

+ (NSInteger)bp_IDFromITunesURL:(NSString*)URLString
{
    NSError* error;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult* match = [regex firstMatchInString:URLString options:0 range:NSMakeRange(0, URLString.length)];

    NSString* idString = [URLString substringWithRange:match.range];
    if (idString.length > 0) {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }

    return [idString integerValue];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Associated objects

- (void)setBp_campaignToken:(NSString*)campaignToken
{
    objc_setAssociatedObject(self, @selector(setBp_campaignToken:), campaignToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)bp_campaignToken
{
    return objc_getAssociatedObject(self, @selector(setBp_campaignToken:));
}

- (void)setBp_loadingStoreKitItemBlock:(void (^)(void))loadingStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setBp_loadingStoreKitItemBlock:), loadingStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))bp_loadingStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setBp_loadingStoreKitItemBlock:));
}

- (void)setBp_loadedStoreKitItemBlock:(void (^)(void))loadedStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setBp_loadedStoreKitItemBlock:), loadedStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))bp_loadedStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setBp_loadedStoreKitItemBlock:));
}

@end
