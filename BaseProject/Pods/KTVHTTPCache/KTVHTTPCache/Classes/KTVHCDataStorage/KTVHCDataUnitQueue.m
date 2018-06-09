//
//  KTVHCDataUnitQueue.m
//  KTVHTTPCache
//
//  Created by Single on 2017/8/11.
//  Copyright © 2017年 Single. All rights reserved.
//

#import "KTVHCDataUnitQueue.h"
#import "KTVHCLog.h"

@interface KTVHCDataUnitQueue ()

@property (nonatomic, copy) NSString * path;
@property (nonatomic, strong) NSMutableArray <KTVHCDataUnit *> * unitArray;

@end

@implementation KTVHCDataUnitQueue

+ (instancetype)queueWithPath:(NSString *)path
{
    return [[self alloc] initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path
{
    if (self = [super init])
    {
        self.path = path;
        self.unitArray = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
        if (!self.unitArray)
        {
            self.unitArray = [NSMutableArray array];
        }
    }
    return self;
}

- (NSArray <KTVHCDataUnit *> *)allUnits
{
    if (self.unitArray.count <= 0)
    {
        return nil;
    }
    NSArray <KTVHCDataUnit *> * units = [self.unitArray copy];
    return units;
}

- (KTVHCDataUnit *)unitWithKey:(NSString *)key
{
    if (key.length <= 0)
    {
        return nil;
    }
    KTVHCDataUnit * unit = nil;
    for (KTVHCDataUnit * obj in self.unitArray)
    {
        if ([obj.key isEqualToString:key])
        {
            unit = obj;
            break;
        }
    }
    return unit;
}

- (void)putUnit:(KTVHCDataUnit *)unit
{
    if (!unit)
    {
        return;
    }
    if (![self.unitArray containsObject:unit])
    {
        [self.unitArray addObject:unit];
    }
}

- (void)popUnit:(KTVHCDataUnit *)unit
{
    if (!unit)
    {
        return;
    }
    if ([self.unitArray containsObject:unit])
    {
        [self.unitArray removeObject:unit];
    }
}

- (void)archive
{
    KTVHCLogDataUnitQueue(@"%p, Archive - Begin, %ld", self, (long)self.unitArray.count);
    [NSKeyedArchiver archiveRootObject:self.unitArray toFile:self.path];
    KTVHCLogDataUnitQueue(@"%p, Archive - End  , %ld", self, (long)self.unitArray.count);
}

@end
