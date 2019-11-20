//
//  NSObject+BPSwizzling.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/10/25.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "NSObject+BPSwizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (BPSwizzling)


+ (void)bp_swizzleInstanceMethodWithClass:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
        
    /* 前提：存在父子类、父类声明并实现了一个方法、子类没有重写/实现该方法、子类要hook这个定义于父类的方法、子类实现swiizling方法 */

    
    /*

    hook或者说method swizzling就是将两个方法的imp相互交换：a:A b:B -> a:B,b:A，hook之后，原来的方法对应新方法的实现，新方法对应着原来方法的实现；
问题1:不可只交换一个，比如a:B,b:B，如果只将原始方法的实现指向了hook方法的imp，hook方法的imp依然指向自身，那么就无论如何都拿不到原来的实现，这对于调用原来的实现是不理想的。所以不能只更改一个映射，要交叉更改映射关系;
     
问题2:一般来说hook只需要一个交换方法，该方法用来直接交换两个目标方法的imp，这两个目标方法分别为原始方法和即将hook的方法。但是如果当前类的方法列表没有实现/重写该原始方法，说明当前类的方法列表里面没有该原始方法，然后通过class_getInstanceMethod函数拿到的方法对象可能是属于父类的，存在于父类的方法列表里，如果在这样的情况下直接交换，会导致存在于父类方法列表中的原始方法指向了只属于当前类（子类）的swizMethod的imp上，一旦父类对象调用原始方法，因为该方法属于子类，父类对象会因为找不到该方法实现而发生crash。解决思路是：无论如何不能更改当前类的父类的方法列表，所以就必须给当前类的方法列表添加一个方法，这样操作的方法列表只会是当前类的方法列表，不会导致因为找不到实现而导致的crash。当然如果方法本身存在于当前类（比如子类重写了该方法）就可以直接交换，不存在这个问题。
     
     */

    
    /*
     class_getInstanceMethod 会走继承链，如果在本类找不到，会去父类查找，所以拿到的method不一定是当前类自身的，也有可能是父类的，所以IMP也不一定是当前类本身的
     */
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    
    /*
     class_addMethod：给指定的类添加sel、imp、types，只会作用于该类，不会作用于父类，class_replaceMethod也是这样的；
     下面这句代码意思是：给该类的方法列表里添加一个方法，该方法的sel为原始的方法名，imp为swiz方法的imp；
     如果该方法的imp为空或者说该类的方法列表里没有该方法，即子类没有实现/重写该方法，就可以添加成功，否则添加不成功，比如说；
     使用该方法为了避免问题2：如果不这样写直接交换，会修改父类方法的imp指向子类的imp，因为找不到实现而导致的crash。如果方法本身存在就可以省略这一步，这样操作的都是当前类的方法列表

     给当前类的方法列表添加方法的具体方案：添加的方法依然使用原始的方法名，imp可以是父类对应sel的imp，也可以是swizMethod的imp，这两种不同的解决方案，会导致后面使用的函数不一样。
              
     */
    
    // 方案1：imp改为swizMethod的imp
    
    /* 向当前类的方法列表添加一个方法：方法名为原始方法的sel，imp实现为swizMethod方法的实现 */
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    
    if (didAddMethod) {
        // 说明当前类没有实现该原始方法，即当前类的方法列表没有该方法。
        // class_addMethod函数已经将原始方法的实现指向为swizMethod的实现，所以需要这一步将swizMethod的实现改为原始方法的实现
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //添加失败：说明当前类的方法列表中有该方法。 直接将两个方法的实现交换
        method_exchangeImplementations(origMethod, swizMethod);
    }
    
    
//        // 方案2：imp改为父类对应sel的imp
//
//        /* 向当前类的方法列表添加一个方法：方法名为原始方法的sel，imp为父类对应方法的实现 */
//        BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
//        /* 通过上面的方法，当前类的方法列表中已经有该方法，最后将两个方法的实现交换 */
//        method_exchangeImplementations(class_getInstanceMethod(class, origSel), swizMethod);
        
}

+ (void)bp_swizzleDelegateMethodWithOrigClass:(Class)origClass origSelector:(SEL)origSel swizClass:(Class)swizClass swizSelector:(SEL)swizSel placedSelector:(SEL)placedSel {
    
    Method origMethod = class_getInstanceMethod(origClass, origSel);
    Method swizMethod = class_getInstanceMethod(swizClass, swizSel);
    
    // 如果没有实现 delegate 方法，则手动动态添加
    if (!origMethod) {
        Method placedMethod = class_getInstanceMethod(swizClass, placedSel);
        BOOL addMethod = class_addMethod(origClass, origSel, method_getImplementation(placedMethod), method_getTypeEncoding(placedMethod));
        if (addMethod) {
            NSLog(@"没有实现 (%@) 方法，手动添加成功",NSStringFromSelector(origSel));
        }
        return;
    }
    
    // 向实现 delegate 的类中添加新的方法
    BOOL addMethod = class_addMethod(origClass, swizSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (addMethod) {
        // 添加成功
        // 重新拿到添加被添加的 method,这里是关键(注意这里 origClass, 不 swizClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
        Method newMethod = class_getInstanceMethod(origClass, swizSel);
        method_exchangeImplementations(origMethod, newMethod);
    }else{
        // 添加失败，则说明已经 hook 过该类的 delegate 方法，防止多次交换。
        // 也可以使用静态数组的方式，防止 setDelegate 方法被调用多次，导致代理方法又被换掉
    }
}
    
@end
