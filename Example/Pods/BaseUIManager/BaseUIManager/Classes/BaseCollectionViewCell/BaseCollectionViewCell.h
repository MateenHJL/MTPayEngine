//
//  BaseCollectionViewCell.h
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/24.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFile.h"

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) id delegate;

- (void)resetCellWithViewModel:(BaseViewModel *)model;

@end
