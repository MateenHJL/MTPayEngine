//
//  BaseCollectionViewCell.m
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/24.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import "BaseCollectionViewCell.h"

#define MTBaseViewModel @"MTBaseViewModel"

@implementation BaseCollectionViewCell

- (void)resetCellWithViewModel:(BaseViewModel *)model
{
    [self setBaseViewModel:model];
    
    if (model.unbindCollectionViewCellBlock)
    {
        model.unbindCollectionViewCellBlock(model, self);
    }
    
    if (model.bindCollectionViewCellBlock)
    {
        model.bindCollectionViewCellBlock(model, self);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //默认刷新视图，子类可重写
    [self resetCellWithViewModel:self.baseViewModel];
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

    if (self.baseViewModel.unbindCollectionViewCellBlock)
    {
        self.baseViewModel.unbindCollectionViewCellBlock(self.baseViewModel, self);
    }
}


@end
