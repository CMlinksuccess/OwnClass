//
//  OrderAndSearch.m
//  CLLoocation
//
//  Created by ECOOP－09 on 16/7/27.
//  Copyright © 2016年 ECOOP－09. All rights reserved.
//

#import "OrderAndSearch.h"

@implementation OrderAndSearch

+ (NSArray *)turnLetter:(NSArray *)chineseArr{
    if (!chineseArr) return nil;
    
    NSMutableArray *letterArr = [NSMutableArray array];
    for (NSInteger i = 0; i < chineseArr.count; i ++) {
        NSString *text = chineseArr[i];
        NSMutableString *ms = [[NSMutableString alloc] initWithString:text];
        //将中文转拼音
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {    //含有声调
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {  //不含声调
            [letterArr addObject:ms];
        }
    }

    return letterArr;
}


+ (NSArray *)letterOrderArray:(NSArray *)array{

    if (!array) return nil;
    
    NSArray *letterArr = [self turnLetter:array];
    NSDictionary *letterDic = [NSDictionary dictionaryWithObjects:array forKeys:letterArr];
    NSArray *arr = [letterArr sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *order = [NSMutableArray array];
    for (NSInteger i = 0; i < arr.count; i ++) {
        
        [order addObject:[letterDic objectForKey:arr[i]]];
    }
    return order;
}


+ (NSArray *)searchTextWithArray:(NSArray *)textArray search:(NSString *)text{
    if (!textArray || !text) return nil;
    
    NSArray *letterArr = [self turnLetter:textArray];
    NSDictionary *letterDic = [NSDictionary dictionaryWithObjects:textArray forKeys:letterArr];
    NSMutableArray *searchResult = [NSMutableArray array];
    for (NSInteger i = 0; i < textArray.count; i ++) {
        NSRange chineseRange =[textArray[i] rangeOfString:text options:NSCaseInsensitiveSearch];
        NSRange letterRange = [letterArr[i] rangeOfString:text options:NSCaseInsensitiveSearch];

        if (chineseRange.location != NSNotFound) {
            
        [searchResult addObject:textArray[i]];
            
        }else if (letterRange.location != NSNotFound) {
            
        [searchResult addObject:[letterDic objectForKey:letterArr[i]]];
        }
    }
    return searchResult;
}

@end
