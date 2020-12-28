//
//  BaseController.m
//  ToolsApplication
//
//  Created by Mateen on 14/10/30.
//  Copyright (c) 2014年 Mateen. All rights reserved.
//

#import "BaseViewController.h"
#import "ButtonViewModel.h"
#import <HttpEngine/HttpEngine.h>
#import "BaseViewControllerConfigManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize statusBarStyle = _statusBarStyle;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.shouldHiddenNavigationBar = NO;
        
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return self;
}

- (UIStatusBarStyle)statusBarStyle
{
    return _statusBarStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark life cycle
- (void)viewWillAppear:(BOOL)animated
{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[BaseViewControllerConfigManager shareHttpConfigManager].config.defaultNavigationTextColor,NSFontAttributeName:[BaseViewControllerConfigManager shareHttpConfigManager].config.defaultNavigationTitleFont}];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self preferredStatusBarStyle];
    self.statusBarStyle = UIStatusBarStyleDefault;
    self.statusBarBackgroundColor = [BaseViewControllerConfigManager shareHttpConfigManager].config.defaultStatusBarBackgroundColor;
    self.view.backgroundColor = [BaseViewControllerConfigManager shareHttpConfigManager].config.defaultViewBackground;
    self.shouldShowBackButton = YES;
}

- (void)setStatusBarBackgroundColor:(UIColor *)statusBarBackgroundColor
{
    if (@available(iOS 13.0, *))
    {
        UIView *view = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
        view.backgroundColor = statusBarBackgroundColor;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
    else
    {
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
        {
            statusBar.backgroundColor = statusBarBackgroundColor;
        }
    }
}

- (void)setShouldShowBackButton:(BOOL)shouldShowBackButton
{
    _shouldShowBackButton = shouldShowBackButton;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    if (shouldShowBackButton && ( VCCount > 1 || self.navigationController.presentingViewController != nil))
    {
        ButtonViewModel *buttonViewModel = [[ButtonViewModel alloc] init];
        buttonViewModel.buttonImage = [BaseViewControllerConfigManager shareHttpConfigManager].config.defaultBackIcon;
        buttonViewModel.buttonSelector = NSSelectorFromString(@"baseControllerClickLeftButton:");
        NSArray *buttonArray = @[buttonViewModel];
        [self createLeftNavigationItemWithButtonViewModels:buttonArray target:self];
    }
    else
    {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar = [[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}

- (void)createLeftNavigationItemWithButtonViewModels:(NSArray<ButtonViewModel *> *)buttonViewModelArray target:(id)target
{
    if (buttonViewModelArray && buttonViewModelArray.count > 0)
    {
        self.navigationItem.leftBarButtonItems = nil;
        
        NSMutableArray * items = [[NSMutableArray alloc] init];

        for (ButtonViewModel *viewModel in buttonViewModelArray)
        {
            UIButton *leftNavigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftNavigationButton.frame = CGRectMake(0, 0, 30, 30);
            if (viewModel.buttonText.length > 0)
            {
                [leftNavigationButton setTitle:viewModel.buttonText forState:UIControlStateNormal];
                leftNavigationButton.titleLabel.font = viewModel.font;
                [leftNavigationButton setTitleColor:viewModel.buttonTextColor forState:UIControlStateNormal];
            }
            else
            {
                [leftNavigationButton setImage:viewModel.buttonImage forState:UIControlStateNormal];
            }
            [leftNavigationButton sizeToFit];
            [leftNavigationButton addTarget:target action:viewModel.buttonSelector forControlEvents:UIControlEventTouchUpInside];
            [leftNavigationButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
          
            UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:leftNavigationButton];
            [items addObject:item];
        }
        self.navigationItem.leftBarButtonItems = items;
    }
}

- (void)createRightNavigationItemWithButtonViewModels:(NSArray<ButtonViewModel *> *)buttonViewModelArray target:(id)target
{
    if (buttonViewModelArray && buttonViewModelArray.count > 0)
    {
        self.navigationItem.rightBarButtonItems = nil;
        
        NSMutableArray * items = [[NSMutableArray alloc] init];
        
        for (ButtonViewModel *viewModel in buttonViewModelArray)
        {
            UIButton *rightNavigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rightNavigationButton.frame = CGRectMake(0, 0, 30, 30);
            if (viewModel.buttonText.length > 0)
            {
                [rightNavigationButton setTitle:viewModel.buttonText forState:UIControlStateNormal];
                rightNavigationButton.titleLabel.font = viewModel.font;
                [rightNavigationButton setTitleColor:viewModel.buttonTextColor forState:UIControlStateNormal];
                [rightNavigationButton setContentEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 0)];
                [rightNavigationButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            }
            else
            {
                [rightNavigationButton setImage:viewModel.buttonImage forState:UIControlStateNormal];
            }
            [rightNavigationButton sizeToFit];
            [rightNavigationButton addTarget:target action:viewModel.buttonSelector forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationButton];
            [items addObject:item];
            
            UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceBar.width = 20;
            [items addObject:spaceBar];
        }
        self.navigationItem.rightBarButtonItems = items;
    }
}

- (void)respondsToLeftNavigationButton:(UIButton *)button
{
    [self baseControllerClickLeftButton:button];
}

- (void)respondsToRightNavigationButton:(UIButton *)button
{
    [self baseControllerClickRightButton:button];
}

- (void)baseControllerClickLeftButton:(UIButton *)button
{
    [self backToLastViewController:button];
}

- (void)baseControllerClickRightButton:(UIButton *)button
{
    
}

- (void)backToLastViewController:(UIButton *)button
{
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
 
- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusBarStyle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[HttpEngine shareHttpEngine] cancelPartHttpRequestWithCalledName:NSStringFromClass(self.class)];
    NSLog(@"%@ has been dealloc",NSStringFromClass(self.class));
}

@end
