//
//  ImageAutoScrollView.h
//  ImageAutoScrollView
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageAutoScrollView : UIView

/**
 *  automatic image scroll
 *
 */
//imageArray is image name array.
@property (nonatomic,strong)NSArray *imageArray;

//current page color show.
@property (nonatomic,strong)UIColor *currentColor;

//NonCurrent page color show.
@property (nonatomic,strong)UIColor *NoncurrentColor;

//scroll time every page,default is 2s.
@property (nonatomic,assign)NSInteger scrollTime;

//whether to open automatic image scroll,default is NO.
@property (nonatomic,assign)BOOL isAutoScroll;

@end
