//
//  KitFactory.h
//  Express_ios
//
//  Created by Mateen on 16/3/28.
//  Copyright © 2016年 MaTeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonFile.h"

@class WebImageView;

@interface KitFactory : NSObject

+ (UICollectionViewFlowLayout *)collectionViewfLowLayout;

+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewFlowLayout *)layout;

+ (UIView *)view;

+ (UILabel *)label;

+ (UIButton *)button;

+ (UITextField *)textField;

+ (UITextView *)textView;

+ (UIImageView *)imageView;

+ (UITableView *)tableView;

+ (UIScrollView *)scrollView;

@end
