//
//  ButtonViewModel.m
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/7.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import "ButtonViewModel.h"

@implementation ButtonViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        self.buttonText = @"";
        self.buttonTextColor = rgb(73, 97 , 172);
        self.font       = [UIFont systemFontOfSize:[UIFont adjustFontFromFontSize:16]];
    }
    return self;
}

@end
