//
//  UITableViewCell+LazyInitUIKit.m
//  YouShuLa
//
//  Created by Teen Ma on 2018/12/17.
//  Copyright © 2018 YouShuLa_IOS. All rights reserved.
//

#import "UITableViewCell+LazyInitUIKit.h"

typedef NS_ENUM(NSInteger , UITableViewCellUIType) {
    UITableViewCellUIType_unKnown = 99999,//非UI类型
    UITableViewCellUIType_CustomView,    //自定义view
    UITableViewCellUIType_Label,         //label
    UITableViewCellUIType_view,          //view
    UITableViewCellUIType_button,        //button
    UITableViewCellUIType_textField,     //textField
    UITableViewCellUIType_textView,      //textView
    UITableViewCellUIType_imageView,     //imageView
    UITableViewCellUIType_scrollview     //scrollview
};


@implementation UITableViewCell (LazyInitUIKit)

- (void)lazyInitAllSubViewUIWithAutolayoutEnable:(BOOL)autolayoutEnable
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        Ivar ivar = ivars[i];
        NSString *instanceName = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        NSString *instanceType = [NSString stringWithFormat:@"%s",ivar_getTypeEncoding(ivar)];
        if ((instanceType && instanceType.length > 0) && (instanceName && instanceName.length > 0))
        {
            switch ([self uiTypeWithInstanceType:instanceType])
            {
                case UITableViewCellUIType_Label:
                {
                    UILabel *label = [KitFactory label];
                    if (autolayoutEnable)
                    {
                        label.translatesAutoresizingMaskIntoConstraints = NO;
                    }
                    object_setIvar(self, ivar, label);
                
                }
                    break;
                case UITableViewCellUIType_view:
                {
                    UIView *view = [KitFactory view];
                    if (autolayoutEnable)
                    {
                        view.translatesAutoresizingMaskIntoConstraints = NO;
                    }
                    object_setIvar(self, ivar, view);
                }
                    break;
                case UITableViewCellUIType_button:
                {
                    UIButton *button = [KitFactory button];
                    if (autolayoutEnable)
                    {
                        button.translatesAutoresizingMaskIntoConstraints = NO;
                    }
                    object_setIvar(self, ivar, button);
                }
                    break;
                case UITableViewCellUIType_textField:
                {
                    UITextField *textField = [KitFactory textField];
                    if (autolayoutEnable)
                    {
                        textField.translatesAutoresizingMaskIntoConstraints = NO;
                    }
                    object_setIvar(self, ivar, textField);
                }
                    break;
                case UITableViewCellUIType_textView:
                {
                    UITextView *textView = [KitFactory textView];
                    if (autolayoutEnable)
                    {
                        textView.translatesAutoresizingMaskIntoConstraints = NO;
                    }
                    object_setIvar(self, ivar, textView);
                }
                    break;
                case UITableViewCellUIType_scrollview:
                {
                    UIScrollView *scrollView = [KitFactory scrollView];
                    if (autolayoutEnable)
                    {
                        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
                    }
                    object_setIvar(self, ivar, scrollView);
                }
                    break;
                case UITableViewCellUIType_CustomView:
                {
                    instanceType = [instanceType stringByReplacingOccurrencesOfString:@"@" withString:@""];
                    instanceType = [instanceType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                    Class class = NSClassFromString(instanceType);
                    if (class && [class instancesRespondToSelector:@selector(setTranslatesAutoresizingMaskIntoConstraints:)])
                    {
                        //view
                        id customViewInstance = [[class alloc] initWithFrame:CGRectZero];
                        if (autolayoutEnable)
                        {
                            [customViewInstance setTranslatesAutoresizingMaskIntoConstraints:NO];
                        }
                        object_setIvar(self, ivar, customViewInstance);
                    }
                }
                    break;
                case UITableViewCellUIType_unKnown:
                {
                    //nothing
                }
                    break;
                case UITableViewCellUIType_imageView:
                {
                    UIImageView *imageView = [KitFactory imageView];
                    if (autolayoutEnable)
                    {
                        imageView.translatesAutoresizingMaskIntoConstraints = NO;
                    }
                    object_setIvar(self, ivar, imageView);
                }
                    break;
                default:
                    break;
            }
        }
    }
    free(ivars);
}

- (UITableViewCellUIType)uiTypeWithInstanceType:(NSString *)instanceType
{
    UITableViewCellUIType type = UITableViewCellUIType_unKnown;
    NSString *originInstanceType = instanceType;
    originInstanceType = [originInstanceType stringByReplacingOccurrencesOfString:@"@" withString:@""];
    originInstanceType = [originInstanceType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    if ([originInstanceType isEqualToString:NSStringFromClass([UILabel class])])
    {
        type = UITableViewCellUIType_Label;
    }
    else if ([originInstanceType isEqualToString:NSStringFromClass([UIButton class])])
    {
        type = UITableViewCellUIType_button;
    }
    else if ([originInstanceType isEqualToString:NSStringFromClass([UIView class])])
    {
        type = UITableViewCellUIType_view;
    }
    else if ([originInstanceType isEqualToString:NSStringFromClass([UITextField class])])
    {
        type = UITableViewCellUIType_textField;
    }
    else if ([originInstanceType isEqualToString:NSStringFromClass([UITextView class])])
    {
        type = UITableViewCellUIType_textView;
    }
    else if ([originInstanceType isEqualToString:NSStringFromClass([UIImageView class])])
    {
        type = UITableViewCellUIType_imageView;
    }
    else if ([originInstanceType isEqualToString:NSStringFromClass([UIScrollView class])])
    {
        type = UITableViewCellUIType_scrollview;
    }
    else
    {
        type = UITableViewCellUIType_CustomView;
    }
    
    return type;
}

@end
