//
//  AnalyzeObject.h
//  GuitarProject
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"
#import "AnalyzeInterface.h"
#import "YYKit.h"

///Get、Post、PostFile、Put、Patch、Delete
typedef NS_ENUM(NSInteger, MNetworkType) {
    MNetworkTypeGet,
    MNetworkTypePost,
    MNetworkTypePostFile,
    MNetworkTypePut,
    MNetworkTypePatch,
    MNetworkTypeDelete
};//Not cache.

@interface PayloadObject : NSObject
@property(nonatomic,strong)NSString *dataFmt;
@property(nonatomic,strong)id results;
@end

@interface ResultObject : NSObject

@property(nonatomic,strong)NSString *code;//错误码
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *cmpId;//公司ID
@property(nonatomic,strong)NSString *token;//token 
@property(nonatomic,strong)PayloadObject *payload;

@property(nonatomic,assign)BOOL success;


@end


typedef void(^AnalyzeObjectBlock)(ResultObject* obj,NSError *error);
@interface AnalyzeObject : NSObject
@property(nonatomic,strong)dispatch_group_t group;
+ (instancetype)sharedInstance;
/**
 *DELETE请求
 */
+(id)publicDeleteAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
-(id)publicDeleteAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
/**
 *PATCH请求
 */
+(id)publicPatchAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
-(id)publicPatchAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
/**
 *PUT请求
 */

+(id)publicPutAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
-(id)publicPutAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;

/**
 *Get请求
 */
+(id)publicGetAnalyzeWithService:(NSString *)service parameters:(id)parameters canCache:(BOOL)can block:(AnalyzeObjectBlock)block;
/**
 *Get请求
 */
+(id)publicGetAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
-(id)publicGetAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
/**
 *Get请求
 */
+(id)publicGetAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
-(id)publicGetAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
/*
 *Post请求
 */
+(id)publicPostAnalyzeWithService:(NSString *)service parameters:(id)parameters canCache:(BOOL)can block:(AnalyzeObjectBlock)block;

/*
 *Post请求
 */
+(id)publicPostAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
-(id)publicPostAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;

/*
 *Post请求 缓存
 */
+(id)publicPostAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;
-(id)publicPostAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block;

/*
 *上传文件
 */
+(id)publicPostFileWithService:(NSString *)service parameters:(NSArray<NSData *> *)parameters block:(AnalyzeObjectBlock)block;

-(id)publicPostFileWithService:(NSString *)service parameters:(NSArray *)parameters block:(AnalyzeObjectBlock)block;
@end
