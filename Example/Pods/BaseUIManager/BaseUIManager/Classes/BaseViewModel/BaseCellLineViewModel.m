//
//  BaseCellLineViewModel.m
//  MTTemplate
//
//  Created by Teen Ma on 16/11/10.
//  Copyright © 2016年 Teen Ma. All rights reserved.
//

#import "BaseCellLineViewModel.h"
 
//define Something for CellLineViewModel
#define kLineHeight 1
#define kLineColor rgba(0, 0, 0, 0.04)

@implementation BaseCellLineViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        _showTopLine = NO;
        _showBottomLine = NO;
        _topLineEdgeInsets = UIEdgeInsetsZero;
        _bottomLineEdgeInsets = UIEdgeInsetsZero;
        _topLineColor = kLineColor;
        _bottomLineColor = kLineColor;
        self.topLineHeight = kLineHeight;
        self.bottomLineHeight = kLineHeight;
    }
    return self;
}

- (void)setTopLineEdgeInsets:(UIEdgeInsets)topLineEdgeInsets
{
    _topLineEdgeInsets = topLineEdgeInsets;
    _showTopLine = YES;
}

- (void)setBottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdgeInsets
{
    _bottomLineEdgeInsets = bottomLineEdgeInsets;
    _showBottomLine = YES;
}

@end
