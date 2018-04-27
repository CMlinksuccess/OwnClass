//
//  PublicTools.h
//  PublicTools
//
//  Created by ECOOP－09 on 16/8/8.
//  Copyright © 2016年 ECOOP－09. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowTimeState) {
    SHOW_SHORT = 0,
    SHOW_LONG
};

@interface PublicTools : NSObject


/**
 *  1.验证字符串是否为合法的手机号
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  2.判断是否为合法的邮箱
 */
+(BOOL)isValidDateEmail:(NSString *)email;

/**
 *  3.判断是否为合法的网址
 */
+ (BOOL)isValidUrlString:(NSString *)url;

/**
 *  4.16进制转三原色
 */
+(UIColor *)colorChangeToRGB:(NSString *)colorString;

/**
 *  5.获取当前日期
 *
 *  @param formateString 想要获取的日期格式字符串，默认是 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString*)getCurrentTimeFormatString:(NSString *)formateString;

/**
 *  6.字符串转换成日期间
 *
 *  @param dateString   日期字符串
 *  @param formatString 转换成的日期格式 ex:@"yyyy-MM-dd HH:mm:ss zzz"、 @"yyyy-MM-dd"
 */
+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatString;

/**
 *  7.日期间转换成字符串
 *
 *  @param date         日期
 *  @param formatString 转换成的字符串格式，默认是@"yyyy-MM-dd HH:mm:ss zzz"
 */
+ (NSString *)stringFromDate:(NSDate *)date formatString:(NSString *)formatString;

/**
 *  8.计算两个日期差值
 *
 *  @param fDate        第一个日期
 *  @param tDate        第二个日期
 *  @param formatString 日期格式，默认为@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 相差秒数
 */
+ (NSInteger)getSecondsFromDate:(NSString *)fDate todate:(NSString *)tDate formatString:(NSString *)formatString;

/**
 *  9.使用UIColor创建UIImage
 */
+ (UIImage *)createImageWithColor: (UIColor *)color;

/**
 *  10.改变图片大小
 */
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

/**
 *  11.将视图设置为圆形
 */
+(void)setViewRoundWithImg:(UIView*)view img:(UIImage *)image;

/**
 *  12.判断字符串是否包含汉字
 */
+(BOOL)isContainChinese:(NSString*)str;

/**
 *  13.窗口显示提示信息ios7-
 *
 *  @param message   显示文本
 *  @param showState 显示状态，默认为ShowTimeState
 */
+(void)showMessage:(NSString *)message;
+(void)showMessage:(NSString *)message showTimeState:(ShowTimeState)showState;


@end


















