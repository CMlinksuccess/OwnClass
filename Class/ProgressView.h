//
//  ProgressView.h
//  ProgressView
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

typedef NS_ENUM(NSInteger, ProgressStyle) {
    ProgressLineRadius  = 0,  // 0
    ProgressArc         = 1,  // 1
};

/***********Two style for progress **************/

//progressStyle is progress style,default is ProgressLineRadius.
@property (nonatomic) ProgressStyle progressStyle;

// set progress number,min default is  0, max default is 1.
@property (assign, nonatomic)CGFloat progress;

//set progress line width,default to 3.
@property (assign, nonatomic)CGFloat progressWidth;

//set progress line color ,default is blueColor.
@property (strong, nonatomic)UIColor* progressColor;

@end
