//
//  ButtonViewModel.h
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/7.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import <BaseUIManager/BaseViewModel.h>

@interface ButtonViewModel : BaseViewModel

@property (nonatomic, strong  ) UIFont   *font;
@property (nonatomic, copy    ) NSString *buttonText;
@property (nonatomic, strong  ) UIColor  *buttonTextColor;
@property (nonatomic, strong  ) UIImage  *buttonImage;
@property (nonatomic, assign  ) SEL      buttonSelector;

@end
