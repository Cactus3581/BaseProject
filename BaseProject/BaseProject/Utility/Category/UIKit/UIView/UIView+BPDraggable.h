//
//  UIView+draggable.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BPDraggable)

/**-----------------------------------------------------------------------------
 * @name UIView+draggable Properties
 * -----------------------------------------------------------------------------
 */

/** The pan gestures that handles the view dragging
 bp_panGesture The tint color of the blurred view. Set to nil to reset.
 */
@property (nonatomic) UIPanGestureRecognizer *bp_panGesture;

/**
 A caging area such that the view can not be moved outside
 of this frame.
 
 If @c cagingArea is not @c CGRectZero, and @c cagingArea does not contain the
 view's frame then this does nothing (ie. if the bounds of the view extend the
 bounds of @c cagingArea).
 
 Optional. If not set, defaults to @c CGRectZero, which will result
 in no caging behavior.
 */
@property (nonatomic) CGRect bp_cagingArea;

/**
 Restricts the area of the view where the drag action starts.
 
 Optional. If not set, defaults to self.view.
 */
@property (nonatomic) CGRect bp_handle;

/**
 Restricts the movement along the X axis
 */
@property (nonatomic) BOOL bp_shouldMoveAlongX;

/**
 Restricts the movement along the Y axis
 */
@property (nonatomic) BOOL bp_shouldMoveAlongY;

/**
 Notifies when dragging started
 */
@property (nonatomic, copy) void (^bp_draggingStartedBlock)(void);

/**
 Notifies when dragging ended
 */
@property (nonatomic, copy) void (^bp_draggingEndedBlock)(void);


/**-----------------------------------------------------------------------------
 * @name UIView+draggable Methods
 * -----------------------------------------------------------------------------
 */

/** Enables the dragging
 *
 * Enables the dragging state of the view
 */
- (void)bp_enableDragging;

/** Disable or enable the view dragging
 *
 * @param draggable The boolean that enables or disables the draggable state
 */
- (void)bp_setDraggable:(BOOL)draggable;

@end
