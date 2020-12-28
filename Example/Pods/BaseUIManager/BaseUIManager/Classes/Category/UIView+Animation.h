//
//  UIView+Animation.h
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/10.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class POPAnimation;

typedef void(^animationDidEnd)(POPAnimation *animation, BOOL isFinished);

@interface UIView (Animation)

@property (nonatomic, assign  ) CGFloat alphaValue;

@property (nonatomic, assign  ) CGPoint pointValue;

@property (nonatomic, assign  ) CGSize  sizeValue;

@property (nonatomic, assign  ) CGRect  rectValue;

//渐显
- (void)animationWithFadeCompletedUsing:(animationDidEnd)animationBlock;

//改变位置
- (void)animationWithPointCompletedUsing:(animationDidEnd)animationBlock;

//改变大小
- (void)animationWithSizeCompletedUsing:(animationDidEnd)animationBlock;

//既改变位置又改变大小
- (void)animationWithRectCompletedUsing:(animationDidEnd)animationBlock;

@end
