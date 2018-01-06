//
//  AboutCopyViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/9.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPBaseViewController.h"

//结构体
typedef struct Myrect {
    float width;
    float height;
}myRect;



//枚举值 它是一个整形(int)  并且,它不参与内存的占用和释放,枚举定义变量即可直接使用,不用初始化.
//在代码中使用枚举的目的只有一个,那就是增加代码的可读性.
typedef NS_ENUM (NSUInteger,direction){
    left=0,
    right=1,
    top =2,
    down =3
};

typedef NS_ENUM (NSUInteger,direction_2){
    left2 = 0,
    right2 = 1 << 0,
    top2 = 1 << 1,
    down2 = 1 << 2
};
typedef NS_ENUM (NSUInteger,direction_1){
    left1 = 1 << 0,
    right1 = 1 << 1,
    top1 = 1 << 2,
    down1 = 1 << 3
    
};




@interface AboutCopyViewController : BPBaseViewController

@property (nonatomic,strong) NSString *titleName;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) direction direction;
@property (nonatomic,assign) direction_1 dir;

@end
