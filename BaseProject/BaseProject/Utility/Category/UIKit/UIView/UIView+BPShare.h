//
//  UIView+BPShare.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customActivity : UIActivity

@property (nonatomic, copy) NSString * title;

@property (nonatomic, strong) UIImage * image;

@property (nonatomic, strong) NSURL * url;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, strong) NSArray * shareContexts;

- (instancetype)initWithTitie:(NSString *)title withActivityImage:(UIImage *)image withUrl:(NSURL *)url withType:(NSString *)type  withShareContext:(NSArray *)shareContexts;
@end


@interface UIView (BPShare)
//@property (nonatomic, strong) UIImage *img;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *desc;
//@property (nonatomic, copy) NSString *url;
@end
