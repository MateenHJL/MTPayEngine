//
//  BaseView.m
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/10.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import "BaseView.h" 

#define MTBaseViewModel @"MTBaseViewModel"

@interface BaseView ()

@property (nonatomic,copy    ) animationDidEndBlock animationDidEndBlock;
@property (nonatomic,strong  ) UIImageView   *topLine;
@property (nonatomic,strong  ) UIImageView   *bottomLine;

@end

@implementation BaseView

@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.animationType = BASEVIEWANIMATIONTYPE_FADE;
        
        [self setupLine];
    }
    return self;
}

- (void)setupLine
{
    self.topLine.hidden = YES;
    [self addSubview:self.topLine];
    
    self.bottomLine.hidden = YES;
    [self addSubview:self.bottomLine];
}

- (void)refreshViewAttributedAnimationWithCompletedBlock:(animationDidEndBlock)block
{
    _animationDidEndBlock = block;
    [self hiddenViewWithAnimation:self.animationType];
}

- (void)hiddenViewWithAnimation:(BASEVIEWANIMATIONTYPE)type
{
    switch (type)
    {
        case BASEVIEWANIMATIONTYPE_FADE:
        {
            [self animationWithFadeCompletedUsing:^(POPAnimation *animation, BOOL isFinished) {
                if (self.animationDidEndBlock)
                {
                    self.animationDidEndBlock (animation, isFinished);
                }
            }];
        }
            break;
        case BASEVIEWANIMATIONTYPE_POINT:
        {
            [self animationWithPointCompletedUsing:^(POPAnimation *animation, BOOL isFinished) {
                if (self.animationDidEndBlock)
                {
                    self.animationDidEndBlock (animation, isFinished);
                }
            }];
        }
            break;
        case BASEVIEWANIMATIONTYPE_SIZE:
        {
            [self animationWithSizeCompletedUsing:^(POPAnimation *animation, BOOL isFinished) {
                if (self.animationDidEndBlock)
                {
                    self.animationDidEndBlock (animation, isFinished);
                }
            }];
        }
            break;
        case BASEVIEWANIMATIONTYPE_RECT:
        {
            [self animationWithRectCompletedUsing:^(POPAnimation *animation, BOOL isFinished) {
                if (self.animationDidEndBlock)
                {
                    self.animationDidEndBlock (animation, isFinished);
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark lazyInit
- (UIImageView *)topLine
{
    if (!_topLine)
    {
        _topLine = [[UIImageView alloc] init];
    }
    return _topLine;
}

- (UIImageView *)bottomLine
{
    if (!_bottomLine)
    {
        _bottomLine = [[UIImageView alloc] init];
    }
    return _bottomLine;
}

- (void)resetViewWithViewModel:(BaseViewModel *)model
{
    [self setBaseViewModel:model];
    
    self.topLine.backgroundColor = model.cellLineViewModel.topLineColor;
    self.bottomLine.backgroundColor = model.cellLineViewModel.bottomLineColor;
 
    if (model.unbindViewBlock)
    {
        model.unbindViewBlock(model, self);
    }
    
    if (model.bindViewBlock)
    {
        model.bindViewBlock(model, self);
    }
}

- (void)setBaseViewModel:(BaseViewModel *)model
{
    if (model)
    {
        objc_setAssociatedObject(self, MTBaseViewModel, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (BaseViewModel *)baseViewModel
{
    BaseViewModel *model = objc_getAssociatedObject(self, MTBaseViewModel);
    return model ? model: nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //默认刷新视图，子类可重写
    [self resetViewWithViewModel:self.baseViewModel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHieght = [UIScreen mainScreen].bounds.size.height;
    self.topLine.hidden = !self.baseViewModel.cellLineViewModel.isShowTopLine;
    self.bottomLine.hidden = !self.baseViewModel.cellLineViewModel.isShowBottomLine;
    
    if (!self.topLine.hidden)
    {
        UIEdgeInsets topInset = self.baseViewModel.cellLineViewModel.topLineEdgeInsets;
        self.topLine.frame = CGRectMake(topInset.left, 0, screenWidth - topInset.left - topInset.right, self.baseViewModel.cellLineViewModel.topLineHeight);
    }
    
    if (!self.bottomLine.hidden)
    {
        UIEdgeInsets bottomInset = self.baseViewModel.cellLineViewModel.bottomLineEdgeInsets;
        self.bottomLine.frame = CGRectMake(bottomInset.left, screenHieght - self.baseViewModel.cellLineViewModel.bottomLineHeight, screenWidth - bottomInset.left - bottomInset.right, self.baseViewModel.cellLineViewModel.bottomLineHeight);
    }
    
    if ([self.topLine isDescendantOfView:self])
    {
        [self bringSubviewToFront:self.topLine];
    }
    
    if ([self.bottomLine isDescendantOfView:self])
    {
        [self bringSubviewToFront:self.bottomLine];
    }
}

- (void)dealloc
{
    if ([self.baseViewModel isKindOfClass:[BaseViewModel class]])
    {
        //如果是viewModel 才会去自动移除
        if (self.baseViewModel.unbindViewBlock)
        {
            self.baseViewModel.unbindViewBlock(self.baseViewModel, self);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
