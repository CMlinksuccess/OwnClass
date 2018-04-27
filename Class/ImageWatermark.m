//
//  ImageWatermark.m
//  08 图片水印
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 wxhl. All rights reserved.
//

#import "ImageWatermark.h"

@implementation ImageWatermark


//______________createImageWatermark  all parameter______________________

- (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point setWatermark:(NSDictionary *)dictionary
{

    self = [super init];
    if (self) {
        //设置水印属性
        if (dictionary == nil) {
            NSLog(@"%@",[UIFont familyNames]);
            dictionary = @{
                           NSFontAttributeName : [UIFont italicSystemFontOfSize: 17],
                           NSForegroundColorAttributeName : [UIColor grayColor],
                           NSUnderlineStyleAttributeName : @(1)
                           };
        
        }
        
        //开启一个位图上下文(内存缓冲区,占据内存的一块空间)
        UIGraphicsBeginImageContext(image.size);
        
        //将图片绘制到上下文
        [image drawAtPoint:CGPointZero];
        
        //绘制文字(水印)
        [watermark drawAtPoint:point withAttributes:dictionary];
        
        //从当前的上下文(位图上下文)中获取到新的图片
        self = (ImageWatermark *)UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭上下文(如果不关闭会一直消耗内存)
        UIGraphicsEndImageContext();
    }

    return self;
}

+ (instancetype)watermarkWithFormat:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point setWatermark:(NSDictionary *)dictionary
{

    return [[self alloc]initWithImageWatermark:image watermark:watermark pointWith:point setWatermark:dictionary];
}

//_____________________Three parameter * set CGpoint_______________________
- (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point
{
    
    return [self initWithImageWatermark:image watermark:watermark pointWith:point setWatermark:nil];
    
}

+ (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark pointWith:(CGPoint)point
{
    
    return [[self alloc] initWithImageWatermark:image watermark:watermark pointWith:point];
    
}

//______________________Three parameter * set Watermark___________________
- (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark setWatermark:(NSDictionary *)dictionary
{
    
    return [self initWithImageWatermark:image watermark:watermark pointWith:CGPointZero setWatermark:dictionary];
    
}

+ (instancetype)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark setWatermark:(NSDictionary *)dictionary
{
    
    return [[self alloc] initWithImageWatermark:image watermark:watermark pointWith:CGPointZero setWatermark:dictionary];
    
}

//_________________________Two parameter_________________
- (UIImage *)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark
{
    
    return [self initWithImageWatermark:image watermark:watermark pointWith:CGPointZero];
    
}

+ (UIImage *)initWithImageWatermark:(UIImage *)image watermark:(NSString *)watermark
{
    
    return [[self alloc] initWithImageWatermark:image watermark:watermark pointWith:CGPointZero];
    
}

/*___font familyNames_______________
 Marion,
 Copperplate,
 "Heiti SC",
 "Iowan Old Style",
 "Courier New",
 "Apple SD Gothic Neo",
 "Heiti TC",
 "Gill Sans",
 "Marker Felt",
 Thonburi,
 "Avenir Next Condensed",
 "Tamil Sangam MN",
 "Helvetica Neue",
 "Gurmukhi MN",
 "Times New Roman",
 Georgia,
 "Apple Color Emoji",
 "Arial Rounded MT Bold",
 Kailasa,
 "Kohinoor Devanagari",
 "Sinhala Sangam MN",
 "Chalkboard SE",
 Superclarendon,
 "Gujarati Sangam MN",
 Damascus,
 Noteworthy,
 "Geeza Pro",
 Avenir,
 "Academy Engraved LET",
 Mishafi,
 Futura,
 Farah,
 "Kannada Sangam MN",
 "Arial Hebrew",
 Arial,
 "Party LET",
 Chalkduster,
 "Hiragino Kaku Gothic ProN",
 "Hoefler Text",
 Optima,
 Palatino,
 "Malayalam Sangam MN",
 "Lao Sangam MN",
 "Al Nile",
 "Bradley Hand",
 "Hiragino Mincho ProN",
 "Trebuchet MS",
 Helvetica,
 Courier,
 Cochin,
 "Devanagari Sangam MN",
 "Oriya Sangam MN",
 "Snell Roundhand",
 "Zapf Dingbats",
 "Bodoni 72",
 Verdana,
 "American Typewriter",
 "Avenir Next",
 Baskerville,
 "Khmer Sangam MN",
 Didot,
 "Savoye LET",
 "Bodoni Ornaments",
 Symbol,
 Menlo,
 "Bodoni 72 Smallcaps",
 "DIN Alternate",
 Papyrus,
 "Euphemia UCAS",
 "Telugu Sangam MN",
 "Bangla Sangam MN",
 Zapfino,
 "Bodoni 72 Oldstyle",
 "DIN Condensed"
 */

@end














