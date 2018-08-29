//
//  AprilBundle.m
//  LocationDome
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 April. All rights reserved.
//

#import "AprilBundle.h"

@implementation AprilBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    
    NSBundle * currentBudle = [self getCurrentBundle];
    
    if (currentBudle) {
        return [currentBudle localizedStringForKey:key value:value table:tableName];
    }else
    {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}
- (NSBundle *)getCurrentBundle{
    
    /**去掉-US 主要是因为 模拟器上 在多语言获取时 会多处国家后缀，真机上没有这个*/
    NSArray * tempArr = [[NSUserDefaults standardUserDefaults] objectForKey:KLanguagesKey];
    NSString * lanauager = [tempArr firstObject];
    if ([lanauager containsString:@"-US"]) {
        NSRange range = [lanauager rangeOfString:@"-US"];
        lanauager = [lanauager substringWithRange:range];
    }
    NSString* pathBundle =  [[NSBundle mainBundle] pathForResource:lanauager ofType:@"lproj"];
    return [NSBundle bundleWithPath:pathBundle];
}
@end
