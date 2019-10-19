//
//  UIApplication-Permissions.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//


#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

typedef enum {
    BPPermissionTypeBluetoothLE,
    BPPermissionTypeCalendar,
    BPPermissionTypeContacts,
    BPPermissionTypeLocation,
    BPPermissionTypeMicrophone,
    BPPermissionTypeMotion,
    BPPermissionTypePhotos,
    BPPermissionTypeReminders,
} BPPermissionType;

typedef enum {
    BPPermissionAccessDenied, //User has rejected feature
    BPPermissionAccessGranted, //User has accepted feature
    BPPermissionAccessRestricted, //Blocked by parental controls or system settings
    BPPermissionAccessUnknown, //Cannot be determined
    BPPermissionAccessUnsupported, //Device doesn't support this - e.g Core Bluetooth
    BPPermissionAccessMissingFramework, //Developer didn't import the required framework to the project
} BPPermissionAccess;

@interface UIApplication (BPPermissions)

//Check permission of service. Cannot check microphone or motion without asking user for permission
- (BPPermissionAccess)bp_hasAccessToBluetoothLE;
- (BPPermissionAccess)bp_hasAccessToCalendar;
- (BPPermissionAccess)bp_hasAccessToContacts;
- (BPPermissionAccess)bp_hasAccessToLocation;
- (BPPermissionAccess)bp_hasAccessToPhotos;
- (BPPermissionAccess)bp_hasAccessToReminders;

//Request permission with callback
- (void)bp_requestAccessToCalendarWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)bp_requestAccessToContactsWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)bp_requestAccessToMicrophoneWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)bp_requestAccessToPhotosWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
- (void)bp_requestAccessToRemindersWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;

//Instance methods
- (void)bp_requestAccessToLocationWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;

//No failure callback available
- (void)bp_requestAccessToMotionWithSuccess:(void(^)(void))accessGranted;

//Needs investigating - unsure whether it can be implemented because of required delegate callbacks
//- (void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted;

@end
