//
//  UIView+Animation.m
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/10.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import "UIView+Animation.h"
#import "CommonFile.h"

#define kAlphaValue @"kAlphaValue"
#define kPointValue @"kPointValue"
#define kSizeValue  @"kSizeValue"
#define kRectValue  @"kRectValue"

#define kAlpha @"kAlpha"
#define kPoint @"kPoint"
#define kSize  @"kSize"
#define kRect  @"kRect"

#define kDuration 0.4

@implementation UIView (Animation)

//渐变
- (void)animationWithFadeCompletedUsing:(animationDidEnd)animationBlock
{
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.duration = kDuration;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.toValue = @(self.alphaValue);
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (animationBlock)
        {
            animationBlock (anim , finished);
        }
    };
    [self pop_addAnimation:anim forKey:kAlpha];
}

- (void)animationWithPointCompletedUsing:(animationDidEnd)animationBlock
{   
    POPSpringAnimation *basicAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.pointValue.x, self.pointValue.y, self.frame.size.width, self.frame.size.height)];
//    basicAnimation.springSpeed = 20;
//    basicAnimation.dynamicsMass = 1;
//    basicAnimation.springBounciness = 3;
    basicAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (animationBlock)
        {
            animationBlock (anim , finished);
        }
    };
    [self.layer pop_addAnimation:basicAnimation forKey:kPoint];
}

- (void)animationWithSizeCompletedUsing:(animationDidEnd)animationBlock
{
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
    basicAnimation.toValue = [NSValue valueWithCGSize:self.sizeValue];
    basicAnimation.duration = kDuration;
    basicAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (animationBlock)
        {
            animationBlock (anim , finished);
        }
    };
    [self pop_addAnimation:basicAnimation forKey:kSize];
}

- (void)animationWithRectCompletedUsing:(animationDidEnd)animationBlock
{
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    basicAnimation.toValue = [NSValue valueWithCGRect:self.rectValue];
    basicAnimation.duration = kDuration;
    basicAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (animationBlock)
        {
            animationBlock (anim , finished);
        }
    };
    [self pop_addAnimation:basicAnimation forKey:kRect];
}

#pragma mark Getter、Setter
- (CGFloat)alphaValue
{
    NSString *alpha = objc_getAssociatedObject(self, kAlphaValue);
    return [alpha doubleValue];
}

- (void)setAlphaValue:(CGFloat)alphaValue
{
    objc_setAssociatedObject(self, kAlphaValue, [NSString stringWithFormat:@"%lf",alphaValue], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)pointValue
{
    NSString *point = objc_getAssociatedObject(self, kPointValue);
    return CGPointFromString(point);
}

- (void)setPointValue:(CGPoint)pointValue
{
    objc_setAssociatedObject(self, kPointValue, NSStringFromCGPoint(pointValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)sizeValue
{
    NSString *size = objc_getAssociatedObject(self, kSizeValue);
    return CGSizeFromString(size);
}

- (void)setSizeValue:(CGSize)sizeValue
{
    objc_setAssociatedObject(self, kSizeValue, NSStringFromCGSize(sizeValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)rectValue
{
    NSString *rect = objc_getAssociatedObject(self, kRectValue);
    return CGRectFromString(rect);
}

- (void)setRectValue:(CGRect)rectValue
{
    objc_setAssociatedObject(self, kRectValue, NSStringFromCGRect(rectValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
