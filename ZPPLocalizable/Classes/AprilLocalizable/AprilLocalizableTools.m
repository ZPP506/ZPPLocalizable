//
//  FXLocalizableTools.m
//  LocationDome
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import "AprilLocalizableTools.h"
#import "AprilBundle.h"
#import <objc/runtime.h>


@interface AprilLocalizableTools()


@end

@implementation AprilLocalizableTools
- (NSArray *)allLanguageCodes
{
    return @[@"en",@"zh-CN",@"zh-TW",@"ko",@"zh-HK"];
}
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
    
    // 改变本地语言
    NSString * current =  [self setlanguageWithType:lanagesType];
    return current;
}
+ (NSString *)setlanguageWithType:(LOCATIONLANAGESTYPE)lanagesType{
    
    NSString * current = @"zh-Hans-US";
    switch (lanagesType) {
        case LOCATIONLANAGESTYPE_EN:
            current = @"en";
            break;
        case LOCATIONLANAGESTYPE_zh_Hans:
            current = @"zh-Hans";
            break;
        case LOCATIONLANAGESTYPE_zh_Hant_TW:
            current = @"zh-Hant";
            break;
        case LOCATIONLANAGESTYPE_KO:
            current = @"ko";
            break;
        case LOCATIONLANAGESTYPE_zh_Hant_HK:
            current = @"zh-HK";
            break;
        default:
            break;
    }
    
    // 切换语言
    [[NSUserDefaults standardUserDefaults] setObject:@[current] forKey:KLanguagesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 绑定对应Bundle
    object_setClass([NSBundle mainBundle], [AprilBundle class]);
    return current;
}
+ (void)LocalizableChangeCountry
{
    [self changeRootViewController];
}
+(UIViewController *)changeRootViewController{
    
    UITabBarController * maintab =  (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    maintab.selectedIndex = 0;
    id oldRootController =  [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *  rootViewController = [[[oldRootController class] alloc]init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //动画
        CATransition * animation = [[CATransition alloc]init];
        animation.duration = 1.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        // 水滴效果
        animation.type = @"rippleEffect";
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    });
    return rootViewController;
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
    /**系统提供的多语言Key zh-Hant-HK配置失效 不知道为啥要使用zh-HK 一脸蒙圈*/
    if ([current containsString:@"HK"]){
        
        return LOCATIONLANAGESTYPE_zh_Hant_HK;
    }
    if ([current containsString:@"zh-Hant"]) {
        return LOCATIONLANAGESTYPE_zh_Hant_TW;
    }
    if ([current containsString:@"ko"]) {
        return LOCATIONLANAGESTYPE_KO;
    }
    
    return LOCATIONLANAGESTYPE_Other;
}
+ (NSString *)currentLanguageCode:(LOCATIONLANAGESTYPE)labType{
    if (labType == LOCATIONLANAGESTYPE_Other){
        labType = [self currentLanages];
    }
    if (labType == LOCATIONLANAGESTYPE_EN) {
        return @"en";
    }
    if (labType == LOCATIONLANAGESTYPE_zh_Hans) {
        return @"zh-CN";
    }
    if (labType == LOCATIONLANAGESTYPE_zh_Hant_TW) {
        return @"zh-TW";
    }
    if (labType == LOCATIONLANAGESTYPE_KO) {
        return @"ko";
    }
    if (labType == LOCATIONLANAGESTYPE_zh_Hant_HK) {
        return @"zh-HK";
    }
    return @"en";
}
+ (NSString *)currentLanagesDetaile:(LOCATIONLANAGESTYPE)labType
{
    NSString * lanaguageDetail = @"--";
    switch (labType) {
        case LOCATIONLANAGESTYPE_zh_Hans:
        {
            lanaguageDetail = @"简体中文";
        }
            break;
        case LOCATIONLANAGESTYPE_zh_Hant_TW:
        {
            lanaguageDetail = @"繁體中文(臺灣)";
        }
            break;
        case LOCATIONLANAGESTYPE_zh_Hant_HK:
        {
            lanaguageDetail = @"繁体中文(香港)";
        }
            break;
        case LOCATIONLANAGESTYPE_EN:
        {
            lanaguageDetail = @"English";
        }
            break;
        case LOCATIONLANAGESTYPE_KO:
        {
            lanaguageDetail = @"한국어";
        }
            break;
        default:
            lanaguageDetail = @"English";
            break;
    }
    return lanaguageDetail;
}
@end
