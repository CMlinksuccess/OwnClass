//
//  FloatButton.m
//  AssistantTool
//
//  Created by Chen on 15/12/9.
//  Copyright © 2015年 com.Chen.AssistantTool. All rights reserved.
//

#import "FloatButton.h"

#define buttonWidth 50
#define buttonHeight 50
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
typedef NS_ENUM(NSUInteger, ExtensionDirection)
{
   AnimationExtensionTop     = 0,      //浮动按钮停靠在顶部
   AnimationExtensionLeft    = 1,      //浮动按钮停靠在左侧
   AnimationExtensionBottom  = 2,      //浮动按钮停靠在底部
   AnimationExtensionRight   = 3       //浮动按钮停靠在右侧
};

static const NSTimeInterval  kAnimationTime = 0.25f;    //设置弹出动画时间
static FloatButton *_floatButton = nil;                 //创建单例

@interface FloatButton ()

@property (retain, nonatomic)UIWindow *bgwindow;                //主窗口
@property (retain, nonatomic)UIView *backgroundView;            //按钮背景父视图
@property (retain, nonatomic)UIImageView *floatView;            //浮动按钮视图
@property (retain, nonatomic)NSMutableArray *buttonArray;       //展开的按钮数组
@property (retain, nonatomic)NSArray *buttonImgArray;           //按钮背景图
@property (assign, nonatomic)BOOL isAnimating;                  //是否正在动画
@property (assign, nonatomic)BOOL isSpread;                     //按钮是否展开
@property (assign, nonatomic)ExtensionDirection floatDirection; //浮动按钮的停靠方向
@property (assign, nonatomic)CGRect viewMoveFrame;              //按钮移动后的坐标位置
@end

@implementation FloatButton

-(void)setIsShow:(BOOL)isShow
{
    _isShow = isShow;
    if (_isShow) {
        _bgwindow.hidden = NO;
    }else{
        _bgwindow.hidden = YES;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.bgwindow = nil;
    self.floatView = nil;
    self.buttonArray = nil;
    self.buttonImgArray = nil;
    self.backgroundView = nil;

}

- (instancetype)initWithImageName:(NSString *)floatImage subImageName:(NSArray *)subButtonImageName
{
    if (self = [super init]) {
        
        if (subButtonImageName) {
            self.buttonImgArray = subButtonImageName;
        }
        self.buttonArray = [NSMutableArray array];
        self.floatDirection = AnimationExtensionLeft;
        
        //背景窗口
        self.bgwindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, kScreenHeight / 2, buttonWidth, buttonHeight)];
        self.bgwindow.backgroundColor = [UIColor clearColor];
        self.bgwindow.windowLevel = 3000;
        self.bgwindow.clipsToBounds = YES;
        [self.bgwindow makeKeyAndVisible];
        
        //背景视图
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        self.backgroundView.userInteractionEnabled = YES;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self.bgwindow addSubview:self.backgroundView];
        
        //浮动视图按钮
        self.floatView = [[UIImageView alloc]init];
        self.floatView.userInteractionEnabled = YES;
        self.floatView.clipsToBounds = YES;      //子视图剪切
        self.floatView.layer.cornerRadius = buttonWidth / 2;
        self.floatView.backgroundColor = [UIColor brownColor];
        if (floatImage) {
            self.floatView.image = [UIImage imageNamed:floatImage];
        }
        self.floatView.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
        [self.backgroundView addSubview:self.floatView];
        
        //手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
        [self.floatView addGestureRecognizer:panGesture];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
        [self.floatView addGestureRecognizer:tapGesture];
        
    }
    return self;
}


+ (instancetype)floatButtonImageName:(NSString *)floatImage subImageName:(NSArray *)subButtonImageName
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _floatButton = [[self alloc]initWithImageName:floatImage subImageName:subButtonImageName];
    });
    return _floatButton;
}

#pragma mark - 拖拽手势事件
- (void)panGestureAction:(UIPanGestureRecognizer *)pan
{
    //展开则不允许拖动
    if (self.isSpread) {
        return;
    }
    UIView *moveView = pan.view.superview.superview;
    [UIView animateWithDuration:kAnimationTime animations:^{
        //按钮正在被拖拽
        if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
            CGPoint translationPoint = [pan translationInView:moveView];
            moveView.center = CGPointMake(moveView.center.x + translationPoint.x, moveView.center.y + translationPoint.y);
            [pan setTranslation:CGPointZero inView:moveView.superview];
        }
        //拖拽按钮结束
        if (pan.state == UIGestureRecognizerStateEnded) {
            [self moveEndWithView:moveView];
         }
    }];
}

#pragma mark - 判断按钮的移动后的停靠位置
- (void)moveEndWithView:(UIView *)moveView
{
    if (moveView.frame.origin.y <= buttonHeight) {
        if (moveView.frame.origin.x < 0) {
            moveView.center = CGPointMake(moveView.frame.size.width / 2, moveView.frame.size.height / 2);
            self.floatDirection = AnimationExtensionLeft;
        }else if(moveView.frame.origin.x + moveView.frame.size.width > kScreenWidth){
            moveView.center = CGPointMake(kScreenWidth - moveView.frame.size.width / 2, moveView.frame.size.height / 2);
            self.floatDirection = AnimationExtensionRight;
        }else{
            moveView.center = CGPointMake(moveView.center.x, moveView.frame.size.height / 2);
            self.floatDirection = AnimationExtensionTop;
        }
    }else if(moveView.frame.origin.y + moveView.frame.size.height >= kScreenHeight - buttonHeight){
        if (moveView.frame.origin.x < 0) {
            moveView.center = CGPointMake(moveView.frame.size.width / 2,kScreenHeight - moveView.frame.size.height / 2);
            self.floatDirection = AnimationExtensionLeft;
        }else if(moveView.frame.origin.x + moveView.frame.size.width > kScreenWidth){
            moveView.center = CGPointMake(kScreenWidth - moveView.frame.size.width / 2,kScreenHeight - moveView.frame.size.height / 2);
            self.floatDirection = AnimationExtensionRight;
        }else{
            moveView.center = CGPointMake(moveView.center.x,kScreenHeight - moveView.frame.size.height / 2);
            self.floatDirection = AnimationExtensionBottom;
        }
    
    }else{
        if (moveView.frame.origin.x + moveView.frame.size.width / 2 < kScreenWidth / 2){
            if (moveView.frame.origin.x != 0) {
                moveView.center = CGPointMake(moveView.frame.size.width / 2, moveView.center.y);
     
            }
            self.floatDirection = AnimationExtensionLeft;
        
        }else{
    
            if (moveView.frame.origin.x + moveView.frame.size.width != kScreenWidth) {
            moveView.center = CGPointMake(kScreenWidth - moveView.frame.size.width / 2, moveView.center.y);
            }
            self.floatDirection = AnimationExtensionRight;
        }
    }
}

#pragma mark - 点击手势
- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    if (!_isAnimating) {
        
        if (_isSpread) {
            
            [self hideSubbutton];
        }else{
            
            [self showSubbutton];
        }
    }
   
    _isSpread = !_isSpread;
}

#pragma mark - 显示子按钮
- (void)showSubbutton
{
    self.viewMoveFrame = self.bgwindow.frame;
    self.bgwindow.frame = [UIScreen mainScreen].bounds;
    self.backgroundView.frame = self.viewMoveFrame;
    [self shakeMenu:self.backgroundView];
    
    //创建子按钮
    for (NSInteger i = 0; i < self.buttonImgArray.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:self.viewMoveFrame];
        [button setBackgroundColor:[UIColor blackColor]];
        button.layer.cornerRadius = buttonWidth / 2;
        [self.bgwindow insertSubview:button belowSubview:self.backgroundView];
        [self.buttonArray addObject:button];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.buttonImgArray[i]) {
            [button setBackgroundImage:[UIImage imageNamed:self.buttonImgArray[i]] forState:UIControlStateNormal];
        }
    }
    
    //按钮显示动画
    [UIView animateWithDuration:kAnimationTime animations:^{
        for (NSInteger i = 0; i <  self.buttonArray.count; i ++) {
            UIButton *button = self.buttonArray[i];
            switch (self.floatDirection) {
                case 0:
                    //靠上
                    button.frame = CGRectMake(self.viewMoveFrame.origin.x, buttonWidth + 5 + self.buttonArray.count * i + buttonWidth * i, buttonWidth,buttonWidth);
                  break;
                case 1:
                    //靠左
                    button.frame = CGRectMake(buttonWidth + 5 + self.buttonArray.count * i + buttonWidth * i, self.viewMoveFrame.origin.y, buttonWidth, buttonWidth);
                    break;
                case 2:
                    //靠下
                    button.frame = CGRectMake(self.viewMoveFrame.origin.x, kScreenHeight - buttonWidth - buttonWidth - 5 - (self.buttonArray.count *i + buttonWidth * i), buttonWidth,buttonWidth);
                    break;
                case 3:
                    //靠右
                    button.frame = CGRectMake(kScreenWidth - buttonWidth - buttonWidth - 5 - (self.buttonArray.count *i + buttonWidth * i), self.viewMoveFrame.origin.y, buttonWidth, buttonWidth);
                    break;
                default:
                    break;
            }
        }
        self.isAnimating = YES;
    }completion:^(BOOL finished) {
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapAction:)];
        [self.bgwindow addGestureRecognizer:bgTap];
        _isSpread = YES;
        _isAnimating = NO;
    }];
    
}
- (void)bgTapAction:(UITapGestureRecognizer *)gesture{
    if (_isSpread) {
        
        [self hideSubbutton];
    }
   
}
- (void)buttonClick:(UIButton *)sender
{
    [self bgTapAction:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:FloatButtonClickNotification object:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - 隐藏子视图
- (void)hideSubbutton
{
    [self shakeMenu:self.backgroundView];
    [UIView animateWithDuration:kAnimationTime animations:^{
        for (NSInteger i = 0; i < self.buttonArray.count; i ++) {
            UIButton *button = self.buttonArray[i];
            button.frame = CGRectMake(self.viewMoveFrame.origin.x, self.viewMoveFrame.origin.y, buttonWidth, buttonWidth);
        }
        _isAnimating = YES;
    } completion:^(BOOL finished) {
        for (NSInteger i = 0; i < self.buttonArray.count; i ++) {
            UIButton *button = self.buttonArray[i];
            [button removeFromSuperview];
        }
        self.bgwindow.frame = self.viewMoveFrame;
        self.backgroundView.frame = CGRectMake(0, 0, buttonWidth, buttonWidth);
        [self.buttonArray removeAllObjects];
        [self.bgwindow removeGestureRecognizer:[[self.bgwindow gestureRecognizers] lastObject]];
        
        _isSpread = NO;
        _isAnimating = NO;
    }];
}

#pragma mark - 抖动效果
- (void)shakeMenu:(UIView *)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-5, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+5, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    [animation setValue:@"toViewValue" forKey:@"toViewKey"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.2];
    [animation setRepeatCount:1];
    [lbl addAnimation:animation forKey:nil];
}

@end
