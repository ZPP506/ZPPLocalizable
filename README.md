# ZPPLocalizable

[![CI Status](https://img.shields.io/travis/张朋朋/ZPPLocalizable.svg?style=flat)](https://travis-ci.org/张朋朋/ZPPLocalizable)
[![Version](https://img.shields.io/cocoapods/v/ZPPLocalizable.svg?style=flat)](https://cocoapods.org/pods/ZPPLocalizable)
[![License](https://img.shields.io/cocoapods/l/ZPPLocalizable.svg?style=flat)](https://cocoapods.org/pods/ZPPLocalizable)
[![Platform](https://img.shields.io/cocoapods/p/ZPPLocalizable.svg?style=flat)](https://cocoapods.org/pods/ZPPLocalizable)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
支持简体中文/繁体香港/繁体台湾/韩文/英文

语言切换 - 监听宏
#define KLanguagesWillChangeNotif @"KLanguagesWillChangeNotif" //将要切换
#define KLanguagesDidChangeNotif @"KLanguagesDidChangeNotif" // 语言已经切换

加载多语言字符串  
**key：国际化Key**  
`#define FXLocalizedString(key)[FXLocalizableTools Localizable:key]`   
**key：国际化Key  tbl：加载特定国际化文件名**  
`#define FXLocalizedStringFromTable(key,tbl)[FXLocalizableTools Localizable:key tbl:tbl]`  
**切换语言**  
`#define FXLocalizedChangeLanguages(LOCATIONLANAGESTYPE) [FXLocalizableTools LocalizableChangeLanguages:LOCATIONLANAGESTYPE]`

```
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
```
 **获取当前语言**  
`+ (LOCATIONLANAGESTYPE)currentLanages;  
+ (NSString *)currentLanguageCode:(LOCATIONLANAGESTYPE)labType;  
+ (NSString *)currentLanagesDetaile:(LOCATIONLANAGESTYPE)labTypeq;`

## Installation

ZPPLocalizable is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZPPLocalizable'
`

## Author

April  944160330@qq.com



## License

ZPPLocalizable is available under the MIT license. See the LICENSE file for more info.
