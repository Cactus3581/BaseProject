//
//  BPLayoutViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPLayoutViewController.h"
#import "BPLayoutView.h"
#import <Masonry.h>

//http://blog.csdn.net/zpz5789/article/details/50922469
//https://www.jianshu.com/p/1d1a1165bb04
//https://www.jianshu.com/p/94ea6623169d

#pragma mark - 总体过程

/*
 总体过程：
 使用 Auto Layout 将 View 显示在屏幕上需要的经过三个步骤。
 
 1-> 更新约束（updateConstraints）
 2-> 通过约束关系计算出center和bounds对subviews进行布局（layoutSubViews）
 3-> 将布局好的view显示到屏幕（drawRect）
 
 对应updateConstraints -> layoutSubViews -> drawRect
 当view修改约束（addConstraint， removeConstraint）会触发setNeedsUpdateConstraints，而这个在layoutSubViews之前会触发updateConstraints，完成之后会调用layoutSubViews。UIViewController在有个updateViewConstraints 方法，这个方法实际是self.view 被设置了setNeedsUpdateConstraints（第一次展示的时候），必然会调用这个方法（与上面的解释保持一致了，第一次可以理解为为self.view增加了各种约束）。而这个方法的默认实现是调用子view的updateConstraints方法，这样就自上而下的完成了布局。
 此处需要注意的地方：
 1. 不要忘记调用父类的方法，避免有时候出现一些莫名的问题。
 2. 在view的layoutSubViews或者ViewController的viewDidLayoutSubviews方法里后可以拿到view的实际frame，所以当我们真的需要frame的时候需要在这个时间点以后才能拿到。
 
 
 与之相关的方法有如下八个:
 1. setNeedsUpdateConstraints：将 view 标记为需要更新约束，并在稍后触发updateConstraitsIfNeed。
 2. updateConstraitsIfNeed：系统会在每个布局节点自动调用此方法。只有约束被标记为需要更新才会调用updateConstraints。此方法可以手动调用。子类不要重写此方法。
 3. updateConstraints：更新约束的实际方法。
 4. setNeedsLayout：将 view 标记为需要更新布局，并在稍后触发layoutIfNeeded。当view的布局改变时会自动调用。
 5. layoutIfNeeded：系统会在每个布局节点自动调用此方法。只有布局被标记为需要更新才会调用layoutSubViews。
 6. layoutSubViews：在 iOS5.1 之后的是更新布局的实际方法，之前没有默认实现。只有当 autoresizing 和 constraint 不能满足布局需求时才能重写。不能直接调用。会调用updateConstraintsIfNeeded。
 7. setNeedsDisplay：将 view 标记为需要重绘，并在下次绘制循环触发 drawRect。改变布局不会触发此方法。
 8. drawRect：没有默认实现。不能直接调用。
 
 
 UIView的setNeedsDisplay和setNeedsLayout方法。首先两个方法都是异步执行的。而setNeedsDisplay会自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。而setNeedsLayout会默认调用layoutSubViews，就可以处理子视图中的一些数据。具体的, 可以看我之前的一篇文章39.layoutSubviews和drawRect调用时机的探究

 
 */

#pragma mark - 详细过程
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

#pragma mark - 基于触发约束的布局：方法详细：

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
 
 - (void)updateConstraints;
 更新视图的约束；自定义view应该重写此方法在其中建立constraints；要在实现的最后调用[super updateConstraints]
 自定义视图应该通过重写此方法来设置自己的约束。当你的自定义视图有某个约束发生了变化或失效了，应该立即删除这个约束，然后调用setNeedsUpdateConstraints标记约束需要更新。系统在进行布局layout之前，会调用updateConstraints，让你确认（设置）在视图的属性不变时的必要约束。在更新约束阶段你不应该使任何一个约束失效，而且不能让layerout和drawing作为更新约束的一部分。
 */

#pragma mark - 铺设子视图 Layout： 方法详细：

/*
 
 方法详细：

 - (void)setNeedsLayout
 此方法会将view当前的layout设置为无效的，告知页面需要更新，但是不会立刻开始更新，并在下一个upadte cycle里去触发layout更新。所以一般都会和layoutIfNeeded一起使用
 
 - (void)layoutIfNeeded
 告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。如果希望立刻生成新的frame需要调用此方法，利用这点一般布局动画可以在更新布局后直接使用这个方法让动画生效。
 使用此方法强制立即进行layout,从当前view开始，此方法会遍历整个view层次(包括superviews)请求layout。因此，调用此方法会强制整个view层次布局。
 
 - (void)layoutSubviews
 系统重写布局
 1.一个view是不能够自己调用layoutSubviews,如果要调用,需要调用 setNeedsLayout或者 layoutIfNeeded
 2.如果view的frame值为0,即使被addSubview也不会调用layoutSubviews
 3.如果一个view的frame中的 size 值前后发生了改变,那么layoutSubviews也会被触发。 重新设置 frame 但 size 不变的话,是不会触发的
 
 */
#pragma mark - 总结

/*
 总结
 如果想要立即改变约束，需要在setNeedsUpdateConstraints后调用updateConstraintsIfNeeded。
 如果想要立即改变布局，需要在setNeedsLayout后调用layoutIfNeeded。
 */
#pragma mark - autoresizingMask

@interface BPLayoutViewController ()
@property (nonatomic,weak) BPLayoutView *layoutView;
@end

@implementation BPLayoutViewController

//- (UIView *)inputView {
//
//}

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    
//}
//- (void)loadView {
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
    BPLog(@"ViewController: 1-viewDidLoad");

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BPLog(@"ViewController: 2-viewWillAppear");
}

- (void)viewLayoutMarginsDidChange {
    [super viewLayoutMarginsDidChange];
    BPLog(@"3");
    BPLog(@"ViewController: 3-viewLayoutMarginsDidChange");
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    BPLog(@"ViewController: 4-viewSafeAreaInsetsDidChange");
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
    [self.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(@200);
    }];
}

- (BPLayoutView *)layoutView {
    if (!_layoutView) {
        BPLayoutView *view = [[BPLayoutView alloc] init];
        _layoutView = view;
        _layoutView.backgroundColor = kGreenColor;
        [self.view addSubview:_layoutView];
    }
    return _layoutView;
}

@end
