//
//  Stockpile.h
//
//  Created by apple  on 2017/11/28
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Stockpile : NSObject <NSCoding, NSCopying>
+(instancetype)sharedStockpile;
@property (nonatomic, copy) NSString *userId;//用户账号唯一标识
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *formattedName;//全名
@property (nonatomic, copy) NSString *userName;//用户名/邮箱
@property (nonatomic, copy) NSString *password;//密码
@property (nonatomic, copy) NSString *avatar;//头像
@property (nonatomic, copy) NSString *employeeId;//员工信息唯一标识
@property (nonatomic, copy) NSString *country;//国家
///新版本2.0不区分角色，权限功能直接全部获取，不需要切换角色
@property(nonatomic,strong)NSString *role;//角色 角色(employee, supervisor, hr)
@property (nonatomic, copy) NSString *dateFormat;//日期格式
@property (nonatomic, assign) NSInteger timeFormat;//时间格式 0：24小时制，1：12小时制(AM/PM)

@property (nonatomic, copy) NSString *zoneId;//时区

@property (nonatomic, assign) NSInteger gender;//性别(1-男，2-女，3-其他)
@property (nonatomic, copy) NSString *userSex;
@property (nonatomic, copy) NSString *birthDate;//生日时间戳
@property (nonatomic, copy) NSString *birthDateFormate;
@property (nonatomic, copy) NSString *socialSecurityNo;//nationality;
@property (nonatomic, copy) NSString *departmentName;//部门名称
@property (nonatomic, copy) NSString *employeeNo;//
@property (nonatomic, copy) NSString *positionTitle;
@property (nonatomic, copy) NSString *hireDate;//时间错
@property (nonatomic, copy) NSString *hireDateFormate;
@property (nonatomic, copy) NSString *mobile;//
@property (nonatomic, copy) NSString *phone;//
@property (nonatomic, copy) NSString *email;//
@property (nonatomic, copy) NSString *faceRequestId;//
/** 可见光人脸照片状态(-1-无人脸，0-申请中(待审核)，1-通过，2-拒绝) */
@property (nonatomic, assign)NSInteger faceStatus;
@property (nonatomic, copy) NSString *facePhoto;//
@property (nonatomic, copy) NSString *remark;//
//+(Stockpile *)read;
+(void)saveData:(id)data;
+(void)reshInfoWith:(void(^)(id obj))block;
+(void)reshToker:(void(^)(id obj))block;
-(void)destructionFile;
-(void)save;
@end

@interface SetTimeClockReshToken : NSObject
+(id)shareReshToken;
@property(nonatomic,strong)NSTimer *timer;
@end
