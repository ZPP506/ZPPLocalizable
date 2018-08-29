//
//  AprilLocalizableTools.h
//  LocationDome
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 April. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KLanguagesWillChangeNotif @"KLanguagesWillChangeNotif"
#define KLanguagesDidChangeNotif @"KLanguagesDidChangeNotif"

/**key：国际化Key view:要设置国际化字符串的View LocalizedState：当前View所处状态*/
#define FXLocalizedString(key)[AprilLocalizableTools Localizable:key]

/**key：国际化Key view:要设置国际化字符串的View tbl：加载特定国际化文件名 LocalizedState：当前View所处状态*/
#define FXLocalizedStringFromTable(key,tbl)[AprilLocalizableTools Localizable:key tbl:tbl]

/**切换语言*/
#define FXLocalizedChangeLanguages(LOCATIONLANAGESTYPE) [AprilLocalizableTools LocalizableChangeLanguages:LOCATIONLANAGESTYPE]

typedef enum : NSUInteger {
    
    /**简体中文*/
    LOCATIONLANAGESTYPE_zh_Hans,
    /**繁体中文*/
    LOCATIONLANAGESTYPE_zh_Hant,
    /**英文*/
    LOCATIONLANAGESTYPE_EN
    
}LOCATIONLANAGESTYPE;

@interface AprilLocalizableTools : NSObject
+ (LOCATIONLANAGESTYPE)currentLanages;
/**加载国际化语言字符串*/
+ (NSString *) Localizable:(NSString *)key;

+ (NSString *) Localizable:(NSString *)key tbl:(NSString *)tbl;

/**语言切换*/
+ (void)LocalizableChangeLanguages:(LOCATIONLANAGESTYPE)lanagesType;

@end
