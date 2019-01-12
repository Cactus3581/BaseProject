//
//  BPKVOModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/8.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKVOModel : NSObject {
    NSString *_macbook;
    NSString *_iphone;
    
@public
    NSString *_ipad;
}

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *price;
@property (nonatomic, copy) NSString *text;

- (void)changeIphone:(NSString *)iphone;

@end
NS_ASSUME_NONNULL_END
