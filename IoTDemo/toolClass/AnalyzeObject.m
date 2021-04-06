  //
//  AnalyzeObject.m
//  GuitarProject
//
//  Created by apple on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AnalyzeObject.h"
#import "NSError+Helper.h"
#import "NSString+Helper.h"
#import "DefaultPageSource.h"
#import "ClockObject.h"
#import "NSString+Encrypt.h"
#import "YYCache.h"
#import "AppDelegate.h"

//#import "SuperViewController.h"


#define nameCache @"MFWoker"

@implementation PayloadObject

@end

@implementation ResultObject
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"payload" : [PayloadObject class]
             };
}
-(NSString *)message{
    
    if (!_message) {
        //if ([self.code isEqualToString:@"E0000001"]) {
            _message = LOCALIZATION(self.code);
       // }
    }
    return _message;
}


- (BOOL)success{
    return [self.code isEqualToString:@"00000000"];
}
@end

@implementation AnalyzeObject




+ (instancetype)sharedInstance
{
    static AnalyzeObject *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[AnalyzeObject alloc] init];
    });
    return _sharedInstance;
}
-(dispatch_group_t)group{
    if (_group == nil) {
        _group = dispatch_group_create();
    }
    return _group;
}

/**
 *DELETE请求
 */
+(id)publicDeleteAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
   
       return  [[AFAppDotNetAPIClient sharedClient]DELETE:service parameters:parameters success:^(NSURLSessionDataTask *  task, id   responseObject) {
           [ AnalyzeObject ControllerViewWithData:responseObject service:service Error:nil type:MNetworkTypeDelete block:block];
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
            [ AnalyzeObject  ControllerViewWithData:nil service:service Error:error type:MNetworkTypeDelete block:block];
        }];
  
    
}
-(id)publicDeleteAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:0];
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return  [AnalyzeObject publicDeleteAnalyzeWithService:service parameters:str block:block];
}
/**
 *PATCH请求
 */
+(id)publicPatchAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // dispatch_group_enter([AnalyzeObject sharedInstance].group);
      return   [[AFAppDotNetAPIClient sharedClient]PATCH:service parameters:parameters success:^(NSURLSessionDataTask *  task, id   responseObject) {
          //  dispatch_group_leave([AnalyzeObject sharedInstance].group);
            [ AnalyzeObject ControllerViewWithData:responseObject service:service Error:nil type:MNetworkTypePatch block:block];
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
           // dispatch_group_leave([AnalyzeObject sharedInstance].group);
            [ AnalyzeObject  ControllerViewWithData:nil service:service Error:error type:MNetworkTypePatch block:block];
        }];
 //   });
}
-(id)publicPatchAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
    return  [AnalyzeObject publicPatchAnalyzeWithService:service parameters:parameters block:block];
}
/**
 *PUT请求
 */

+(id)publicPutAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
  //  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //    dispatch_group_enter([AnalyzeObject sharedInstance].group);
       return  [[AFAppDotNetAPIClient sharedClient]PUT:service parameters:parameters success:^(NSURLSessionDataTask *  task, id   responseObject) {
          //  dispatch_group_leave([AnalyzeObject sharedInstance].group);
            [ AnalyzeObject ControllerViewWithData:responseObject service:service Error:nil type:MNetworkTypePut block:block];
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
          //  dispatch_group_leave([AnalyzeObject sharedInstance].group);
            [ AnalyzeObject  ControllerViewWithData:nil service:service Error:error type:MNetworkTypePut block:block];
        }];
    //});
}
-(id)publicPutAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
    service = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)service,NULL,NULL,kCFStringEncodingUTF8));
    
   return  [AnalyzeObject publicPutAnalyzeWithService:service parameters:parameters block:block];
}

/**
 *Get请求
 */
+(id)publicGetAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
   return  [ AnalyzeObject publicGetAnalyzeWithService:service parameters:parameters canCache:NO block:block];
}
-(id)publicGetAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
    if (parameters ) {
           service = [service stringByReplacingOccurrencesOfString:@"{XXXX}"withString:parameters];
    }
    
    service = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)service,NULL,NULL,kCFStringEncodingUTF8));
    
    //{"userId":parameters}
 
    parameters = nil;
    
    return  [AnalyzeObject publicGetAnalyzeWithService:service parameters:parameters canCache:NO block:block];
}

/**
 *Get请求
 */
+(id)publicGetAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
  return  [ AnalyzeObject  publicGetAnalyzeWithService:service parameters:parameters canCache:YES block:block];
}
-(id)publicGetAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
    
   return  [ AnalyzeObject  publicGetAnalyzeWithService:service parameters:parameters canCache:YES block:block];
}
/**
 *Get请求
 */
+(id)publicGetAnalyzeWithService:(NSString *)service parameters:(id)parameters canCache:(BOOL)can block:(AnalyzeObjectBlock)block{
    
    if ([service containsString:@"{XXXX}"]) {
        return nil;
    }
    
  //  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        YYCache *cache = [[YYCache alloc] initWithName:nameCache];
        cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
        cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
        if (can) {
            id responseObject = [cache objectForKey:[service urlDictToStringWithDict:parameters]];
            [ AnalyzeObject  ControllerViewWithData:responseObject service:service Error:nil type:MNetworkTypeGet block:block];
        }

        //dispatch_group_enter([AnalyzeObject sharedInstance].group);
       return  [[AFAppDotNetAPIClient sharedClient]GET:service parameters:parameters progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
           // dispatch_group_leave([AnalyzeObject sharedInstance].group);
            if(can){
                [cache setObject:responseObject forKey:[service urlDictToStringWithDict:parameters]];
            }

            [ AnalyzeObject ControllerViewWithData:responseObject service:service Error:nil type:MNetworkTypeGet block:block];
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
             //dispatch_group_leave([AnalyzeObject sharedInstance].group);
            [ AnalyzeObject  ControllerViewWithData:nil service:service Error:error type:MNetworkTypeGet block:block];
        }];
  //  });
}
/**
 *Post请求
 */
+(id)publicPostAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
    
   // dispatch_async(dispatch_get_global_queue(0, 0), ^{
       return  [ AnalyzeObject publicPostAnalyzeWithService:service parameters:parameters canCache:NO block:block];
    //});
}
-(id)publicPostAnalyzeWithService:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
    
     return  [ AnalyzeObject  publicPostAnalyzeWithService:service parameters:parameters canCache:NO block:block];
}
/*
 * Post请求
 */
+(id)publicPostAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
      return [ AnalyzeObject  publicPostAnalyzeWithService:service parameters:parameters canCache:YES block:block];
}
-(id)publicPostAnalyzeWithServiceCache:(NSString *)service parameters:(id)parameters block:(AnalyzeObjectBlock)block{
  return   [ AnalyzeObject  publicPostAnalyzeWithService:service parameters:parameters  canCache:YES block:block];
}
/*
 * Post请求
 */
-(id)publicPostAnalyzeWithService:(NSString *)service parameters:(id)parameters canCache:(BOOL)can block:(AnalyzeObjectBlock)block{
   return  [ AnalyzeObject  publicPostAnalyzeWithService:service parameters:parameters canCache:can block:block];
}
+(id)publicPostAnalyzeWithService:(NSString *)service parameters:(id)parameters canCache:(BOOL)can block:(AnalyzeObjectBlock)block{
    
    YYCache *cache = [[YYCache alloc] initWithName:nameCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
    
   // dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        if (can) {
            id responseObject = [cache objectForKey:[service urlDictToStringWithDict:parameters]];
            if (responseObject) {
                [ AnalyzeObject  ControllerViewWithData:responseObject service:service Error:nil type:MNetworkTypePost block:block];
            }
        }
//        NSMutableDictionary *dic=[NSMutableDictionary new];
//        [dic setObject:service forKey:@"action"];
//        if (parameters) {
//            [dic addEntriesFromDictionary:parameters];
//        }
       // RM_Log(@"************ %@ **************** %@",service,parameters);
       // dispatch_group_enter([AnalyzeObject sharedInstance].group);
       return [[AFAppDotNetAPIClient sharedClient]POST:service parameters:parameters progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
           // RM_Log(@"******* %@", responseObject);
           // dispatch_group_leave([AnalyzeObject sharedInstance].group);
              NSString *code =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
            
            if([code integerValue] == 10008){
              [self publicPostAnalyzeWithService:service parameters:parameters canCache:can block:block];
            }else{
                if(can && [code integerValue] == 1){
                    [cache setObject:responseObject forKey:[service urlDictToStringWithDict:parameters]];
                }
                [ AnalyzeObject  ControllerViewWithData:responseObject service:service Error:nil type:MNetworkTypePost block:block];
            }
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
            RM_Log(@"====== error %@", error);
            //dispatch_group_leave([AnalyzeObject sharedInstance].group);
            if(error.code == -1005){
                [self publicPostAnalyzeWithService:service parameters:parameters canCache:can block:block];
            }else{
                [ AnalyzeObject ControllerViewWithData:nil service:service Error:error type:MNetworkTypePost block:block];
            }
        }];
   // });
}
/*
 *上传文件
 */
+(id)publicPostFileWithService:(NSString *)service parameters:(NSArray *)parameters block:(AnalyzeObjectBlock)block{
   // dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    
    AFAppDotNetAPIClient *apiClient = [AFAppDotNetAPIClient sharedClient];
   [apiClient.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
      return [apiClient POST:service parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
          
          NSString *name = @"file";
          if ([service isEqualToString:Kcommon_upload]) {
              name = @"files";
          }
          
            for (int i=0; i<parameters.count; i++) {
                [formData appendPartWithFileData:[parameters objectAtIndex:i] name:name fileName:[NSString stringWithFormat:@"files_%@.jpg",@(i)] mimeType:@"image/png"];
            }
        } progress:^(NSProgress *  uploadProgress) {
            
        } success:^(NSURLSessionDataTask *  task, id responseObject) {
            
            
            [AnalyzeObject ControllerViewWithData:responseObject service:service Error:nil  type:MNetworkTypePostFile block:block];
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
            RM_Log(@"====== error %@", error);
            if(error.code == -1005){
                [self publicPostFileWithService:service parameters:parameters block:block];
            }else{
                [ AnalyzeObject  ControllerViewWithData:nil service:service Error:error type:MNetworkTypePostFile block:block];
            }
        }];
}
-(id)publicPostFileWithService:(NSString *)service parameters:(NSArray *)parameters block:(AnalyzeObjectBlock)block{
   
   return [ AnalyzeObject  publicPostFileWithService:service parameters:parameters block:block];
}


+(void)ControllerViewWithData:(id) responseObject service:(NSString *)service Error:(NSError *)error type:(MNetworkType)type block:(AnalyzeObjectBlock)block {
    RM_Log(@"*********** %@",responseObject);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ResultObject *obj=[ ResultObject  modelWithJSON:responseObject];
        if (block) {
            if (!responseObject) {
                block(obj,error);
            } else {
                //NSArray *tokenArray = @[@"E0000001", @"E0000002", @"E0000003", @"E0000008", @"E1300020"];
                if (([obj.code isEqualToString:@"E0000001"] || [obj.code isEqualToString:@"E0000002"] || [obj.code isEqualToString:@"E0000003"])) {
                    for (NSURLSessionTask *task in [AFAppDotNetAPIClient sharedClient].tasks) {
                        [task cancel];
                    }
                    
                    NSString *email = [Stockpile sharedStockpile].userName;
                    NSString *pwd = [Stockpile sharedStockpile].password;
                    NSString *mac = [NSString getUUID];
                    
                    [[AnalyzeObject new] publicGetAnalyzeWithService:KgetSaltKey parameters:email block:^(ResultObject *obj, NSError *error) {
                        if (obj.success) {
                            NSString *saltKey = obj.payload.results[@"saltKey"];
                            if (saltKey) {
                                NSString *newPw = [NSString stringWithFormat:@"%@%@", saltKey, pwd];
                                newPw = [newPw md5String];
                                
                                [[AnalyzeObject new] publicPostAnalyzeWithService:Klogin parameters:[@{@"usr":email,@"pwd":newPw,@"payload":@{@"params":@{@"mac":mac}}} jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
                                    [self doRequestAgainWithService:service type:type obj:obj Error:error block:block];
                                }];
                            }
                        } else {
                            //重新登录
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
                        }
                    }];
                } else if ([obj.code isEqualToString:@"E0000008"]) {
                    for (NSURLSessionTask *task in [AFAppDotNetAPIClient sharedClient].tasks) {
                        [task cancel];
                    }
                    //refresh token and save the new token.
                    NSString *logotoken = [[NSUserDefaults standardUserDefaults] valueForKey:KUserDefaultLog_Token] ?: @"";
                    [[AnalyzeObject new] publicPostAnalyzeWithService:Ktoken_refresh parameters:[@{@"payload":@{@"params":@{@"refreshToken":logotoken,@"userId":[Stockpile sharedStockpile].userId}}} jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
                        if (obj.success) {
                            [[NSUserDefaults standardUserDefaults] setValue:obj.cmpId forKey:KUserDefaultCMP_ID];
                            [[NSUserDefaults standardUserDefaults] setValue:obj.token forKey:KUserDefaultLog_Token];
                            [Stockpile saveData:obj.payload.results];
                            //Refresh the token successfully and request again.
                            //静默登录完成，重新请求之前的接口.
                            [self doRequestSwitchWithService:service type:type obj:obj Error:error block:block];
                        } else {
                            //Refresh failed, login again.
                            NSString *email = [Stockpile sharedStockpile].userName;
                            NSString *pwd = [Stockpile sharedStockpile].password;
                            NSString *mac = [NSString getUUID];
                            if (!email || !pwd || !mac) {
                                //重新登录
                                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
                                return;
                            }
                            
                            [[AnalyzeObject new] publicGetAnalyzeWithService:KgetSaltKey parameters:email block:^(ResultObject *obj, NSError *error) {
                                if (obj.success) {
                                    NSString *saltKey = obj.payload.results[@"saltKey"];
                                    if (saltKey) {
                                        NSString *newPw = [NSString stringWithFormat:@"%@%@", saltKey, pwd];
                                        newPw = [newPw md5String];
                                        
                                        [[AnalyzeObject new] publicPostAnalyzeWithService:Klogin parameters:[@{@"usr":email,@"pwd":newPw,@"payload":@{@"params":@{@"mac":mac}}} jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
                                            [self doRequestAgainWithService:service type:type obj:obj Error:error block:block];
                                        }];
                                    }
                                } else {
                                    //重新登录
                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
                                }
                            }];
                        }
                    }];
                } else if ([obj.code isEqualToString:@"E1300020"]) {
                    for (NSURLSessionTask *task in [AFAppDotNetAPIClient sharedClient].tasks) {
                        [task cancel];
                    }
                    //Refresh failed, login again.
                    NSString *email = [Stockpile sharedStockpile].userName;
                    NSString *pwd = [Stockpile sharedStockpile].password;
                    NSString *mac = [NSString getUUID];
                    if (!email || !pwd || !mac) {
                        //重新登录
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
                        return;
                    }
                    
                    [[AnalyzeObject new] publicGetAnalyzeWithService:KgetSaltKey parameters:email block:^(ResultObject *obj, NSError *error) {
                        if (obj.success) {
                            NSString *saltKey = obj.payload.results[@"saltKey"];
                            if (saltKey) {
                                NSString *newPw = [NSString stringWithFormat:@"%@%@", saltKey, pwd];
                                newPw = [newPw md5String];
                                
                                [[AnalyzeObject new] publicPostAnalyzeWithService:Klogin parameters:[@{@"usr":email,@"pwd":newPw,@"payload":@{@"params":@{@"mac":mac}}} jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
                                    [self doRequestAgainWithService:service type:type obj:obj Error:error block:block];
                                }];
                            }
                        } else {
                            //重新登录
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
                        }
                    }];
                } else {
                    block(obj,error);
                }
            }
        }
    });
}

+(void)ControllerViewWithData:(id) responseObject  service:(NSString *)service Error:(NSError *)error block:(AnalyzeObjectBlock)block{
    RM_Log(@"*********** %@",responseObject);
    
    dispatch_async(dispatch_get_main_queue(), ^{
           ResultObject *obj=[ ResultObject  modelWithJSON:responseObject];
        if (block) {
            
            if (!responseObject) {
                block(obj,error);
            }else{
                if ( ([obj.code isEqualToString:@"E1300020"]||[obj.code isEqualToString:@"E0000001"]||[obj.code isEqualToString:@"E0000002"] || [obj.code isEqualToString:@"E0000003"]|| [obj.code isEqualToString:@"E0000008"])) {
                    for (NSURLSessionTask *task in [AFAppDotNetAPIClient sharedClient].tasks) {
                        [task cancel];
                    }
                    if (service && ![service isEqualToString:Ktoken_refresh]) {
                        if ([obj.code isEqualToString:@"E0000001"]||[obj.code isEqualToString:@"E0000008"]) {
                            //刷新
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReshTokenAction object:nil];
                        } else {
                            //重新登录
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
                        }
                         //[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReshTokenAction object:nil];
                    }
                }
                block(obj,error);
            }
        }
    });
}

+ (void)doRequestAgainWithService:(NSString *)service type:(MNetworkType)type obj:(ResultObject *)obj Error:(NSError *)error block:(AnalyzeObjectBlock)block {
    if (obj.success) {
        [[NSUserDefaults standardUserDefaults] setValue:obj.cmpId forKey:KUserDefaultCMP_ID];
        [[NSUserDefaults standardUserDefaults] setValue:obj.token forKey:KUserDefaultLog_Token];
        
        [[NSUserDefaults standardUserDefaults] setValue:obj.payload.results[@"userId"] forKey:KUserDefaultUSER_ID];
        NSString * zoneId = obj.payload.results[@"zoneId"];
        [[NSUserDefaults standardUserDefaults] setValue:zoneId forKey:KUserDefaultZoneID];
        [[NSUserDefaults standardUserDefaults] setValue:obj.payload.results[@"country"] forKey:KUserDefaultCuntryCode];
        
        [Stockpile saveData:obj.payload.results];
        
        [self doRequestSwitchWithService:service type:type obj:obj Error:error block:block];
    } else {
        //重新登录
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
    }
}

+ (void)doRequestSwitchWithService:(NSString *)service type:(MNetworkType)type obj:(ResultObject *)obj Error:(NSError *)error block:(AnalyzeObjectBlock)block {
    //静默登录完成，重新请求之前的接口.
    switch (type) {
        case MNetworkTypeGet:{
            [[AnalyzeObject new] publicGetAnalyzeWithService:service parameters:nil block:^(ResultObject *obj, NSError *error) {
                block(obj,error);
            }];
        }
            break;
        case MNetworkTypePost:{
            [[AnalyzeObject new] publicPostAnalyzeWithService:service parameters:nil block:^(ResultObject *obj, NSError *error) {
                block(obj,error);
            }];
        }
            break;
        case MNetworkTypePostFile:{
            [[AnalyzeObject new] publicPostFileWithService:service parameters:nil block:^(ResultObject *obj, NSError *error) {
                block(obj,error);
            }];
        }
            break;
        case MNetworkTypePut:{
            [[AnalyzeObject new] publicPutAnalyzeWithService:service parameters:nil block:^(ResultObject *obj, NSError *error) {
                block(obj,error);
            }];
        }
            break;
        case MNetworkTypePatch:{
            [[AnalyzeObject new] publicPatchAnalyzeWithService:service parameters:nil block:^(ResultObject *obj, NSError *error) {
                block(obj,error);
            }];
        }
            break;
        case MNetworkTypeDelete:{
            [[AnalyzeObject new] publicDeleteAnalyzeWithService:service parameters:nil block:^(ResultObject *obj, NSError *error) {
                block(obj,error);
            }];
        }
            break;
        default:
            block(obj,error);
            break;
    }
}

@end
