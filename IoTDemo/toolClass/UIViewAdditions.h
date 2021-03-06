#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "UIView+DKSBadge.h"
typedef NS_ENUM(NSInteger, UIViewBorderLineType) {
    UIViewBorderLineTypeTop,
    UIViewBorderLineTypeRight,
    UIViewBorderLineTypeBottom,
    UIViewBorderLineTypeLeft,
};
typedef void(^ActionBlock)(id sender);
@interface UIView (KNCategory)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;
/**
 * ????????????
 */
-(void)roundSize:(CGFloat )round;
/**
 * ????????????
 */
-(void)roundSize:(CGFloat)round andCorner:(UIRectCorner)corners;
/**
 * ????????????
 */
-(void)roundSize:(CGFloat)round color:(UIColor*)color;

/**
 ????????????
 
 @param color ??????
 @param width ??????
 */
- (void)setBorder:(UIColor *)color width:(CGFloat)width;
/**
 * ??????????????????
 */
-(void)setDottedLineWithRoundSize:(CGFloat)round color:(UIColor *)color;

@property (nonatomic,readonly) NSArray * allSubviews;
/**
 * ????????????
 */
-(void)setViewBorder:(UIView *)view color:(UIColor *)color border:(float)border type:(UIViewBorderLineType)borderLineType;
-(void)setViewBorder:(UIView *)view color:(UIColor *)color border:(float)border type:(UIViewBorderLineType)borderLineType setX:(CGFloat)setX;
/**
 * ??????????????????
 */
-(void)handleTapGestureRecognizerEventWithBlock:(ActionBlock)action;
-(void)handleLongGestureRecognizerEventWithBlock:(ActionBlock)action;
/**
 * ???View???????????????
 */
-(void)setViewColors:(NSArray *)colors withDirection:(NSInteger)direction;
/**
 * ??????????????????
 */
-(void)setTextColors:(NSArray *)colors withDirection:(NSInteger)direction;

- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;

/**
 * ??????View
 */
- (UIView*)subViewOfClassName:(NSString*)className;
/**
 * ???????????????????????????
 */
- (void)shakeAnimation;
@end
