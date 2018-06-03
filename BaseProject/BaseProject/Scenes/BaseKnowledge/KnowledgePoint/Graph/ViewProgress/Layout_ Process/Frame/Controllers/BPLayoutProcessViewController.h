//
//  BPLayoutProcessViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

@interface BPLayoutProcessViewController : BPBaseViewController

@end

/*
 执行顺序：
 
 viewDidLoad
 initWithFrame
 
 viewWillAppear
 viewWillLayoutSubviews
 viewDidLayoutSubviews
 
 layoutSubviews
 drawRect
 
 viewDidAppear
 
 ---------------------------------------------------------------------------------------------------------
 #pragma mark -
 iOS中布局相关方法：
 - (CGSize)sizeThatFits:(CGSize)size;  //frame布局不会回调sizeThatFits,因为不含content吗？
 - (void)sizeToFit;                    // 不能在子类中重写 sizeToFit
 
 ---------------------------------------------------------------------------------------------------------
 方法详细：

 1. layoutsubviews本质：是修改size的一个回调方法，也可以理解为修改size后的一个通知;当view的size改变的时候，它的layoutSubViews会调用，在里面设置子view的frame；所以一系列的修改frame的操作，如果依赖于父view，最好把它放在layoutSubViews里；也有可能设置子View的时候，会引起父view的layoutSubViews的回调；layoutSubviews对subviews重新布局
 2. 关于循环调用的问题，比如我设置了view的frame，也在layoutSubViews里设置了，会引起循环调用，但是我发现并没有；
 3. layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。反过来的意思就是说：如果你想要在外部设置subviews的位置，就不要重写；
 4. layoutSubviews对subviews重新布局
 5. layoutSubviews方法调用先于drawRect
 6. Frame布局，修改frame，会立即生效，得到修改后的frame，而且不走约束的回调方法；相较于约束，布局会在下个runloop里，frame才会生效，除非立即layoutIfneed；
 7.一个view是不能够自己调用layoutSubviews,如果要调用,需要使用父view调用setNeedsLayout或者 layoutIfNeeded；
 8.如果一个view的frame中的 size 值前后发生了改变,那么layoutSubviews也会被触发。 重新设置frame但size不变的话,是不会触发的；
 
 layoutSubviews在以下情况下会被调用：
 1.addSubview,哪怕没有frame；
 2. 改变自己及子view的size，而且size值必须有变化；
 3.旋转：只会引起controller的viewWillLayoutSubViews的回调，不会引起它的子View的layoutSubViews的回调；旋转 Screen 会触发 父view 上的 layoutSubviews
 4.滚动：当子view为scroll的时候，滑动暂未引起所有layoutSubViews的变化（测试并没有引起调用）
 
 引起controller的viewWillLayoutSubviews：
 1. 改变子view的size，并不包括子view的子view;
 
 ---------------------------------------------------------------------------------------------------------

 setNeedsLayout:标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用；setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews； layoutIfNeeded—>layoutIfNeeded（立即刷新布局）—>layoutSubViews

 layoutIfNeeded:如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）；UIKit会判断该receiver是否需要layout; layoutIfNeeded遍历的不是superview链，应该是subviews链；也就是说如果更改了一个view的约束或者frame，如果想立即生效，那就用它的父view调用layoutIfNeeded（记住是父view），然后就会走这个view的layoutSubViews；告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。如果希望立刻生成新的frame需要调用此方法，利用这点一般布局动画可以在更新布局后直接使用这个方法让动画生效。使用此方法强制立即进行layout,从当前view开始，此方法会遍历整个view层次(包括superviews)请求layout。因此，调用此方法会强制整个view层次布局。
 
 如果要立即刷新，要先调用[view setNeedsLayout]，把标记设为需要布局，然后马上调用[view layoutIfNeeded]，实现布局
 
 ---------------------------------------------------------------------------------------------------------

 绘图
 - (void)setNeedsDisplay:标记为需要重绘，异步调用drawRect；在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘
 - (void)drawRect:重写此方法，执行重绘任务；drawRect是对receiver的重绘，能获得context
 这个两个方法都没没有递归，对 subViews 也不负责，只负责自己。
 
 ---------------------------------------------------------------------------------------------------------

 layoutSubviews在以下情况下会被调用：
 1 init初始化不会触发layoutSubviews,但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化：具体指size
 4、滚动一个UIScrollView会触发layoutSubviews：测试发现不会
 5、旋转Screen会触发父UIView上的layoutSubviews事件：viewWillLayoutSubviews，viewDidLayoutSubviews，layoutSubViews没有触发
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件：向下看
 
 */
