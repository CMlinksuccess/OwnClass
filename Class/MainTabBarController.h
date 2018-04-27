//
//  MainTableViewController.h
//
// MainTableViewController

//  Created by mac on 15/8/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController

/***************Set TabBarButton property********/
//ItemButton titles
@property (nonatomic,strong)NSArray *titles;

//ItemButton images
@property (nonatomic,strong)NSArray *imageName;


/***************Set TabBar property********/
//TabBar titles color, defaults to blackColor
@property (nonatomic,strong)UIColor *titlesColor;

//TabBar foreground color
@property (nonatomic,strong)UIColor *tabBarForeColor;

//TabBar background image
@property (nonatomic,strong)UIImage *tabBarImage;

/***************Set TabBarButtonItem selected state property********/
//Select itemButton background color
@property (nonatomic,strong)UIColor *selectItemColor;

//Select itemButton background image
@property (nonatomic,strong)UIImage *selectItemImage;


/**********Set SubController (Own Controller or ViewController) property********/
//ViewController array
@property (nonatomic,strong)NSArray *viewCtrlArray;


/***************Set NavigationController property********/
//NavigationController array
@property (nonatomic,strong)NSArray *ctrlArray;

//NavigationBar background image
@property (nonatomic,strong)UIImage *navigationBarImage;

//NavigationBar background color
@property (nonatomic,strong)UIColor *navigationBarColor;

//NavigationBar title background color,defaults to blackColor
@property (nonatomic,strong)UIColor *navTitleColor;

@end



