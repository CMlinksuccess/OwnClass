//
//  PublicTools.m
//  PublicTools
//
//  Created by ECOOP－09 on 16/8/8.
//  Copyright © 2016年 ECOOP－09. All rights reserved.
//

#import "PublicTools.h"

@implementation PublicTools



+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    if (mobileNum.length == 0) return NO;

    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0-9]|18[0-9]|14[57])[0-9]{8}$";// 中国手机号码
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [pred evaluateWithObject:mobileNum];
}



+(BOOL)isValidDateEmail:(NSString *)email{
    if (!email) return NO;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


+ (BOOL)isValidUrlString:(NSString *)url{
    if (!url) return NO;
    
    NSString *urlRegex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",urlRegex];
    
    return [urlTest evaluateWithObject:url];
}

+(UIColor *)colorChangeToRGB:(NSString *)colorString{
    
    NSString *isValiColor = @"#[A-F0-9a-f]{3,8}";
    NSPredicate *colorTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",isValiColor];
    if (![colorTest evaluateWithObject:colorString]) { //判断是否为16进制颜色值
        return nil;
    }
    
    NSString *color = colorString;
    color = [color stringByReplacingCharactersInRange:[color rangeOfString:@"#" ] withString:@"0x"];  // 转换成标准16进制数
    
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);  // 十六进制字符串转成整形。
    
    int R = (colorLong & 0xFF0000 )>>16; // 通过位与方法获取三色值
    int G = (colorLong & 0x00FF00 )>>8;
    int B = colorLong & 0x0000FF;
    
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];   //string转color
    
    return wordColor;
}


+ (NSString*)getCurrentTimeFormatString:(NSString *)formateString{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    if (formateString == nil) formateString = @"yyyy-MM-dd HH:mm:ss";
    [formatter setDateFormat:formateString];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    
    return dateTime;
}

+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatString{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatString];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    return destDate;
}


+ (NSString *)stringFromDate:(NSDate *)date formatString:(NSString *)formatString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   
    if (formatString == nil) formatString = @"yyyy-MM-dd HH:mm:ss zzz";  //zzz表示时区

    [dateFormatter setDateFormat:formatString];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


+ (NSInteger)getSecondsFromDate:(NSString *)fDate todate:(NSString *)tDate formatString:(NSString *)formatString{
    
    if (!formatString) formatString = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    
    NSDate *date1 = [dateFormatter dateFromString:fDate];
    NSDate *date2 = [dateFormatter dateFromString:tDate];
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    
    return (NSInteger)time;
}

+ (UIImage *)createImageWithColor: (UIColor *)color;{
    if (!color) color = [UIColor whiteColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    if (!image) return nil;
    UIGraphicsBeginImageContext(reSize);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


+(void)setViewRoundWithImg:(UIView*)view img:(UIImage *)image{
    if (!view) return;
    [view.layer setCornerRadius:CGRectGetHeight([view bounds]) / 2];
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor clearColor] CGColor];
    view.layer.contents = (id)[image CGImage];
}


+(void)showMessage:(NSString *)message{
    
    [self showMessage:message showTimeState:SHOW_SHORT];
}


+(BOOL)isContainChinese:(NSString*)str{
    BOOL flag = NO;
    for(int i = 0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if(a>0x4e00&&a<0x9fff){
            flag=YES;
            break;
        }
    }
    return flag;
}


+(void)showMessage:(NSString *)message showTimeState:(ShowTimeState)showState{
    if (!message) return;
    NSInteger time = 0;
    time = (showState == SHOW_LONG) ? 8 : 3;
    
    CGFloat SCREEN_WIDTH=[[UIScreen mainScreen] bounds].size.width;
    CGFloat SCREEN_HEIGHT=[[UIScreen mainScreen] bounds].size.height;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    __block UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message boundingRectWithSize:CGSizeMake(290, 9999)                                       options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont                                        systemFontOfSize:17]} context:nil].size;
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT*2/3, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:time animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
        showview = nil;
    }];
}




@end
