//
//  KitFactory.m
//  Express_ios
//
//  Created by Mateen on 16/3/28.
//  Copyright © 2016年 MaTeen. All rights reserved.
//

#import "KitFactory.h"

#define kDefaultTextColor rgb(51, 51, 51)
#define kDefaultFontSize [UIFont adjustFontFromFontSize:14]
#define kDefaultBackgroundColor [UIColor clearColor]
#define kDefaultHighTextColor rgb(51, 51, 51)

@interface KitFactory ()

@end

@implementation KitFactory

+ (UILabel *)label
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = kDefaultBackgroundColor;
    label.font = [UIFont systemFontOfSize:kDefaultFontSize];
    label.textColor = kDefaultTextColor;
    return label;
}

+ (UIButton *)button
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = kDefaultBackgroundColor;
    [button setTitleColor:kDefaultTextColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kDefaultFontSize];
    [button setTitleColor:kDefaultHighTextColor forState:UIControlStateHighlighted];
    return button;
}

+ (UIImageView *)imageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = kDefaultBackgroundColor;
    return imageView;
}

+ (UIView *)view
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kDefaultBackgroundColor;
    return view;
}

+ (UITextField *)textField
{
    UITextField *textField = [[UITextField alloc]init];
    textField.backgroundColor = kDefaultBackgroundColor;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.spellCheckingType = UITextAutocorrectionTypeNo;
    textField.font = [UIFont systemFontOfSize:kDefaultFontSize];
    textField.enablesReturnKeyAutomatically = YES;
    textField.textColor = kDefaultTextColor;
    textField.keyboardType = UIKeyboardTypeDefault;
    return textField;
}

+ (UITextView *)textView
{
    UITextView *textView = [[UITextView alloc]init];
    textView.backgroundColor = kDefaultBackgroundColor;
    textView.font = [UIFont systemFontOfSize:kDefaultFontSize];
    textView.textColor = kDefaultTextColor;
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.returnKeyType = UIReturnKeyDone;
    return textView;
}

+ (UITableView *)tableView
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.separatorColor = [UIColor clearColor];
    table.separatorInset = UIEdgeInsetsZero;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundView = [[UIView alloc]init];
    table.backgroundColor = [UIColor clearColor];
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *))
    {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    table.estimatedRowHeight = 0;
    table.estimatedSectionFooterHeight = 0;
    table.estimatedSectionHeaderHeight = 0;
    return table;
}

+ (UIScrollView *)scrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *))
    {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return scrollView;
}

+ (UICollectionView *)collectionViewWithLayout:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    return collectionView;
}

+ (UICollectionViewFlowLayout *)collectionViewfLowLayout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    return flowLayout;
}

@end
