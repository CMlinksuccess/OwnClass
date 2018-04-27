//
//  OrderAndSearch.h
//  CLLoocation
//
//  Created by ECOOP－09 on 16/7/27.
//  Copyright © 2016年 ECOOP－09. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderAndSearch : NSObject


/***************中文数组排序、实时搜索************************/
/**
 *  将中文数组转换为拼音数组
 */
+ (NSArray *)turnLetter:(NSArray *)chineseArr;


/**
 *  中文排序方法：
 *
 *  @param array 中文（可带英文，按字母排序）数组
 *
 *  @return 排好序的数组
 */
+ (NSArray *)letterOrderArray:(NSArray *)array;


/**
 *  中英文搜索方法：
 *
 *  @param textArray 所有内容
 *  @param text  想要搜索的文本
 *
 *  @return 所有搜索的结果
 */
+ (NSArray *)searchTextWithArray:(NSArray *)textArray search:(NSString *)text;

@end
