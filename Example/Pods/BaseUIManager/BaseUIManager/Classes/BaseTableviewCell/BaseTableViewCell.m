//
//  BaseTableViewCell.m
//  Express_ios
//
//  Created by Mateen on 16/3/28.
//  Copyright © 2016年 MaTeen. All rights reserved.
//

#import "BaseTableViewCell.h"

#define MTBaseViewModel @"MTBaseViewModel"

@interface BaseTableViewCell ()
 
@property (nonatomic,strong) UIImageView *topLine;
@property (nonatomic,strong) UIImageView *bottomLine;

@end

@implementation BaseTableViewCell

@synthesize delegate = _delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self setupLine];
    }
    return self;
}

- (void)setupLine
{
    self.topLine.hidden = YES;
    [self.contentView addSubview:self.topLine];
    
    self.bottomLine.hidden = YES;
    [self.contentView addSubview:self.bottomLine];
}

- (void)resetCellWithViewModel:(BaseViewModel *)model
{
    [self setBaseViewModel:model];
    self.topLine.backgroundColor = model.cellLineViewModel.topLineColor;
    self.bottomLine.backgroundColor = model.cellLineViewModel.bottomLineColor;

    if (model.unbindCellBlock)
    {
        model.unbindCellBlock(model, self);
    }
    
    if (model.bindCellBlock)
    {
        model.bindCellBlock(model, self);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    float screenWidth = self.contentView.bounds.size.width;
    float screenHieght = self.contentView.bounds.size.height;
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
    
    if ([self.topLine isDescendantOfView:self.contentView])
    {
        [self.contentView bringSubviewToFront:self.topLine];
    }
    
    if ([self.bottomLine isDescendantOfView:self.contentView])
    {
        [self.contentView bringSubviewToFront:self.bottomLine];
    }
}

+ (CGFloat)currentCellHeightWithViewModel:(BaseViewModel *)model
{
    return 0.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.baseViewModel.unbindCellBlock)
    {
        self.baseViewModel.unbindCellBlock(self.baseViewModel, self);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //默认刷新视图，子类可重写
    [self resetCellWithViewModel:self.baseViewModel];
}

@end
