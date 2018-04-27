//
//  Download.m
//  Download
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "Download.h"

@interface Download ()<NSURLSessionDownloadDelegate>

@property (strong, nonatomic)NSURLSessionDownloadTask *task;

@property (strong, nonatomic)NSData *resumeData;

@property (strong, nonatomic)NSURLSession *session;

@property (copy, nonatomic)NSString *fileString;

@property (assign, nonatomic) BOOL isSuccess;

@end

@implementation Download


- (instancetype)initWithURLString:(NSString *)urlString withIdentifier:(NSString *)indentifier
{
    self = [super init];
    if (self) {
    NSArray *fileName = [urlString componentsSeparatedByString:@"/"];
    _fileString =[NSString stringWithFormat:@"Documents/%@", [fileName lastObject]];
    //1.create url
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2.Session configuration object
    //NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    //support background download（iOS8）
    NSURLSessionConfiguration *configure =[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:indentifier];
    //iOS7: [NSURLSessionConfiguration backgroundSessionConfiguration:@"www.baidu.com"]; this way support ios7
    
    //3. When you create a session, specify the proxy for monitoring the download progress
    _session = [NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //4.create download task
    _task = [_session downloadTaskWithURL:url];
    
    [_task resume];
 }
    return self;
}

+ (instancetype)DownloadWithURLString:(NSString *)urlString withIdentifier:(NSString *)indentifier
{

    return [[self alloc]initWithURLString:urlString withIdentifier:indentifier];
}


#pragma mark -NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:_fileString];

    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    self.isSuccess = [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileUrl error:nil];
    if ([_delegate respondsToSelector:@selector(download:isSuccess:)]) {
        
        [_delegate download:self isSuccess:self.isSuccess];
        
    }
}

/**
 *
 *
 *  @param session
 *  @param downloadTask
 *  @param bytesWritten                *current download data size
 *  @param totalBytesWritten           *download finish total data size
 *  @param totalBytesExpectedToWrite   *all download total data size
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //progress =  totalBytesWritten  / totalBytesExpectedToWrite
   
    float progress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    if ([_delegate respondsToSelector:@selector(download:Progress:)]) {
        
        [self.delegate download:self Progress:progress];
    }
}



- (void)pauseDownload
{
    //cancel download
    [_task cancelByProducingResumeData:^(NSData *resumeData) {
        
        //flag data
        _resumeData = resumeData;
        
    }];
}

- (void)continueDownload
{
    //_session re request network
    _task = [_session downloadTaskWithResumeData:_resumeData];

    [_task resume];
}







@end

































