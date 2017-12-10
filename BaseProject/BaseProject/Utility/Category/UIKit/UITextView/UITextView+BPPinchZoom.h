//
//  UITextView+PinchZoom.h
//
//  Created by Stan Serebryakov <cfr@gmx.us> on 04.12.12.
//
//  Based on Aral Balkan snippet.

// https://github.com/cfr/UITextView-PinchZoom
//  Simple pinch-zoom category for UITextView

/*
 UITextView *textView = [[UITextView alloc] initWithFrame:self.view.frame];
 [self.view addSubview:textView];
 textView.zoomEnabled = YES;
 textView.minFontSize = 10;
 textView.maxFontSize = 40;
*/
#import <UIKit/UIKit.h>

@interface UITextView (BPPinchZoom)

@property (nonatomic) CGFloat bp_maxFontSize, bp_minFontSize;

@property (nonatomic, getter = isBp_zoomEnabled) BOOL bp_zoomEnabled;

@end
