//
//  BPMasonryAutoLayoutProcessViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMasonryAutoLayoutProcessViewController.h"
#import "BPMasonryAutoLayoutProcessView.h"
#import <Masonry.h>
#import "UIView+BPAdd.h"

//https://blog.csdn.net/u012894479/article/details/49426973


//http://blog.csdn.net/zpz5789/article/details/50922469
//https://www.jianshu.com/p/1d1a1165bb04
//https://www.jianshu.com/p/94ea6623169d

#pragma mark - 总体布局过程

/*
 总体过程：
 使用 Auto Layout 将 View 显示在屏幕上需要的经过三个步骤。
 
 1-> 更新约束（updateConstraints）
 2-> 通过约束关系计算出center和bounds对subviews进行布局（layoutSubViews）
 3-> 将布局好的view显示到屏幕（drawRect）
 
 对应updateConstraints -> layoutSubViews -> drawRect
 当view修改约束（addConstraint， removeConstraint）会触发setNeedsUpdateConstraints，而这个在layoutSubViews之前会触发updateConstraints，完成之后会调用layoutSubViews。UIViewController有个updateViewConstraints 方法，这个方法实际是self.view 被设置了setNeedsUpdateConstraints（第一次展示的时候），必然会调用这个方法（与上面的解释保持一致了，第一次可以理解为self.view增加了各种约束）。而这个方法的默认实现是调用子view的updateConstraints方法，这样就自上而下的完成了布局。
 此处需要注意的地方：
 1. 不要忘记调用父类的方法，避免有时候出现一些莫名的问题。
 2. 在view的layoutSubViews或者ViewController的viewDidLayoutSubviews方法里后可以拿到view的实际frame，所以当我们真的需要frame的时候需要在这个时间点以后才能拿到。
 
 UIView的setNeedsDisplay和setNeedsLayout方法。首先两个方法都是异步执行的。而setNeedsDisplay会自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。而setNeedsLayout会默认调用layoutSubViews，就可以处理子视图中的一些数据。
 
 */

#pragma mark - 详细布局过程
/*
 
 详细过程:
 
 updating constraints -> layout -> display
 
 Auto layout与autoresizingMask比较，Auto layout在view显示之前，多引入了两个步骤：updating constraints 和laying out views。每一个步骤都依赖于上一个。display依赖layout，而layout依赖updating constraints。
 
 第一步：updating constraints，被称为测量阶段，其从下向上(from subview to super view),为下一步layout准备信息。可以通过调用方法setNeedUpdateConstraints去触发此步。constraints的改变也会自动的触发此步。但是，当你自定义view的时候，如果一些改变可能会影响到布局的时候，通常需要自己去通知Auto layout，updateConstraintsIfNeeded。自定义view的话，通常可以重写updateConstraints方法，在其中可以添加view需要的局部的contraints。
 第二步：layout，其从上向下(from super view to subview)，此步主要应用上一步的信息去设置view的center和bounds。可以通过调用setNeedsLayout去触发此步骤，此方法不会立即应用layout。如果想要系统立即的更新layout，可以调用layoutIfNeeded。另外，自定义view可以重写方法layoutSubViews来在layout的工程中得到更多的定制化效果。
 第三步：display，此步时把view渲染到屏幕上，它与你是否使用Auto layout无关，其操作是从上向下(from super view to subview)，通过调用setNeedsDisplay触发，
 因为每一步都依赖前一步，因此一个display可能会触发layout，当有任何layout没有被处理的时候，同理，layout可能会触发updating constraints，当constraint system更新改变的时候。
 需要注意的是，这三步不是单向的，constraint-based layout是一个迭代的过程，layout过程中，可能去改变constraints，有一次触发updating constraints，进行一轮layout过程。
 注意：如果你每一次调用自定义layoutSubviews都会导致另一个布局传递，那么你将会陷入一个无限循环中。
 
 */


#pragma mark - 基于触发约束的布局，方法详细介绍：
/*
与之相关的方法有如下八个:
1. setNeedsUpdateConstraints：将 view 标记为需要更新约束，并在稍后触发updateConstraitsIfNeed。
2. updateConstraitsIfNeed：系统会在每个布局节点自动调用此方法。只有约束被标记为需要更新才会调用updateConstraints。此方法可以手动调用。子类不要重写此方法。
3. updateConstraints：更新约束的实际方法。
4. setNeedsLayout：将 view 标记为需要更新布局，并在稍后触发layoutIfNeeded。当view的布局改变时会自动调用。
5. layoutIfNeeded：系统会在每个布局节点自动调用此方法。只有布局被标记为需要更新才会调用layoutSubViews。
6. layoutSubViews：在 iOS5.1 之后的是更新布局的实际方法，之前没有默认实现。只有当 autoresizing 和 constraint 不能满足布局需求时才能重写。不能直接调用。会调用updateConstraintsIfNeeded。
7. setNeedsDisplay：将 view 标记为需要重绘，并在下次绘制循环触发 drawRect。改变布局不会触发此方法。
8. drawRect：没有默认实现。不能直接调用。
 */

#pragma mark - 基于Layout，方法详细介绍：

/*
 方法详细：
 
 - (void)setNeedsUpdateConstraints;
 控制视图的约束是否需要更新。
 当你的自定义视图的属性改变切影响到约束，你可以调用这个方法来标记未来的某一点上需要更新的约束。然后系统将调用updateconstraints。
 注解：这个方法和updateConstraintsIfNeeded关系有点暧昧，updateConstraintsIfNeeded是立即更新，二这个方法是标记需要更新，然后系统决定更新时机。
 
 - (BOOL)needsUpdateConstraints;
 这个很简单，返回是否需要更新约束。constraint-based layout system使用此返回值去决定是否需要调用updateConstraints作为正常布局过程的一部分。
 
 - (void)updateConstraintsIfNeeded;
 更新视图和它的子视图的约束；立即出发约束更新； 子类不应重写此方法
 每当一个新的布局，通过触发一个视图，系统调用此方法以确保视图和其子视图的任何约束与当前视图层次结构和约束信息更新。这种方法被系统自动调用，但如果需要检查最新的约束条件，可以手动调用这个方法。所以一般都会和setNeedsUpdateConstraints一起使用
 setNeedsUpdateConstraints：立即出发约束更新。但并不意味着接下来就能立即得到正确的frame，还是必须layoutIfNeed之后，就会走layoutSubViews就能得到正确的约束了，也就是说无论是frame布局还是约束布局，只能在layoutSubViews里才能得到正确的frame
 更新视图和它的子视图的约束。
 每当一个新的布局，通过触发一个视图，系统调用此方法以确保视图和其子视图的任何约束与当前视图层次结构和约束信息更新。这种方法被系统自动调用，但如果需要检查最新的约束条件，可以手动调用这个方法。
 子类不应重写此方法。
 
 
 - (void)updateConstraints;
 更新视图的约束；自定义view应该重写此方法在其中建立constraints；要在实现的最后调用[super updateConstraints]
 自定义视图应该通过重写此方法来设置自己的约束。当你的自定义视图有某个约束发生了变化或失效了，应该立即删除这个约束，然后调用setNeedsUpdateConstraints标记约束需要更新。系统在进行布局layout之前，会调用updateConstraints，让你确认（设置）在视图的属性不变时的必要约束。在更新约束阶段你不应该使任何一个约束失效，而且不能让layerout和drawing作为更新约束的一部分。
 */

#pragma mark - 总结布局过程，及使用注意点：

/*
 总结
 如果想要立即改变约束，需要在setNeedsUpdateConstraints后调用updateConstraintsIfNeeded。
 如果想要立即改变布局，需要在setNeedsLayout后调用layoutIfNeeded。
 
 
 updateConstraintsIfNeeded:更新视图和它的子视图的约束。系统自动调用，但如果需要检查最新的约束条件，可以手动调用这个方法。立即出发约束更新。
 
 updateConstraints:自定义view应该重写此方法在其中建立constraints.
 
 setNeedsUpdateConstraints:这个方法是标记需要更新，然后系统决定更新时机。updateConstraintsIfNeeded是立即更新，
 
需要确定谁去调用，调用完，回调是否会通知
 
 
 ：display，此步时把view渲染到屏幕上，它与你是否使用Auto layout无关，其操作是从上向下(from super view to subview)，通过调用setNeedsDisplay触发，
 需要注意的是，这三步不是单向的，constraint-based layout是一个迭代的过程，layout过程中，可能去改变constraints，有一次触发updating constraints，进行一轮layout过程。
 
 每一步都是基于前一步操作的；显示基于布局视图，布局视图基于更新约束。
 frame时代只有布局和显示
 
 第一步：更新约束，可以被认为是一个“计量传递”。这发生于自下而上（从子视图到父视图），并准备设置视图frame所需要的布局信息。
 
 第二步：布局，发生于自上而下（从父视图到子视图）。这种布局传递实际上是通过设置frame（在OS X中）或者center和bounds（在iOS中）将约束条件系统的解决方案应用到视图上。你可以通过调用setNeedsLayout来触发这个传递，这并不会立刻应用布局，而是注意你稍后的请求。因为所有的布局请求将会被合并到一个布局传递，所以你不需要为经常调用这个方法而困扰。
 
 你可以调用layoutIfNeeded/layoutSubtreeIfNeeded（iOS/OS X）来强制系统立即更新视图树的布局。如果你下一步操作依赖于更新后视图的frame，这将非常有用。
 
 最终，不管你是否用了自动布局，显示器都会将自上而下将渲染视图传递到屏幕上，
 
 
 固有内容大小（Intrinsic Content Size ）
 固有内容大小是一个视图期望为其显示特定内容得到的大小。比如，UILabel有一个基于字体的首选高度，一个基于字体和显示文本的首选宽度。一个UIProgressView仅有一个基于其插图的首选高度，但没有首选宽度。一个没有格式的UIView既没有首选宽度也没有首选高度。要注意的是，固有内容大小必须是独立于视图frame的。例如，不可能返回一个基于frame特定高宽比的固有内
 
 

 */

@interface BPMasonryAutoLayoutProcessViewController ()
@property (nonatomic,weak) BPMasonryAutoLayoutProcessView *layoutProcessView;
@property (nonatomic,weak) UIScrollView *scrollView;//测试滑动对layoutSubViews的影响
@end

@implementation BPMasonryAutoLayoutProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BPLog(@"ViewController: 1-viewDidLoad");
    self.rightBarButtonTitle = @"changeFrame";
    [self initSubView];
    [self testClick];
#pragma mark - 测试滑动对lauoutSubViews的回调效果
//    self.scrollView.backgroundColor = kGreenColor;
}

- (void)testClick {
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"reset"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:bt];
        [bt setTitle:obj forState:UIControlStateNormal];
        [bt setTitleColor:kWhiteColor forState:UIControlStateNormal];
        bt.backgroundColor = kBlackColor;
        bt.frame = CGRectMake(10+10*idx+idx*20, 100, 20, 30);
        [bt addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"change%lu",(unsigned long)idx]) forControlEvents:UIControlEventTouchUpInside];
    }];
}

#pragma mark -  测试1:外部直接修改值
- (void)change0 {
    /*
     viewWillLayoutSubviews
     viewDidLayoutSubviews
     如果不改变size，不会引起layoutProcessView的lauoutSubViews
     */
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
    [self.layoutProcessView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(10);
    }];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
    //    [self.view layoutIfNeeded]; //相当于提前回调了viewWillLayoutSubviews和viewDidLayoutSubviews，如果不加这句话，会在下一个循环里回调;layoutIfNeeded遍历的不是superview链，应该是subviews链.

    [self.view setNeedsUpdateConstraints];//updateViewConstraints
    [self.view updateConstraintsIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
}

- (void)change1 {
    /*
     viewWillLayoutSubviews
     viewDidLayoutSubviews
     UIView:layoutSubviews
     */
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));

    [self.layoutProcessView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200-10);
    }];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
//    [self.view layoutIfNeeded];
    
    /*
     updateViewConstraints
     viewWillLayoutSubviews
     viewDidLayoutSubviews
     layoutSubviews
     */
//    [self.view setNeedsUpdateConstraints];//updateViewConstraints
//    [self.view updateConstraintsIfNeeded];
    
//    [self.layoutProcessView setNeedsUpdateConstraints];//updateViewConstraints
//    [self.layoutProcessView updateConstraintsIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
}

#pragma mark - 测试2:外部调用View对象，在里面修改自身的值
- (void)change2 {
    //同change0
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
    [self.layoutProcessView changeCenter];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
    //[self.view layoutIfNeeded];
    [self.view setNeedsUpdateConstraints];//updateViewConstraints
    [self.view updateConstraintsIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
}
- (void)change3 {
    //同change1
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
    [self.layoutProcessView changeSize];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
 
    //[self.view layoutIfNeeded];
    [self.view setNeedsUpdateConstraints];//updateViewConstraints
    [self.view updateConstraintsIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
}

#pragma mark -  测试3:外部调用View对象，在里面修改它的子view的值：修改size值，会引起它的父view的layoutSubViews的回调，而且size必须前后的值必须有变化；center不会；
- (void)change4 {

    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    [self.layoutProcessView changeSubViewCenter];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    /*
     无论是单独使用[self.view layoutIfNeeded];还是[self.layoutProcessView layoutIfNeeded]; 都只会触发以下这个方法，但是调用哪个对象更合适
     UIView:layoutSubviews
     */
    //[self.view layoutIfNeeded];
    //[self.layoutProcessView layoutIfNeeded];
    
    /*
     updateViewConstraints
     viewWillLayoutSubviews
     viewDidLayoutSubviews
     layoutSubviews
     */
//    [self.view setNeedsUpdateConstraints];
//    [self.view updateConstraintsIfNeeded];
    
    [self.layoutProcessView setNeedsUpdateConstraints];
    [self.layoutProcessView updateConstraintsIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
}
- (void)change5 {
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    [self.layoutProcessView changeSubViewSize];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    //同change4 一模一样
    [self.view layoutIfNeeded];
    [self.layoutProcessView layoutIfNeeded];

    //同change4 一模一样
//    [self.view setNeedsUpdateConstraints];
//    [self.view updateConstraintsIfNeeded];
//    [self.layoutProcessView setNeedsUpdateConstraints];
//    [self.layoutProcessView updateConstraintsIfNeeded];

    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    
}
- (void)change6 {
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    [self.layoutProcessView.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(80);
    }];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    //同change4 一模一样
    //[self.view layoutIfNeeded];
    //[self.layoutProcessView layoutIfNeeded];
    
    //同change4 一模一样
    //    [self.view setNeedsUpdateConstraints];
    //    [self.view updateConstraintsIfNeeded];
    //    [self.layoutProcessView setNeedsUpdateConstraints];
    //    [self.layoutProcessView updateConstraintsIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    
}
- (void)change7 {
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));

    [self.layoutProcessView.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200-90);
    }];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
    //同change4 一模一样
    //[self.view layoutIfNeeded];
    //[self.layoutProcessView layoutIfNeeded];
    
    //同change4 一模一样
    //    [self.view setNeedsUpdateConstraints];
    //    [self.view updateConstraintsIfNeeded];
    //    [self.layoutProcessView setNeedsUpdateConstraints];
    //    [self.layoutProcessView updateConstraintsIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.button.frame));
}

// 恢复
- (void)change8 {
    [self.layoutProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.width.height.mas_equalTo(200);
        make.centerX.equalTo(self.view);
    }];
}

- (void)rightBarButtonItemClickAction:(id)sender {
#pragma mark - 对使用frame布局的对象没有用，修改frame直接生效了，如果是对约束布局的viw对象，可能不会立即生效，需要在下一个runloop更新UI的时机生效，如果需要立即生效，就可以使用下面这句话了
    [self.view layoutIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BPLog(@"ViewController: 2-viewWillAppear");
}

//这个方法默认的实现是调用对应View的 -updateConstraints 。ViewController的View在更新视图布局时，会先调用ViewController的updateViewConstraints 方法。我们可以通过重写这个方法去更新当前View的内部布局，而不用再继承这个View去重写-updateConstraints方法。我们在重写这个方法时，务必要调用 super 或者 调用当前View的 -updateConstraints 方法。
- (void)updateViewConstraints {
    [super updateViewConstraints];
    BPLog(@"ViewController: 5-updateViewConstraints");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    BPLog(@"ViewController: 6-viewWillLayoutSubviews");
}

//在view的layoutSubViews或者ViewController的viewDidLayoutSubviews方法里后可以拿到view的实际frame，所以当我们真的需要frame的时候需要在这个时间点以后才能拿到。
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    BPLog(@"ViewController: 7-viewDidLayoutSubviews");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BPLog(@"ViewController: 8-viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    BPLog(@"ViewController: 9-viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    BPLog(@"ViewController: 10-viewDidDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    BPLog(@"ViewController: didReceiveMemoryWarning");
}

- (void)dealloc {
    BPLog(@"ViewController: dealloc");
}

- (void)initSubView {
    BPLog(@"ViewController: initSubView");
    [self.layoutProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.width.height.mas_equalTo(200);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - 滑动不会引起layoutSubViews
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor greenColor];
        scrollView.pagingEnabled = NO;
        scrollView.clipsToBounds = YES;
        scrollView.bounces = NO;
        scrollView.alwaysBounceVertical = NO;
        scrollView.alwaysBounceHorizontal = NO;
        scrollView.showsVerticalScrollIndicator = YES;
        scrollView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:scrollView];
        scrollView.frame = self.view.bounds;
        scrollView.contentSize = CGSizeMake(self.view.width, 1000);
        UIView *leftView = [[UIView alloc] init];
        [scrollView addSubview:leftView];
        leftView.backgroundColor = [UIColor redColor];
        _scrollView = scrollView;
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.top.leading.trailing.equalTo(self.view);
            make.height.mas_equalTo(1000);
        }];
    }
    return _scrollView;
}

- (BPMasonryAutoLayoutProcessView *)layoutProcessView {
    if (!_layoutProcessView) {
        BPMasonryAutoLayoutProcessView *view = [[BPMasonryAutoLayoutProcessView alloc] init];
        _layoutProcessView = view;
        _layoutProcessView.backgroundColor = kGreenColor;
#pragma mark - addSubview会引起layoutSubViews，哪怕没有frame
        [self.view addSubview:_layoutProcessView];
    }
    return _layoutProcessView;
}

@end
