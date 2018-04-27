//
//  FloatButton.h
//  AssistantTool
//
//  Created by Chen on 15/12/9.
//  Copyright © 2015年 com.Chen.AssistantTool. All rights reserved.
//

#import <UIKit/UIKit.h>
//按钮点击通知
#define FloatButtonClickNotification @"FloatButtonClickNotication"

@interface FloatButton : NSObject
/*
 * 浮动按钮是否显示
 */
@property (nonatomic, assign)BOOL isShow;

/*  给窗口初始化显示浮动按钮
 *  floatImage 移动的图片名
 *  subButtonImageName 展开后子按钮的图片名数组
 */
+ (instancetype)floatButtonImageName:(NSString *)floatImage subImageName:(NSArray *)subButtonImageName;
- (instancetype)initWithImageName:(NSString *)floatImage subImageName:(NSArray *)subButtonImageName;

@end
