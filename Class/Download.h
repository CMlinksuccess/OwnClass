//
//  Download.h
//  Download
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
/*************download network resources**************/
/**
 *  Download the resources will be stored in the Documents folder
 */
@class Download;
@protocol DownloadDelegate <NSObject>

@optional
// file download progress,Constant quote
- (void)download:(Download *)download Progress:(float)progress;
// download completed call
- (void)download:(Download *)download isSuccess:(BOOL)isSuccess;

@end

@interface Download : NSObject

@property (weak, nonatomic)id<DownloadDelegate> delegate;

// download network file, urlString is website.
- (instancetype)initWithURLString:(NSString *)urlString withIdentifier:(NSString *)indentifier;

+ (instancetype)DownloadWithURLString:(NSString *)urlString withIdentifier:(NSString *)indentifier;

// pause download
- (void)pauseDownload;

//contine download
- (void)continueDownload;


@end
