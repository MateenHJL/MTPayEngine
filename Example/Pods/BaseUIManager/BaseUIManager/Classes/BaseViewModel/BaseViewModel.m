//
//  BaseViewModel.m
//  Express_ios
//
//  Created by Mateen on 16/3/28.
//  Copyright © 2016年 MaTeen. All rights reserved.
//

#import "BaseViewModel.h" 

@interface BaseViewModel ()

@property (nonatomic, strong  ) NSMutableArray *keyPaths;

@end

@implementation BaseViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        self.cellLineViewModel = [[BaseCellLineViewModel alloc] init];
        self.currentCellHeight = 0.0;
        _cellIndentifier = @"";
        self.cellBackgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setCellClass:(id)cellClass
{
    if (cellClass)
    {
        _cellClass = cellClass;
        _cellIndentifier = NSStringFromClass([cellClass class]);
    }
}

- (NSMutableArray *)subViewModelArray
{
    return nil;
}

- (NSMutableArray *)keyPaths
{
    if (!_keyPaths)
    {
        _keyPaths = [NSMutableArray array];
    }
    return _keyPaths;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (self.observerKeyPathChangedBlock)
    {
        self.observerKeyPathChangedBlock(self, keyPath, object);
    }
}

- (void)dealloc
{
    
}

@end
