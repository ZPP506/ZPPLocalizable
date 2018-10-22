//
//  FXLocalizableTools.h
//  LocationDome
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 FX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KLanguagesWillChangeNotif @"KLanguagesWillChangeNotif"
#define KLanguagesDidChangeNotif @"KLanguagesDidChangeNotif"

/**key：国际化Key*/
#define FXLocalizedString(key)[FXLocalizableTools Localizable:key]

/**key：国际化Key  tbl：加载特定国际化文件名*/
#define FXLocalizedStringFromTable(key,tbl)[FXLocalizableTools Localizable:key tbl:tbl]

/**切换语言*/
#define FXLocalizedChangeLanguages(LOCATIONLANAGESTYPE) [FXLocalizableTools LocalizableChangeLanguages:LOCATIONLANAGESTYPE]

typedef enum : NSUInteger {
    /**未知语言*/
    LOCATIONLANAGESTYPE_Other,
    /**简体中文*/
    LOCATIONLANAGESTYPE_zh_Hans,
    /**繁体中文 台湾*/
    LOCATIONLANAGESTYPE_zh_Hant_TW,
    /**繁体中文 香港*/
    LOCATIONLANAGESTYPE_zh_Hant_HK,
    /**英文*/
    LOCATIONLANAGESTYPE_EN,
    /**韩文*/
    LOCATIONLANAGESTYPE_KO
    
}LOCATIONLANAGESTYPE;

@interface AprilLocalizableTools : NSObject

+ (instancetype) shareManager;
@property (copy, nonatomic) NSArray *allLanguageCodes;

/**当前语言*/
+ (LOCATIONLANAGESTYPE)currentLanages;
+ (NSString *)currentLanguageCode:(LOCATIONLANAGESTYPE)labType;
+ (NSString *)currentLanagesDetaile:(LOCATIONLANAGESTYPE)labTypeq;


/**加载国际化语言字符串*/
+ (NSString *) Localizable:(NSString *)key;
+ (NSString *) Localizable:(NSString *)key tbl:(NSString *)tbl;

// 改变本地语言 - 不切换
+ (NSString *)setlanguageWithType:(LOCATIONLANAGESTYPE)lanagesType;
+ (void)LocalizableChangeLanguages:(LOCATIONLANAGESTYPE)lanagesType;


/**国家切换*/
+ (void)LocalizableChangeCountry;


@end
