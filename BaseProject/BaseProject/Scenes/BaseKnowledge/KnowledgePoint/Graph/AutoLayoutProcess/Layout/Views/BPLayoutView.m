//
//  BPLayoutView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPLayoutView.h"
//http://blog.csdn.net/zpz5789/article/details/50922469
//http://blog.csdn.net/u011623532/article/details/46549227
//http://blog.csdn.net/WQ5201314O/article/details/52184622
//http://www.cocoachina.com/ios/20160530/16522.html
//http://blog.csdn.net/zpz5789/article/details/50922469
//https://blog.cnbluebox.com/blog/2015/02/02/autolayout2/
@interface BPLayoutView()
@property (nonatomic,weak) UIButton *button;
@end

@implementation BPLayoutView

/*
 所以，结论，还是将约束的设置写在viewDidLoad中或者init中。没事儿尽量不去碰updateConstraints。除非对性能有要求：
 

 尽量将约束的添加写到类似于viewDidLoad的方法中。
 
 updateConstraints并不应该用来给视图添加约束，它更适合用于周期性地更新视图的约束，或者在添加约束过于消耗性能的情况下将约束写到该方法中。
 
 当我们在响应事件时（例如点击按钮时）对约束的修改如果写到updateConstraints中，会让代码的可读性非常差。
 
 所以，结论，还是将约束的设置写在viewDidLoad中或者init中。没事儿尽量不去碰updateConstraints。除非对性能有要求。
 
 你应该在你的代码中ViewDidLoad等中添加约束，一开始初始化就做到。后面如果需要动态修改再在需要的时候修改
 
调用次数
 
 */

/*
当不得以使用frame并frame依赖其他view，此view使用约束时；
比如layer：
1. 可把layer设置farme放在layoutSubviews或者viewDidLayoutSubviews；
2. 如果我们必须要将约束和frame写在同一方法中，写完约束就设置frame，而不是想把frame的设置写到layoutSubview中（比如我们设置好约束后马上就想根据约束的结果计算高度），那么我们还可以在设置完约束之后手动调用layoutIfNeeded方法，让视图立即layout，更新frame。在这之后就可以拿到设置约束的视图的尺寸了。
*/
- (instancetype)init {
    self = [super init];
    if (self) {
        BPLog(@"UIView:init");
        [self configConstraint];//不会被覆盖
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    BPLog(@"UIView:initWithFrame");
    if (self) {
        
    }
    return self;
}
 /*
  调用在view 内部，而不是viewcontroller：我们应该在自定义View中重写这个方法。如果我们要使用Auto Layout布局当前视图，应该设置为返回YES。
  所以在纯代码自定义一个view时，想把约束写在updateConstraints方法中，就一定要重写requiresConstraintBasedLayout方法，返回true。
  interface builder初始化的，那么这个实例的updateViewConstraints或updateConstraints方法便会被系统自动调用，起原因应该就是对应的requiresConstraintBasedLayout方法返回true。而纯代码初始化的视图requiresConstraintBasedLayout方法默认返回false。
*/
+ (BOOL)requiresConstraintBasedLayout {
    BPLog(@"UIView:requiresConstraintBasedLayout");
    return YES;
}


- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    BPLog(@"UIView:safeAreaInsetsDidChange");
}

- (void)layoutMarginsDidChange {
    [super layoutMarginsDidChange];
    BPLog(@"UIView:layoutMarginsDidChange");
}

/**
 *  苹果推荐 约束 增加和修改 放在此方法中
 更新view的约束,并会调用其所有子视图的该方法去更新约束。
 当view的updateConstraints被调用时，该view若有controller，该controller的updateViewConstraints便会被调用。
 
 两个方法都需要在方法实现的最后调用父类的该方法。并且这两个方法不建议直接调用。
 至于纯代码写的viewController如何让其updateViewConstraints方法被调用。我自己的解决办法是手动调用其view的setNeedsUpdateConstraints方法。
 

 */
- (void)updateConstraints {
//    [self configConstraint];//不会被覆盖
    BPLog(@"UIView:updateConstraints");
    //最后记得回调super方法
    [super updateConstraints];
}

/*
 1. frame布局在这写；直接设置subviews的frame。
 2. 使用tableview中有UILabel时，系统计算高度，在这写label.preferredMaxLayoutWidth
 3. 使用你设置在此view上面的constraints(Autolayout)去决定subviews的position和size
 */

/*
 layoutSubviews在以下情况下会被调用：
 1、init初始化不会触发layoutSubviews
 但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
 
 2、addSubview会触发layoutSubviews
 
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 
 4、滚动一个UIScrollView会触发layoutSubviews
 
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 
 
 layoutSubviews对subviews重新布局
 layoutSubviews方法调用先于drawRect
 */
- (void)layoutSubviews {
    [super layoutSubviews];
//    _projectTitleLabel.preferredMaxLayoutWidth = CGRectGetWidth(_projectTitleLabel.frame);
    BPLog(@"UIView:layoutSubviews");
}

/*
 三、drawRect方法使用注意点：
 1、 若使用UIView绘图，只能在drawRect：方法中获取相应的contextRef并绘图。如果在其他方法中获取将获取到一个invalidate 的ref并且不能用于画图。drawRect：方法不能手动显示调用，必须通过调用setNeedsDisplay 或 者 setNeedsDisplayInRect，让系统自动调该方法。
 2、若使用calayer绘图，只能在drawInContext: 中（类似于drawRect）绘制，或者在delegate中的相应方法绘制。同样也是调用setNeedDisplay等间接调用以上方法
 3、若要实时画图，不能使用gestureRecognizer，只能使用touchbegan等方法来调用setNeedsDisplay实时刷新屏幕
 4.重写此方法，执行重绘任务
 */

/*
 -setNeedsDisplay方法：标记为需要重绘，异步调用drawRect
 -setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘
 */
- (void)drawRect:(CGRect)rect {
    BPLog(@"UIView:drawRect");
}

//通知视图指定子视图已经添加
- (void)didAddSubview:(UIView *)subview {
    BPLog(@"UIView:didAddSubview");
}

//通知视图将要移除指定的子视图
- (void)willRemoveSubview:(UIView *)subview {
    BPLog(@"UIView:willRemoveSubview");
}

//通知视图将要移动到一个新的父视图中
- (void)willMoveToSuperview:(UIView *)newSuperview {
    BPLog(@"UIView:willMoveToSuperview");
}

//通知视图已经移动到一个新的父视图中
- (void)didMoveToSuperview {
    BPLog(@"UIView:didMoveToSuperview");
}

//通知视图将要移动到一个新的window中
- (void)willMoveToWindow:(UIWindow *)newWindow {
    BPLog(@"UIView:willMoveToWindow");
}

//通知视图已经移动到一个新的window中
- (void)didMoveToWindow {
    BPLog(@"UIView:didMoveToWindow");
}

//配置自动调整大小状态 Configuring the Resizing Behavior

/*
 根据子视图的大小位置，调整视图，使其恰好围绕子视图， 也就是说自动适应子视图的大小，只显示子视图
 不应该在子类中被重写，应该重写sizeThatFits
 自动调用sizeThatFits方法；
 可以被手动直接调用
 sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己

*/
- (void)sizeToFit {
    BPLog(@"UIView:sizeToFit");
}

//让视图计算最适合子视图的大小，即能把全部子视图显示出来所需要的最小的size
//传入的参数是receiver当前的size，返回一个适合的size
- (CGSize)sizeThatFits:(CGSize)size {
    BPLog(@"UIView:sizeThatFits");
    return size;
}

- (void)dealloc {
    BPLog(@"UIView:dealloc");
}

- (void)configConstraint {
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.width.height.equalTo(self).multipliedBy(0.5);
    }];
}

- (UIButton *)button {
    if (!_button) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        _button = bt;
        [bt addTarget:self action:@selector(updateConstraint) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:@"修改约束" forState:UIControlStateNormal];
        [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
        [bt setBackgroundColor:kRedColor];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:bt];
    }
    return _button;
}

- (void)updateConstraint {
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(-20);
    }];
    
    // 通知需要更新约束，但是不立即执行
    [self setNeedsUpdateConstraints];
    // 立即更新约束，以执行动态变换
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];

    [self needsUpdateConstraints];
    
    [UIView animateWithDuration:0.25 animations:^{
        /*
         setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews
         layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout.根据Apple官方文档,layoutIfNeeded方法应该是这样的
         layoutIfNeeded遍历的不是superview链，应该是subviews链
         为什么会用self，因为会调用layoutSubviews
         */
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }];
}

- (void)changeSubViewFrame {
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(-20);
    }];
}

@end
