//
//  ToastLable.h
//
//  Created by mac on 15/10/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHOWTIME){
    SHOWTIME_SHART = 0,
    SHOWTIME_LONG = 1,
};

/***************imitate Android Toast show ****************/
@interface ToastLable : UILabel

// defaule is SHOWTIME_SHART
+ (void)ToastMakeText:(NSString *)text;

// SHOWTIME is set show time
+ (void)ToastMakeText:(NSString *)text showTime:(SHOWTIME) showTime;

// set show Center
+ (void)ToastMakeText:(NSString *)text showCenter:(CGPoint)center showTime:(SHOWTIME) showTime;

@end
