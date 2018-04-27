//
//  MainTableViewController.m

//MainTableViewController

//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MainTabBarController.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTabBarHeight 49
#define kNavgationBarHeight 64

#pragma mark -* Create Own tabBarButtonItem *-
@interface ItemButton : UIControl


- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)titleColor;

@end

@implementation ItemButton

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)titleColor{
    self = [super initWithFrame:frame];
    if (self) {
        
        //Width and Height image
        CGFloat imageH ;
        CGFloat imageW ;
        //create imageView
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];

        if (title == nil) {
            //Width and Height image
            imageH = kTabBarHeight - 25;
            imageW = imageH;
            //change imageView frame
           imageView.Frame = CGRectMake((frame.size.width - imageW) * .5, (kTabBarHeight - imageH ) *.5, imageW, imageH);
            
        }else{
            
            //Width and Height image
            imageH = 20;
            imageW = imageH;
            imageView.Frame = CGRectMake((frame.size.width - imageW) * .5, 5, imageW, imageH);
       
            //Width and height Lable
            CGFloat lableW = frame.size.width;
            CGFloat lableH = 15;
        
            //create UILable
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 3,lableW , lableH)];
        lable.text = title;
            if (titleColor == nil) {
                lable.textColor = [UIColor blackColor];
            }else{
                lable.textColor = titleColor;
            }
            
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
            
        }
    }
    return self;
}

@end

#pragma mark -* MainTabBarController *-
@interface MainTabBarController ()

@property (nonatomic,strong)UIImageView *backImage;

@end

@implementation MainTabBarController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self _deleteTabBarButtonItem];
}

/**
 *  Create UINavigationController
 */
- (void)_createSubController
{
    NSMutableArray *naArray = [[NSMutableArray alloc]init];
    
    for (UIViewController *viewCtrl in self.ctrlArray) {

    UINavigationController *navigateCtrl = [[UINavigationController alloc]initWithRootViewController:viewCtrl];
        
        [navigateCtrl.navigationBar setBackgroundImage:self.navigationBarImage forBarMetrics:UIBarMetricsDefault];
        //set navigationBar alpha, YES is alpha = 0 ,NO is alpha = 1
        navigateCtrl.navigationBar.translucent = YES;

        navigateCtrl.navigationBar.barTintColor = self.navigationBarColor;
        
        if (self.navTitleColor != nil) {
            
            navigateCtrl.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : self.navTitleColor };
        }
        [naArray addObject:navigateCtrl];
    }
    self.viewCtrlArray = naArray;
    
    [self _createTabBarButtonItem];
}

/**
 *  Delete system TarBarButtonItem
 */
- (void)_deleteTabBarButtonItem
{
    for (UIView *barItem in self.tabBar.subviews) {

    //Will system UIBarButton Class type（UIBarButton type External cannot directly refer to this class）
        Class barButtonClass = NSClassFromString(@"UITabBarButton");
        
        if ([barItem isKindOfClass: barButtonClass]) {

            [barItem removeFromSuperview];
    
        }
    }
}

/**
 *  Create own TabBarButtonItem
 */
- (void)_createTabBarButtonItem
{
    for (UIControl *item in self.tabBar.subviews) {
        [item removeFromSuperview];
    }
    
    [self _deleteTabBarButtonItem];
    
    //set tabBarController sub Controler
    self.viewControllers = self.viewCtrlArray;

    CGFloat itemButtonWidth = kScreenWith / self.viewCtrlArray.count;
    
       for (NSInteger i = 0 ; i < self.viewCtrlArray.count ; i++) {
           
           ItemButton *itemButton;

           if (self.titles == nil) {
               
            itemButton = [[ItemButton alloc]initWithFrame:CGRectMake(i * itemButtonWidth, 0, itemButtonWidth , kTabBarHeight) imageName:self.imageName[i] title:nil titleColor:self.titlesColor];
           }else
           {
              itemButton = [[ItemButton alloc]initWithFrame:CGRectMake(i * itemButtonWidth, 0, itemButtonWidth , kTabBarHeight) imageName:self.imageName[i] title:self.titles[i] titleColor:self.titlesColor];
           }
           
        itemButton.backgroundColor = self.tabBarForeColor;
           
        [itemButton addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
           
             itemButton.tag = i + 1;
           
           if (i == 0) {
               [self _createSelectButtonImageView];
               self.backImage.center = itemButton.center;
           }
        [self.tabBar addSubview:itemButton];
    }
}

//setTabBarItem Control
- (void)ItemClick:(ItemButton *)itembutton
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backImage.center = itembutton.center;
        
    }];
    
    self.selectedIndex = itembutton.tag - 1;
}

- (void)_createSelectButtonImageView
{
    self.backImage = nil;
    //set to be selected ItemButton background
    self.backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith / self.viewCtrlArray.count - 20, kTabBarHeight - 4)];
    [self.tabBar addSubview:self.backImage];
    self.backImage.layer.cornerRadius = 5;
    self.backImage.layer.masksToBounds = YES;
    if (self.selectItemColor == nil) {
        
        self.backImage.backgroundColor = [UIColor redColor];
        
    }else{
        
        self.backImage.backgroundColor = self.selectItemColor;
    }
    
    if (self.selectItemImage != nil) {
        
        self.backImage.backgroundColor = nil;
        self.backImage.image = self.selectItemImage;
    }

}

#pragma mark -* Set property *-
//setTitles
- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self _createTabBarButtonItem];
}

//setImages
-(void)setImageName:(NSArray *)imageName
{
    _imageName = imageName;
    [self _createTabBarButtonItem];
}

-(void)setSelectItemColor:(UIColor *)selectItemColor
{
    _selectItemColor = selectItemColor;
    [self _createTabBarButtonItem];

}

//ItemButton background image
- (void)setSelectItemImage:(UIImage *)selectItemImage
{
    _selectItemImage = selectItemImage;
    [self _createTabBarButtonItem];

}

- (void)setTabBarImage:(UIImage *)tabBarImage
{
    _tabBarImage = tabBarImage;
    
    //set TabBar background Image
    self.tabBar.backgroundImage = _tabBarImage;
    [self _createTabBarButtonItem];

}

-(void)setTitlesColor:(UIColor *)titlesColor
{
    _titlesColor = titlesColor;
    [self _createTabBarButtonItem];
}

- (void)setTabBarForeColor:(UIColor *)tabBarForeColor
{
    _tabBarForeColor = tabBarForeColor;
    [self _createTabBarButtonItem];

}

-(void)setViewCtrlArray:(NSArray *)viewCtrlArray
{
    _viewCtrlArray = viewCtrlArray;
    [self _createTabBarButtonItem];

}


- (void)setCtrlArray:(NSArray *)ctrlArray
{
    _ctrlArray = ctrlArray;
    [self _createSubController];
    
}

- (void)setNavigationBarColor:(UIColor *)navigationBarColor
{
    _navigationBarColor = navigationBarColor;
    [self _createSubController];
    

}

- (void)setNavigationBarImage:(UIImage *)navigationBarImage
{
    _navigationBarImage = navigationBarImage;
    [self _createSubController];
    
}

- (void)setNavTitleColor:(UIColor *)navTitleColor
{
    _navTitleColor = navTitleColor;
    [self _createSubController];
    

}


@end















