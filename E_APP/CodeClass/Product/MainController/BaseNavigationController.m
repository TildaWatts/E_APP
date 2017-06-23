//
//  BaseNavigationController.m
//  E_APP
//
//  Created by Ezra on 2017/6/12.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    // 当导航栏用在XMGNavigationController中, appearance设置才会生效
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //修改导航控制器下线的颜色
    bar.barTintColor = UIColorFromRGB(0xF8F8F8);
    //    bar.backgroundColor = UIColorFromRGB(0xF8F8F8);
    
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    
    
    NSMutableDictionary *navbarTitleTextAttributes = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                      UIColorFromRGB(0x414141),NSForegroundColorAttributeName,nil];
    navbarTitleTextAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}


- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    @autoreleasepool
    {
        [super popToRootViewControllerAnimated:animated];
    }
    return nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([[[self topViewController] class] isEqual:[viewController class]] )
    {
        return;
    }
    
    if (self.childViewControllers.count > 0)
    { // 如果push进来的不是第一个控制器
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    @autoreleasepool
    {
        [super pushViewController:viewController animated:animated];
    }
}

@end
