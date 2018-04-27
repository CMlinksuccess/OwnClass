//
//  SelectTextField.h
//  SelectTextFiled
//
//  Created by 小玩家 on 16/6/30.
//  Copyright © 2016年 小玩家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CMSelectTextField : UITextField

/*******************实现点击UITextFieled弹出选项卡进行选择功能*******************/

//每个选择项的高度设置，默认44
@property (nonatomic, assign)CGFloat itemHeight;
//固定弹出选择视图高度则设置该值
@property (nonatomic, assign)CGFloat selectViewHeight;
//是否弹出视图选择，默认弹出
@property (nonatomic, assign) BOOL isShowSelectView;
//选项视图的背景颜色
@property (nonatomic, strong)UIColor *itemBgColor;
//选项视图的圆角大小
@property (nonatomic, assign)NSInteger iCornerRadius;
//选项视图的边框大小
@property (nonatomic, assign)NSInteger iBorderWidth;
//选项视图的边框颜色
@property (nonatomic, strong)UIColor *iBorderColor;
//默认YES
@property (nonatomic, assign)BOOL isShowIndicator;
//选项文字居左：0  剧中：1  居右：2  默认居左
@property (nonatomic, assign)NSInteger iTextAlignment;
//选项中的文字大小
@property (nonatomic, strong)UIFont *iTextFont;
//选项中的文字颜色
@property (nonatomic, strong)UIColor *iTextColor;
//是否显示选项分隔线，默认YES
@property (nonatomic, assign)BOOL isshowline;
//设置选项分隔线的颜色
@property (nonatomic, strong)UIColor *itemLineColor;
//点击项的背景颜色
@property (nonatomic, strong)UIColor *selectItemBgColor;


- (instancetype)initWithSelectTextFieldFrame:(CGRect)frame itemArray:(NSArray *)itemArray;
+ (instancetype)SelectTextFieldWithFormat:(CGRect)frame itemArray:(NSArray *)itemArray;



@end
