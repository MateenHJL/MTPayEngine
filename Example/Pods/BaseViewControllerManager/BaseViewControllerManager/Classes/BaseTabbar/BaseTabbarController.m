//
//  BaseTabbarController.m
//  CustomerTemplate
//
//  Created by Mateen on 15/5/22.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseTabbarItem.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import <BaseUIManager/CommonFile.h>
#import "WZLBadgeImport.h"

@interface BaseTabbarController () <UITabBarControllerDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation BaseTabbarController

@synthesize dataSource = _dataSource;
@synthesize selectedDelegate = _selectedDelegate;
@synthesize currentIndex = _currentIndex;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        if (!_dataSource)
        {
            _dataSource = [NSMutableArray array];
        }
        _currentIndex = 0;
        self.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBar.opaque = NO;
        self.delegate = self;
    }
    return self;
}

- (void)resetTabbarForDataModelArray:(NSMutableArray *)modelArray
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:modelArray];

    if (modelArray && [modelArray isKindOfClass:[NSArray class]] && modelArray.count > 0)
    {
        NSMutableArray *rootControllerArray = [NSMutableArray array];
        for (int i = 0; i < modelArray.count;i++)
        {
            BaseTabbarItem *item = [modelArray objectAtIndex:i];
            Class class = NSClassFromString(item.rootControllerName);
            BaseNavigationController *rootController = [[BaseNavigationController alloc]initWithRootViewController:[[class alloc]init]];
            rootController.tabBarItem.image = [item.normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            rootController.tabBarItem.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            rootController.tabBarItem.title = item.normalTitle;
            [rootController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rgb(102, 102, 102),NSForegroundColorAttributeName,[UIFont systemFontOfSize:kAdjustFont(10)],NSFontAttributeName,nil] forState:UIControlStateSelected];
            [rootController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rgb(127, 131, 137),NSForegroundColorAttributeName,[UIFont systemFontOfSize:kAdjustFont(10)],NSFontAttributeName,nil] forState:UIControlStateNormal];
            [rootControllerArray addObject:rootController];
        }
        [self setViewControllers:rootControllerArray animated:YES];
    }
}

- (void)refreshTabbarItemWithTabbarItem:(BaseTabbarItem *)tabbarItem
{
    NSInteger index = 0;
    for (int i = 0; i < self.dataSource.count; i++)
    {
        BaseTabbarItem *item = self.dataSource[i];
        if (item == tabbarItem)
        {
            index = i;
        }
    }
    BaseTabbarController *tabbar = (BaseTabbarController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    UITabBarItem *tabbarItemView = tabbar.tabBar.items[index];
    [tabbarItemView clearBadge];
    if ([tabbarItem.badgeValue intValue] > 0)
    {
        [tabbarItemView showBadgeWithStyle:WBadgeStyleRedDot value:[tabbarItem.badgeValue integerValue] animationType:WBadgeAnimTypeNone];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    NSInteger index = [_dataSource indexOfObject:viewController];
    if (_selectedDelegate && [_selectedDelegate respondsToSelector:@selector(baseTabbarControllerDidSelectedIndex:currentIndex:choosedViewController:)])
    {
        [_selectedDelegate baseTabbarControllerDidSelectedIndex:index currentIndex:_currentIndex choosedViewController:(BaseNavigationController *)viewController];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    _currentIndex = self.selectedIndex;
    return YES;
}

- (void)setSelectedIndex:(NSUInteger)index
{
    [super setSelectedIndex:index];
}

- (void)setupTabbarData
{
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTabbarData];

    // Do any additional setup after loading the view.
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
