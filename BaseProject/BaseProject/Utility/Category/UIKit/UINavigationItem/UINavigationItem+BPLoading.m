//
// UINavigationItem+Loading.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UINavigationItem+BPLoading.h"
#import <objc/runtime.h>

static void *BPLoaderPositionAssociationKey = &BPLoaderPositionAssociationKey;
static void *BPSubstitutedViewAssociationKey = &BPSubstitutedViewAssociationKey;

@implementation UINavigationItem (BPLoading)

- (void)bp_startAnimatingAt:(BPNavBarLoaderPosition)position {
    // stop previous if animated
    [self bp_stopAnimating];
    
    // hold reference for position to stop at the right place
    objc_setAssociatedObject(self, BPLoaderPositionAssociationKey, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIActivityIndicatorView* loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // substitute bar views to loader and hold reference to them for restoration
    switch (position) {
        case BPNavBarLoaderPositionLeft:
            objc_setAssociatedObject(self, BPSubstitutedViewAssociationKey, self.leftBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.leftBarButtonItem.customView = loader;
            break;
            
        case BPNavBarLoaderPositionCenter:
            objc_setAssociatedObject(self, BPSubstitutedViewAssociationKey, self.titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.titleView = loader;
            break;
            
        case BPNavBarLoaderPositionRight:
            objc_setAssociatedObject(self, BPSubstitutedViewAssociationKey, self.rightBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.rightBarButtonItem.customView = loader;
            break;
    }
    
    [loader startAnimating];
}

- (void)bp_stopAnimating {
    NSNumber *positionToRestore = objc_getAssociatedObject(self, BPLoaderPositionAssociationKey);
    id componentToRestore = objc_getAssociatedObject(self, BPSubstitutedViewAssociationKey);
    
    // restore UI if animation was in a progress
    if (positionToRestore) {
        switch (positionToRestore.intValue) {
            case BPNavBarLoaderPositionLeft:
                self.leftBarButtonItem.customView = componentToRestore;
                break;
                
            case BPNavBarLoaderPositionCenter:
                self.titleView = componentToRestore;
                break;
                
            case BPNavBarLoaderPositionRight:
                self.rightBarButtonItem.customView = componentToRestore;
                break;
        }
    }
    objc_setAssociatedObject(self, BPLoaderPositionAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, BPSubstitutedViewAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
