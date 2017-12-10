//
//  UISearchBar+BPBlocks.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UISearchBar+BPBlocks.h"
#import <objc/runtime.h>

/* Only for convenience and readabilty in delegate methods */
typedef BOOL (^BP_UISearchBarReturnBlock) (UISearchBar *searchBar);
typedef void (^BP_UISearchBarVoidBlock) (UISearchBar *searchBar);
typedef void (^BP_UISearchBarSearchTextBlock) (UISearchBar *searchBar,NSString *searchText);
typedef BOOL (^BP_UISearchBarInRangeReplacementTextBlock) (UISearchBar *searchBar,NSRange range,NSString *text);
typedef void (^BP_UISearchBarScopeIndexBlock)(UISearchBar *searchBar, NSInteger selectedScope);

@implementation UISearchBar (BPBlocks)


static const void *BP_UISearchBarDelegateKey                                = &BP_UISearchBarDelegateKey;
static const void *BP_UISearchBarShouldBeginEditingKey                      = &BP_UISearchBarShouldBeginEditingKey;
static const void *BP_UISearchBarTextDidBeginEditingKey                     = &BP_UISearchBarTextDidBeginEditingKey;
static const void *BP_UISearchBarShouldEndEditingKey                        = &BP_UISearchBarShouldEndEditingKey;
static const void *BP_UISearchBarTextDidEndEditingKey                       = &BP_UISearchBarTextDidEndEditingKey;
static const void *BP_UISearchBarTextDidChangeKey                           = &BP_UISearchBarTextDidChangeKey;
static const void *BP_UISearchBarShouldChangeTextInRangeKey                 = &BP_UISearchBarShouldChangeTextInRangeKey;
static const void *BP_UISearchBarSearchButtonClickedKey                                = &BP_UISearchBarSearchButtonClickedKey;
static const void *BP_UISearchBarBookmarkButtonClickedKey                                = &BP_UISearchBarBookmarkButtonClickedKey;
static const void *BP_UISearchBarCancelButtonClickedKey                                = &BP_UISearchBarCancelButtonClickedKey;
static const void *BP_UISearchBarResultsListButtonClickedKey                                = &BP_UISearchBarResultsListButtonClickedKey;
static const void *BP_UISearchBarSelectedScopeButtonIndexDidChangeKey                                = &BP_UISearchBarSelectedScopeButtonIndexDidChangeKey;




#pragma mark UISearchBar delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    BP_UISearchBarReturnBlock block = searchBar.bp_completionShouldBeginEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]){
        return [delegate searchBarShouldBeginEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    BP_UISearchBarVoidBlock block = searchBar.bp_completionTextDidBeginEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    BP_UISearchBarReturnBlock block = searchBar.bp_completionShouldEndEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        return [delegate searchBarShouldEndEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   BP_UISearchBarVoidBlock block = searchBar.bp_completionTextDidEndEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    BP_UISearchBarSearchTextBlock block = searchBar.bp_completionTextDidChangeBlock;
    if (block) {
        block(searchBar,searchText);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textDidChange:)]){
        [delegate searchBar:searchBar textDidChange:searchText];
    }
}
// called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BP_UISearchBarInRangeReplacementTextBlock block = searchBar.bp_completionShouldChangeTextInRangeBlock;
    if (block) {
        return block(searchBar,range,text);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]){
        return [delegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    BP_UISearchBarVoidBlock block = searchBar.bp_completionSearchButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [delegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    BP_UISearchBarVoidBlock block = searchBar.bp_completionBookmarkButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]){
        [delegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    BP_UISearchBarVoidBlock block = searchBar.bp_completionCancelButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]){
        [delegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    BP_UISearchBarVoidBlock block = searchBar.bp_completionResultsListButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]){
        [delegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    BP_UISearchBarScopeIndexBlock block = searchBar.bp_completionSelectedScopeButtonIndexDidChangeBlock;
    if (block) {
        block(searchBar,selectedScope);
    }
    id delegate = objc_getAssociatedObject(self, BP_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]){
        [delegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}


#pragma mark Block setting/getting methods
- (BOOL (^)(UISearchBar *))bp_completionShouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarShouldBeginEditingKey);
}

- (void)setBp_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldBeginEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarShouldBeginEditingKey, searchBarShouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))bp_completionTextDidBeginEditingBlock
{
    return objc_getAssociatedObject(self,BP_UISearchBarTextDidBeginEditingKey);
}

- (void)setBp_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *))searchBarTextDidBeginEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarTextDidBeginEditingKey, searchBarTextDidBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *))bp_completionShouldEndEditingBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarShouldEndEditingKey);
}

- (void)setBp_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldEndEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarShouldEndEditingKey, searchBarShouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))bp_completionTextDidEndEditingBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarTextDidEndEditingKey);
}

- (void)setBp_completionTextDidEndEditingBlock:(void (^)(UISearchBar *))searchBarTextDidEndEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarTextDidEndEditingKey, searchBarTextDidEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSString *))bp_completionTextDidChangeBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarTextDidChangeKey);
}

- (void)setBp_completionTextDidChangeBlock:(void (^)(UISearchBar *, NSString *))searchBarTextDidChangeBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarTextDidChangeKey, searchBarTextDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *, NSRange, NSString *))bp_completionShouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarShouldChangeTextInRangeKey);
}

- (void)setBp_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *, NSRange, NSString *))searchBarShouldChangeTextInRangeBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarShouldChangeTextInRangeKey, searchBarShouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))bp_completionSearchButtonClickedBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarSearchButtonClickedKey);
}

- (void)setBp_completionSearchButtonClickedBlock:(void (^)(UISearchBar *))searchBarSearchButtonClickedBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarSearchButtonClickedKey, searchBarSearchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))bp_completionBookmarkButtonClickedBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarBookmarkButtonClickedKey);
}

- (void)setBp_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *))searchBarBookmarkButtonClickedBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarBookmarkButtonClickedKey, searchBarBookmarkButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))bp_completionCancelButtonClickedBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarCancelButtonClickedKey);
}

- (void)setBp_completionCancelButtonClickedBlock:(void (^)(UISearchBar *))searchBarCancelButtonClickedBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarCancelButtonClickedKey, searchBarCancelButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))bp_completionResultsListButtonClickedBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarResultsListButtonClickedKey);
}

- (void)setBp_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *))searchBarResultsListButtonClickedBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarResultsListButtonClickedKey, searchBarResultsListButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSInteger))bp_completionSelectedScopeButtonIndexDidChangeBlock
{
    return objc_getAssociatedObject(self, BP_UISearchBarSelectedScopeButtonIndexDidChangeKey);
}

- (void)setBp_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *, NSInteger))searchBarSelectedScopeButtonIndexDidChangeBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BP_UISearchBarSelectedScopeButtonIndexDidChangeKey, searchBarSelectedScopeButtonIndexDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void)bp_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UISearchBarDelegate>)self) {
        objc_setAssociatedObject(self, BP_UISearchBarDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UISearchBarDelegate>)self;
    }
}

@end
