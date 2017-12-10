//
//  UITextField+History.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UITextField+JKHistory.h"
#import <objc/runtime.h>

#define bp_history_X(view) (view.frame.origin.x)
#define bp_history_Y(view) (view.frame.origin.y)
#define bp_history_W(view) (view.frame.size.width)
#define bp_history_H(view) (view.frame.size.height)

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryviewIdentifyKey;

#define bp_ANIMATION_DURATION 0.3f
#define bp_ITEM_HEIGHT 40
#define bp_CLEAR_BUTTON_HEIGHT 45
#define bp_MAX_HEIGHT 300


@interface UITextField ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *bp_historyTableView;

@end


@implementation UITextField (JKHistory)

- (NSString*)bp_identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (void)setBp_identify:(NSString *)identify {
    objc_setAssociatedObject(self, &kTextFieldIdentifyKey, identify, OBJC_ASSOCIATION_RETAIN);
}

- (UITableView*)bp_historyTableView {
    UITableView* table = objc_getAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey);
    
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        table.layer.borderColor = [UIColor grayColor].CGColor;
        table.layer.borderWidth = 1;
        table.delegate = self;
        table.dataSource = self;
        objc_setAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey, table, OBJC_ASSOCIATION_RETAIN);
    }
    
    return table;
}

- (NSArray*)bp_loadHistroy {
    if (self.bp_identify == nil) {
        return nil;
    }

    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+JKHistory"];
    
    if (dic != nil) {
        return [dic objectForKey:self.bp_identify];
    }

    return nil;
}

- (void)bp_synchronize {
    if (self.bp_identify == nil || [self.text length] == 0) {
        return;
    }
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+JKHistory"];
    NSArray* history = [dic objectForKey:self.bp_identify];
    
    NSMutableArray* newHistory = [NSMutableArray arrayWithArray:history];
    
    __block BOOL haveSameRecord = false;
    __weak typeof(self) weakSelf = self;
    
    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString*)obj isEqualToString:weakSelf.text]) {
            *stop = true;
            haveSameRecord = true;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [newHistory addObject:self.text];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:newHistory forKey:self.bp_identify];
    
    [def setObject:dic2 forKey:@"UITextField+JKHistory"];
    
    [def synchronize];
}

- (void) bp_showHistory; {
    NSArray* history = [self bp_loadHistroy];
    
    if (self.bp_historyTableView.superview != nil || history == nil || history.count == 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(bp_history_X(self), bp_history_Y(self) + bp_history_H(self) + 1, bp_history_W(self), 1);
    CGRect frame2 = CGRectMake(bp_history_X(self), bp_history_Y(self) + bp_history_H(self) + 1, bp_history_W(self), MIN(bp_MAX_HEIGHT, bp_ITEM_HEIGHT * history.count + bp_CLEAR_BUTTON_HEIGHT));
    
    self.bp_historyTableView.frame = frame1;
    
    [self.superview addSubview:self.bp_historyTableView];
    
    [UIView animateWithDuration:bp_ANIMATION_DURATION animations:^{
        self.bp_historyTableView.frame = frame2;
    }];
}

- (void) bp_clearHistoryButtonClick:(UIButton*) button {
    [self bp_clearHistory];
    [self bp_hideHistroy];
}

- (void)bp_hideHistroy; {
    if (self.bp_historyTableView.superview == nil) {
        return;
    }

    CGRect frame1 = CGRectMake(bp_history_X(self), bp_history_Y(self) + bp_history_H(self) + 1, bp_history_W(self), 1);
    
    [UIView animateWithDuration:bp_ANIMATION_DURATION animations:^{
        self.bp_historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.bp_historyTableView removeFromSuperview];
    }];
}

- (void) bp_clearHistory; {
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:nil forKey:@"UITextField+JKHistory"];
    [def synchronize];
}


#pragma mark tableview datasource
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return [self bp_loadHistroy].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
    }
    
    cell.textLabel.text = [self bp_loadHistroy][indexPath.row];
    
    return cell;
}
#pragma clang diagnostic pop

#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section; {
    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(bp_clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
    return bp_ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return bp_CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    self.text = [self bp_loadHistroy][indexPath.row];
    [self bp_hideHistroy];
}

@end
