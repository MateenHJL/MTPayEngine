//
//  BaseViewModel.h
//  Express_ios
//
//  Created by Mateen on 16/3/28.
//  Copyright © 2016年 MaTeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonFile.h"

@class BaseCellLineViewModel;
@class BaseView;
@class BaseCollectionViewCell; 
@class BaseTableViewCell;

typedef NS_ENUM(NSInteger , BaseViewModelKVOUIType) {
    BaseViewModelKVOUIType_Cell,//BaseTableviewCell
    BaseViewModelKVOUIType_View,//BaseView
    BaseViewModelKVOUIType_CollectionCell//BaseCollectionViewCell
};

typedef void(^valueHasBeenModifiedBlock)(id viewModel , id object);

@interface BaseViewModel : NSObject

//the line in cell ViewModel,you can set up the line attributed,such as lineColor、lineHeight、position of line; 
@property (nonatomic,strong  ) BaseCellLineViewModel *cellLineViewModel;

//the origin dataModel
@property (nonatomic,strong  ) id dataModel;

//the backgroundColor of tableviewCell.
@property (nonatomic,strong  ) UIColor *cellBackgroundColor;

//the className of tableviewCell.
@property (nonatomic,strong  ) id cellClass;

//the height of tableviewcellHeight,default is define cellDefaultHeight(44).
@property (nonatomic,assign  ) CGFloat currentCellHeight;

//cell indetifier
@property (nonatomic,readonly) NSString *cellIndentifier;

//cellType
@property (nonatomic,assign  ) NSInteger cellType;

//superViewModel
@property (nonatomic,strong  ) BaseViewModel *superViewModel;

//subviewModel
@property (nonatomic,strong  ) NSMutableArray *subViewModelArray;

//bind TabelviewCellBlock
@property (nonatomic,copy    ) void(^bindCellBlock)(id originViewModel, BaseTableViewCell *cell);

//unbind TableviewCellBlock
@property (nonatomic,copy    ) void(^unbindCellBlock)(id originViewModel, BaseTableViewCell *cell);
 
//bind UIViewBlock
@property (nonatomic,copy    ) void(^bindViewBlock)(id originViewModel, BaseView *view);

//unbind TableviewCellBlock
@property (nonatomic,copy    ) void(^unbindViewBlock)(id originViewModel, BaseView *view);
 
//bind CollectionViewCellBlock
@property (nonatomic,copy    ) void(^bindCollectionViewCellBlock)(id originViewModel, BaseCollectionViewCell *collectionViewCell);

//unbind CollectionViewCellBlock
@property (nonatomic,copy    ) void(^unbindCollectionViewCellBlock)(id originViewModel, BaseCollectionViewCell *collectionViewCell);

//unbind TableviewCellBlock
@property (nonatomic,copy    ) void(^observerKeyPathChangedBlock)(id viewModel, NSString *keyPath, id object);

@end
