//
//  BaseModel.h
//  YYDB
//
//  Created by 张向阳 on 17/2/13.
//  Copyright © 2017年 zxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Helper.h"
#import "NSString+Helper.h"
#import "YYKit.h"
#import "BasicConfiguration.h"
@interface BaseModel : NSObject
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)CGFloat cellHeight;
-(CGFloat)getItemCellHeight;
@end
