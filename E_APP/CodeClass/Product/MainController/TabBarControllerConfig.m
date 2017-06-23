//
//  TabBarControllerConfig.m
//  E_APP
//
//  Created by Ezra on 2017/6/13.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "TabBarControllerConfig.h"
#import "BaseNavigationController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface TabBarControllerConfig ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation TabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        FirstViewController *firstViewController = [[FirstViewController alloc] init];
        UIViewController *firstNavigationController = [[BaseNavigationController alloc]
                                                       initWithRootViewController:firstViewController];
        
        SecondViewController *secondViewController = [[SecondViewController alloc] init];
        UIViewController *secondNavigationController = [[BaseNavigationController alloc]
                                                        initWithRootViewController:secondViewController];
        /**
         *  选项卡右上角的数字
         */
        //        secondNavigationController.tabBarItem.badgeValue = @"10";
        
        ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
        UIViewController *thirdNavigationController = [[BaseNavigationController alloc]
                                                       initWithRootViewController:thirdViewController];
        
        FourthViewController *fourthViewController = [[FourthViewController alloc] init];
        UIViewController *fourthNavigationController = [[BaseNavigationController alloc]
                                                        initWithRootViewController:fourthViewController];
//        ErectViewController *fifthViewControll = [[ErectViewController alloc]init];
//        UIViewController *fifthNavigationController = [[CYLBaseNavigationController alloc]initWithRootViewController:fifthViewControll];
        
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在`-setUpTabBarItemsAttributesForController`方法中不传`CYLTabBarItemTitle`字段。
         * 更推荐后一种做法。
         */
        //tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        //tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
        
        // 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController,
                                               thirdNavigationController,
                                               fourthNavigationController
                                               ]];
        // 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

/**
 *  在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"行情",
                            CYLTabBarItemImage : @"upshape",
                            CYLTabBarItemSelectedImage : @"upshape_s",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"交易",
                            CYLTabBarItemImage : @"trade",
                            CYLTabBarItemSelectedImage : @"trade_s",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"钱包",
                            CYLTabBarItemImage : @"crown",
                            CYLTabBarItemSelectedImage : @"crown_s",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"个人",
                            CYLTabBarItemImage : @"my",
                            CYLTabBarItemSelectedImage : @"my_s"
                            };
    
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4,
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
         tabBarController.tabBarHeight = 49.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x111111);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
//     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait){
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor clearColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
