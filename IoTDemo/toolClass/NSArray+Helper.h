//
//  NSArray+Helper.h
//  GeXiaZi
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSUInteger, NSArraySort) {
        NSArrayASC=0 ,//正序排序从大到小排序
        NSArrayDESC,//倒序排序从大到小排序
};
@interface NSArray(Helper)
/**
 *  数字排序
 */
-(NSArray *)NSArraySortNumber:(NSArraySort)sort;
/**
*  日期排序
*/
-(NSArray *)NSArraySortDate:(NSArraySort)sort;
/**
 *  汉子按字母排序
 */
-(void)NSArraySortByChinese:(void(^)(NSArray *arr))block;
/**
 *  汉子按字母排序
 */
-(void)NSArraySortWithModelClass:(id)model ByChinese:(void(^)(NSArray *arr,NSArray*section))block;
@end
