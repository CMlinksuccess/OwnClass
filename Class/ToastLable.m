//
//  ToastLable.m
// Toast
//  Created by mac on 15/10/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ToastLable.h"

@implementation ToastLable


+ (void)ToastMakeText:(NSString *)text
{
    [self ToastMakeText:text showTime:SHOWTIME_SHART];
}

+ (void)ToastMakeText:(NSString *)text showTime:(SHOWTIME) showTime{

    NSArray *win = [UIApplication sharedApplication].windows;
    UIWindow *window = [win firstObject];

    [self ToastMakeText:text showCenter:CGPointMake(window.center.x , window.center.y * 1.5) showTime:showTime];
}

+ (void)ToastMakeText:(NSString *)text showCenter:(CGPoint)center showTime:(SHOWTIME) showTime
{
    ToastLable *label = [[ToastLable alloc] init];
   
    label.text = text;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.alpha = 0.0;
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    NSArray *win = [UIApplication sharedApplication].windows;
    UIWindow *window = [win firstObject];
    
    NSDictionary *attrs = @{NSFontAttributeName : label.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(window.bounds.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    label.frame = CGRectMake( 0,0,size.width + 35,size.height + 12);
    label.center = center;
    [window addSubview:label];
    
    // 2.animation
    CGFloat time = ((showTime == SHOWTIME_SHART) ? 0.8 : 3.5);
    [UIView animateWithDuration:0.8 animations:^{
        label.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 delay:time options:UIViewAnimationOptionCurveLinear animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];

}

@end
