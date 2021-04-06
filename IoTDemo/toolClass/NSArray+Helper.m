//
//  NSArray+Helper.m
//  GeXiaZi
//
//  Created by apple on 16/6/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSArray+Helper.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChineseToPinyin.h"
#import "NSString+Helper.h"
@implementation NSArray(Helper)
/**
 *  数字排序
 */
-(NSArray *)NSArraySortNumber:(NSArraySort)sort{
    return [self sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            if (sort == NSArrayASC) {
                    return (NSComparisonResult)NSOrderedDescending;
            }
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            if (sort == NSArrayASC) {
                  return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
}
-(NSArray *)NSArraySortDate:(NSArraySort)sort{
    return [self sortedArrayUsingComparator: ^(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        if (sort == NSArrayDESC) {
            return result;
        }
        switch(result)
        {
            case NSOrderedAscending:
                return NSOrderedDescending;
            case NSOrderedDescending:
                return NSOrderedAscending;
            case NSOrderedSame:
                return NSOrderedSame;
            default:
                return NSOrderedSame;
        } // 时间从近到远（远近相对当前时间而言）
    }];
}
/**
 *  汉子按字母排序
 */
-(void)NSArraySortByChinese:(void(^)(NSArray *arr))block{
    NSMutableArray *sectionTitles=[[NSMutableArray alloc]init];
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
 
    [sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    //返回27，是a－z和＃
    NSInteger highSection = [sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    for (NSInteger i=0;i<self.count;i++) {
        //getUserName是实现中文拼音检索的核心，见NameIndex类
        NSDictionary *dic = [self objectAtIndex:i];
        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:[[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] EmptyStringByWhitespace]];
        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:dic];
    }
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:[[NSString stringWithFormat:@"%@",[obj1 objectForKey:@"name"]] EmptyStringByWhitespace]];
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:[[NSString stringWithFormat:@"%@",[obj2 objectForKey:@"name"]] EmptyStringByWhitespace]];
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    block(sortedArray);
}
-(void)NSArraySortWithModelClass:(Class)model ByChinese:(void(^)(NSArray *arr,NSArray*section))block{
    NSMutableArray *sectionTitles=[[NSMutableArray alloc]init];
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    //返回27，是a－z和＃
    NSInteger highSection = [sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    for (NSInteger i=0;i<self.count;i++) {
        //getUserName是实现中文拼音检索的核心，见NameIndex类
//        FriendModel *model = [self objectAtIndex:i];
//        if (model.name == nil) {
//            model.name  = @"";
//        }
//        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:[[NSString stringWithFormat:@"%@",model.name] EmptyStringByWhitespace]];
//        if (firstLetter == nil) {
//            firstLetter = @"#";
//        }
//
//        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
//        NSMutableArray *array = [sortedArray objectAtIndex:section];
//        [array addObject:model];
    }
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
//        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(FriendModel *model1, FriendModel *model2) {
//            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:[[NSString stringWithFormat:@"%@",model1.name] EmptyStringByWhitespace]];
//            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
//            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:[[NSString stringWithFormat:@"%@",model2.name] EmptyStringByWhitespace]];
//            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
          //  return [firstLetter1 caseInsensitiveCompare:firstLetter2];
      //  }];
      //  [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
     int i=0;
    NSMutableArray * existTitles = [[NSMutableArray alloc]init];
    for (int j=0; j<sectionTitles.count; j++) {
        NSArray *Arr=[sortedArray objectAtIndex:i];
        if (Arr.count<1) {
            [sortedArray removeObjectAtIndex:i];
             continue;
        }
         [existTitles addObject:[sectionTitles objectAtIndex:j]];
        i++;
    }
    if (block) {
        block(sortedArray,existTitles);
    }
    
   // block(sortedArray);
}
@end
