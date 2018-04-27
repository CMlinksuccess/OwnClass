//
//  ProgressView.m
//  Download ProgressView
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ProgressView.h"
#define kViewWidth self.frame.size.width
#define kRadius kViewWidth * 0.5


@interface ProgressView ()

@property (strong, nonatomic)UILabel *label;

@end

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = kRadius;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        //self.progress = 1;
        self.progressStyle = ProgressLineRadius;
        self.progressWidth = 3;
        self.progressColor = [UIColor blueColor];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kViewWidth -self.progressWidth, kViewWidth - self.progressWidth)];
        self.label.center =CGPointMake(kRadius, kRadius);
        self.label.font = [UIFont boldSystemFontOfSize:kRadius / 3];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //UIBezierPath
    CGPoint center = CGPointMake(kRadius, kRadius);
    CGFloat radius = kRadius - self.progressWidth;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = _progress * M_PI * 2 + startAngle;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

    
    if (self.progressStyle == ProgressArc) {
        [path addLineToPoint:center];
        
        //add context
        CGContextAddPath(ctx, path.CGPath);
        
        CGContextSetLineWidth(ctx, 0);
        [path closePath];
        [self.progressColor setFill];
        
        CGContextDrawPath(ctx, kCGPathFillStroke);
        
    }else if (self.progressStyle == ProgressLineRadius)
        CGContextAddPath(ctx, path.CGPath);

        //set progress line width
        CGContextSetLineWidth(ctx, self.progressWidth);
        [self.progressColor setStroke];
        CGContextStrokePath(ctx);
    }

#pragma mark -set property
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
     self.label.text = [NSString stringWithFormat:@"%.2f%%",_progress* 100];
    
    [self setNeedsDisplay];

}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    backgroundColor = [UIColor clearColor];
    [super setBackgroundColor:backgroundColor];
}

-(void)setProgressWidth:(CGFloat)progressWidth
{
    _progressWidth = progressWidth;

}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;

}

-(void)setProgressStyle:(ProgressStyle)progressStyle
{
    _progressStyle = progressStyle;

}


@end

















