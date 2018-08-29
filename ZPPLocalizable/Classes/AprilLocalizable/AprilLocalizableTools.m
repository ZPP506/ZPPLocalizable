//
//  AprilLocalizableTools.m
//  LocationDome
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 April. All rights reserved.
//

#import "AprilLocalizableTools.h"
#import "AprilBundle.h"
#import <objc/runtime.h>
//#import "MainBarViewController.h"
//#import "NameAuthenViewController.h"
//#import "SetViewController.h"


@interface AprilLocalizableTools()


@end

@implementation AprilLocalizableTools

+ (instancetype) shareManager{
    static AprilLocalizableTools * tools = nil;
    if (tools == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tools = [[AprilLocalizableTools alloc]init];
        });
    }
    return tools;
}
#pragma mark -  返回国际化字符串
+ (NSString *)Localizable:(NSString *)key {
    return NSLocalizedString(key, nil);
}
+ (NSString *) Localizable:(NSString *)key tbl:(NSString *)tbl{
    return NSLocalizedStringFromTable(key, tbl, nil);
}

#pragma mark - 切换语言
+ (void)LocalizableChangeLanguages:(LOCATIONLANAGESTYPE)lanagesType
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KLanguagesWillChangeNotif object:nil]
    ;
    [self LocalizableChangeLanguagesRoot:lanagesType];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KLanguagesDidChangeNotif object:nil]
    ;
}

+ (void)LocalizableChangeLanguagesRoot:(LOCATIONLANAGESTYPE)lanagesType
{
   
    // 切换语言
  [self LocalizableMainChangeLanguages:lanagesType];

    //添加跟控制器
    [self changeRootViewController];

}
+(NSString *)LocalizableMainChangeLanguages:(LOCATIONLANAGESTYPE)lanagesType{
    
    NSString * current = @"zh-Hans-US";
    switch (lanagesType) {
        case LOCATIONLANAGESTYPE_EN:
            current = @"en";
            break;
        case LOCATIONLANAGESTYPE_zh_Hans:
            current = @"zh-Hans";
            break;
        case LOCATIONLANAGESTYPE_zh_Hant:
            current = @"zh-Hant";
            break;
        default:
            break;
    }
    /**-----------------没用-----------*/
    //   NSMutableArray * tempArray = ((NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:KLanguagesKey]).mutableCopy;
    //    [tempArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        if ([obj containsString:current]) {
    //            [tempArray removeObject:obj];
    //        }
    //    }];
    //    [tempArray insertObject:current atIndex:0];
    //    [[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:KLanguagesKey];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    // 切换语言
    [[NSUserDefaults standardUserDefaults] setObject:@[current] forKey:KLanguagesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    // 绑定对应Bundle
    object_setClass([NSBundle mainBundle], [AprilBundle class]);
    return current;
}
+(UIViewController *)changeRootViewController{
    
    
//    MainBarViewController * rootuViewController = [[MainBarViewController alloc]init];
    
    /**动画*/
    CATransition * animation = [[CATransition alloc]init];
    animation.duration = 1.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // 水滴效果
    animation.type = @"rippleEffect";
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [UIViewController new];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
    /**切换到- 语言设置页面*/
//    rootuViewController.selectedIndex = 4;
//    UINavigationController * nav = rootuViewController.selectedViewController;
//    nav.hidesBottomBarWhenPushed = YES;
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([SetViewController class]) bundle:nil];
//    SetViewController *pVc = [sb instantiateInitialViewController];
//    [nav pushViewController:pVc animated:NO];
    
    return [UIViewController new];
}

#pragma mark - 当前语言
+ (LOCATIONLANAGESTYPE)currentLanages{
    
   NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:KLanguagesKey];
   NSString * current = [array firstObject];
    if ([current containsString:@"en"]) {
        return LOCATIONLANAGESTYPE_EN;
    }
    if ([current containsString:@"zh-Hans"]) {
        return LOCATIONLANAGESTYPE_zh_Hans;
    }
    if ([current containsString:@"zh-Hant"]) {
        return LOCATIONLANAGESTYPE_zh_Hant;
    }
    return LOCATIONLANAGESTYPE_zh_Hant;
}

@end
