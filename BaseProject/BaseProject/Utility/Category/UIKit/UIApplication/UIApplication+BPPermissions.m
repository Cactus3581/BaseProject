//
//  UIApplication-Permissions.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIApplication+BPPermissions.h"
#import <objc/runtime.h>

//Import required frameworks
#import <AddressBook/AddressBook.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <EventKit/EventKit.h>

typedef void (^BPLocationSuccessCallback)(void);
typedef void (^BPLocationFailureCallback)(void);

static char BPPermissionsLocationManagerPropertyKey;
static char BPPermissionsLocationBlockSuccessPropertyKey;
static char BPPermissionsLocationBlockFailurePropertyKey;

@interface UIApplication () <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *bp_permissionsLocationManager;
@property (nonatomic, copy) BPLocationSuccessCallback bp_locationSuccessCallbackProperty;
@property (nonatomic, copy) BPLocationFailureCallback bp_locationFailureCallbackProperty;
@end


@implementation UIApplication (Permissions)


#pragma mark - Check permissions
-(BPPermissionAccess)hasAccessToBluetoothLE {
    switch ([[[CBCentralManager alloc] init] state]) {
        case CBCentralManagerStateUnsupported:
            return BPPermissionAccessUnsupported;
            break;
            
        case CBCentralManagerStateUnauthorized:
            return BPPermissionAccessDenied;
            break;
            
        default:
            return BPPermissionAccessGranted;
            break;
    }
}

-(BPPermissionAccess)hasAccessToCalendar {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            return BPPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return BPPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return BPPermissionAccessRestricted;
            break;
            
        default:
            return BPPermissionAccessUnknown;
            break;
    }
}

-(BPPermissionAccess)hasAccessToContacts {
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            return BPPermissionAccessGranted;
            break;
            
        case kABAuthorizationStatusDenied:
            return BPPermissionAccessDenied;
            break;
            
        case kABAuthorizationStatusRestricted:
            return BPPermissionAccessRestricted;
            break;
            
        default:
            return BPPermissionAccessUnknown;
            break;
    }
}

-(BPPermissionAccess)hasAccessToLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized:
            return BPPermissionAccessGranted;
            break;
            
        case kCLAuthorizationStatusDenied:
            return BPPermissionAccessDenied;
            break;
            
        case kCLAuthorizationStatusRestricted:
            return BPPermissionAccessRestricted;
            break;
            
        default:
            return BPPermissionAccessUnknown;
            break;
    }
    return BPPermissionAccessUnknown;
}

-(BPPermissionAccess)hasAccessToPhotos {
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusAuthorized:
            return BPPermissionAccessGranted;
            break;
            
        case ALAuthorizationStatusDenied:
            return BPPermissionAccessDenied;
            break;
            
        case ALAuthorizationStatusRestricted:
            return BPPermissionAccessRestricted;
            break;
            
        default:
            return BPPermissionAccessUnknown;
            break;
    }
}

-(BPPermissionAccess)hasAccessToReminders {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusAuthorized:
            return BPPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return BPPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return BPPermissionAccessRestricted;
            break;
            
        default:
            return BPPermissionAccessUnknown;
            break;
    }
    return BPPermissionAccessUnknown;
}


#pragma mark - Request permissions
-(void)bp_requestAccessToCalendarWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)bp_requestAccessToContactsWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if(addressBook) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    accessGranted();
                } else {
                    accessDenied();
                }
            });
        });
    }
}

-(void)bp_requestAccessToMicrophoneWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied {
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)bp_requestAccessToMotionWithSuccess:(void(^)(void))accessGranted {
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity) {
        accessGranted();
        [motionManager stopActivityUpdates];
    }];
}

-(void)bp_requestAccessToPhotosWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        accessGranted();
    } failureBlock:^(NSError *error) {
        accessDenied();
    }];
}

-(void)bp_requestAccessToRemindersWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}


#pragma mark - Needs investigating
/*
 -(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted {
 //REQUIRES DELEGATE - NEEDS RETHINKING
 }
 */

-(void)bp_requestAccessToLocationWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied {
    self.bp_permissionsLocationManager = [[CLLocationManager alloc] init];
    self.bp_permissionsLocationManager.delegate = self;
    
    self.bp_locationSuccessCallbackProperty = accessGranted;
    self.bp_locationFailureCallbackProperty = accessDenied;
    [self.bp_permissionsLocationManager startUpdatingLocation];
}


#pragma mark - Location manager injection
-(CLLocationManager *)bp_permissionsLocationManager {
    return objc_getAssociatedObject(self, &BPPermissionsLocationManagerPropertyKey);
}

-(void)setBp_permissionsLocationManager:(CLLocationManager *)manager {
    objc_setAssociatedObject(self, &BPPermissionsLocationManagerPropertyKey, manager, OBJC_ASSOCIATION_RETAIN);
}

-(BPLocationSuccessCallback)locationSuccessCallbackProperty {
    return objc_getAssociatedObject(self, &BPPermissionsLocationBlockSuccessPropertyKey);
}

-(void)setBp_locationSuccessCallbackProperty:(BPLocationSuccessCallback)locationCallbackProperty {
    objc_setAssociatedObject(self, &BPPermissionsLocationBlockSuccessPropertyKey, locationCallbackProperty, OBJC_ASSOCIATION_COPY);
}

-(BPLocationFailureCallback)locationFailureCallbackProperty {
    return objc_getAssociatedObject(self, &BPPermissionsLocationBlockFailurePropertyKey);
}

-(void)setBp_locationFailureCallbackProperty:(BPLocationFailureCallback)locationFailureCallbackProperty {
    objc_setAssociatedObject(self, &BPPermissionsLocationBlockFailurePropertyKey, locationFailureCallbackProperty, OBJC_ASSOCIATION_COPY);
}


#pragma mark - Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorized) {
        self.locationSuccessCallbackProperty();
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        self.locationFailureCallbackProperty();
    }
}

@end
