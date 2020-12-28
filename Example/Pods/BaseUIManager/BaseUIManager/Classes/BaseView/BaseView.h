//
//  BaseView.h
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/10.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFile.h"

typedef void(^animationDidEndBlock)(POPAnimation *animation, BOOL isFinished);

typedef NS_ENUM(NSInteger , BASEVIEWANIMATIONTYPE) {
    BASEVIEWANIMATIONTYPE_FADE,//渐变
    BASEVIEWANIMATIONTYPE_POINT,//改变位置
    BASEVIEWANIMATIONTYPE_SIZE,//改变大小
    BASEVIEWANIMATIONTYPE_RECT//改变大小、位置
};

@class BaseViewModel;

@interface BaseView : UIView

@property (nonatomic,weak  ) id                    delegate;

@property (nonatomic,assign) BASEVIEWANIMATIONTYPE animationType;

- (void)refreshViewAttributedAnimationWithCompletedBlock:(animationDidEndBlock)block;

- (void)resetViewWithViewModel:(BaseViewModel *)viewModel;

@end
