//
//  SelectTextField.m
//  SelectTextFiled
//
//  Created by 小玩家 on 16/6/30.
//  Copyright © 2016年 小玩家. All rights reserved.
//

#import "CMSelectTextField.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CMSelectTextField ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) NSArray *selectItem;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UITableView *tableView;
//弹框是否显示状态
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) BOOL isup;
@end

static NSString *identifier =  @"selectItemCell";

@implementation CMSelectTextField


- (instancetype)initWithSelectTextFieldFrame:(CGRect)frame itemArray:(NSArray *)itemArray{
    self = [super initWithFrame:frame];
    if (self != nil) {
        if (itemArray.count >= 1) {
            self.placeholder = @"点击选择";
            self.selectItem = itemArray;
            self.delegate = self;
            self.isshowline = YES;
            self.isShowIndicator = YES;
            self.isShowSelectView = YES;
            UILabel *leftView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 15, frame.size.height)];
            self.leftView = leftView;
        }
    }

    return self;
}



+ (instancetype)SelectTextFieldWithFormat:(CGRect)frame itemArray:(NSArray *)itemArray{
    return [[self alloc]initWithSelectTextFieldFrame:frame itemArray:itemArray];
}

//创建选择视图
- (void)createSelectView{
    if (self.bgView == nil && self.isShowSelectView) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //获取输入框相对窗口的坐标
        CGRect textFiledRect = [self.superview convertRect:self.frame toView:window];
        //判断显示屏幕高度
        CGFloat showHeight = 0;
            _isup = YES;
        if (textFiledRect.origin.y > (kScreenHeight-textFiledRect.origin.y-textFiledRect.size.height)) {
            showHeight = textFiledRect.origin.y;
            _isup = YES;
        }else{
            showHeight = kScreenHeight-textFiledRect.origin.y-textFiledRect.size.height;
            _isup = NO;
        }
        CGFloat showViewHeight = 0;
        //显示选项视图的高度
        if (self.selectViewHeight > 10) {
            
            showViewHeight = self.selectViewHeight;
        }else{
        
            showViewHeight = (showHeight - 20 > textFiledRect.size.height * self.selectItem.count) ? (textFiledRect.size.height * self.selectItem.count) : (showHeight - 20);
        }
        
        CGFloat showViewY = _isup ? (textFiledRect.origin.y - showViewHeight) : (textFiledRect.origin.y + textFiledRect.size.height);
      
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(textFiledRect.origin.x, showViewY, textFiledRect.size.width, showViewHeight)];
        self.bgView.backgroundColor = [UIColor grayColor];
        //设置圆角
        if (_iCornerRadius > 0) {
            
            self.bgView.layer.cornerRadius = _iCornerRadius;
            
            self.bgView.layer.masksToBounds = YES;
            
        }
        //设置边框
        if (_iBorderWidth > 0) {
            
            self.bgView.layer.borderWidth = _iBorderWidth;
        }
        
        if (self.iBorderColor) {
            
            self.bgView.layer.borderColor = self.iBorderColor.CGColor;
        }

        [window addSubview:self.bgView];
        
        self.tableView = [[UITableView alloc]initWithFrame:self.bgView.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        //分隔线设置
        if (!self.isshowline) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else if(self.itemLineColor){
        
            self.tableView.separatorColor = self.itemLineColor;
    
        }
        //是否显示滚动条
        self.tableView.showsVerticalScrollIndicator = self.isShowIndicator;
        [self.bgView addSubview:self.tableView];
        
        if (self.itemBgColor) {
            self.bgView.backgroundColor = self.itemBgColor;
            self.tableView.backgroundColor = self.itemBgColor;
        }
        self.bgView.hidden = YES;
    }
    
}

- (void)bgViewHidden{
    
    CGRect bgFrame2 = self.bgView.frame;
    if (_isup) {
        
        bgFrame2.origin.y = self.frame.origin.y;
    }
        bgFrame2.size.height = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.hidden = NO;
        self.bgView.frame = bgFrame2;
        
    }completion:^(BOOL finished) {
        
        [self deleteItemVeiw];
        self.isShow = NO;
    }];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.isShow) {
        
        [self bgViewHidden];
    }else{
    
        [self createSelectView];
        CGRect bgFrame = self.bgView.frame;
        CGRect bgFrame2 = self.bgView.frame;
        if (_isup) {
            bgFrame2.origin.y = self.frame.origin.y;
        }
        bgFrame2.size.height = 0;
        self.bgView.frame = bgFrame2;
        [UIView animateWithDuration:0.5 animations:^{
            self.bgView.hidden = NO;
            self.bgView.frame = bgFrame;
            
        }];
        self.isShow = YES;
    }
 
    return !self.isShowSelectView;
    
}


#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.selectItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.selectItem[indexPath.row];
    //单元格属性设置
    if (!self.isshowline) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (self.selectItemBgColor){
    
       UIView *selectView = [[UIView alloc]initWithFrame:cell.frame];
        selectView.backgroundColor = self.selectItemBgColor;
        cell.selectedBackgroundView = selectView;
    }
    if (self.textAlignment >= 0) {
        
        cell.textLabel.textAlignment = self.iTextAlignment;
    }
    if (self.iTextFont) {
        cell.textLabel.font = self.iTextFont;
    }
    if (self.itemLineColor) {
        cell.textLabel.textColor = self.iTextColor;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.itemHeight > 8) {
        return self.itemHeight;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.text = self.selectItem[indexPath.row];
    
    [self bgViewHidden];

}

//删除选项视图
- (void)deleteItemVeiw{
    [self.bgView removeFromSuperview];
    [self.tableView removeFromSuperview];
    self.bgView = nil;
    self.tableView = nil;
}

@end
