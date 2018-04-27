//
//  ImageWatermark.h
//  08 图片水印
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

/**
 ****************Set Image Watermark**************************
 */
#import <UIKit/UIKit.h>

@interface ImageWatermark : UIImage


//_________________________Two parameter * set watermark_________________
- (UIImage *)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark;

+ (UIImage *)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark;

//______________________Three parameter * set Watermark___________________
- (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark setWatermark:(NSDictionary *)dictionary;

+ (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark setWatermark:(NSDictionary *)dictionary;

//_____________________Three parameter * set CGpoint_______________________
- (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point;

+ (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point;


//______________createImageWatermark  all parameter______________________
- (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point setWatermark:(NSDictionary *)dictionary;

+ (instancetype)watermarkWithFormat:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point setWatermark:(NSDictionary *)dictionary;



@end




















