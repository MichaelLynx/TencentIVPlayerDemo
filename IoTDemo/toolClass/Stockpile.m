//
//  Stockpile.m
//
//  Created by apple  on 2017/11/28
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Stockpile.h"
#import <objc/runtime.h>
#import "YYKit.h"
#import "NSString+Helper.h"
#import "AnalyzeObject.h"
#import "Localisator.h"
#import "DefaultPageSource.h"
#import "ReactiveCocoa.h"
static Stockpile *_instance = nil;

@implementation Stockpile

+(void)reshInfoWith:(void(^)(id obj))block{
    
    NSString *mac = [NSString getUUID];//@"8B0D8749-90EB-4276-A5C5-C29A1163F952";//
   //     //测试使用的设备ID
   #if DEBUG
        mac = @"8B0D8749-90EB-4276-A5C5-C29A1163F952";
    #endif
    
    NSString *usr =[Stockpile sharedStockpile].userName?:@"";
    NSString *pwd =[Stockpile sharedStockpile].password?:@"";
    
    if (usr.length<1 || pwd.length<1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
               
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:KLaseReshTokenTime];
         [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    
    
    [[AnalyzeObject new] publicGetAnalyzeWithService:KgetSaltKey parameters:usr block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            NSString *saltKey = obj.payload.results[@"saltKey"];
            if (saltKey) {
                NSString *newPw = [NSString stringWithFormat:@"%@%@", saltKey, pwd];
                newPw = [newPw md5String];
                
                [[AnalyzeObject new] publicPostAnalyzeWithService:Klogin parameters:[@{@"usr":usr,@"pwd":newPw,@"payload":@{@"params":@{@"mac":mac}}} jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
                    if (obj.success) {
                        [[NSUserDefaults standardUserDefaults] setValue:obj.cmpId forKey:KUserDefaultCMP_ID];
                          [[NSUserDefaults standardUserDefaults] setValue:obj.token forKey:KUserDefaultLog_Token];
                        [Stockpile saveData:obj.payload.results];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReshLogin object:nil];
                    }else{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
                        
                        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:KLaseReshTokenTime];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }];
            }
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
            
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:KLaseReshTokenTime];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}

+(void)reshToker:(void(^)(id obj))block{
     NSString *logotoken = [[NSUserDefaults standardUserDefaults] valueForKey:KUserDefaultLog_Token];
    
    //防止定数刷新崩溃
    if (!logotoken || ![Stockpile sharedStockpile].userId) {
        [Stockpile reshInfoWith:block];
        return;
    }
    
    [[AnalyzeObject new] publicPostAnalyzeWithService:Ktoken_refresh parameters:[@{@"payload":@{@"params":@{@"refreshToken":logotoken,@"userId":[Stockpile sharedStockpile].userId}}} jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            [[NSUserDefaults standardUserDefaults] setValue:obj.cmpId forKey:KUserDefaultCMP_ID];
            [[NSUserDefaults standardUserDefaults] setValue:obj.token forKey:KUserDefaultLog_Token];
            [Stockpile saveData:obj.payload.results];
        }else if([obj.code isEqualToString:@"E1300020"]||[obj.code isEqualToString:@"E0000001"]||[obj.code isEqualToString:@"E0000002"]||[obj.code isEqualToString:@"E0000003"]||[obj.code isEqualToString:@"E0000008"]) {
            //该判断及设置由请求体内部处理
            /*
            if ([obj.code isEqualToString:@"E0000001"]||[obj.code isEqualToString:@"E0000008"]) {
                [Stockpile reshInfoWith:block];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
            }
            */
            //[Stockpile reshInfoWith:block];
        }else if ([obj.code isEqualToString:@"E1300011"]||[obj.code isEqualToString:@"E1300013"]||[obj.code isEqualToString:@"E1300023"]||[obj.code isEqualToString:@"E1300024"]||[obj.code isEqualToString:@"E1300026"]||[obj.code isEqualToString:@"E1300027"]||[obj.code isEqualToString:@"E1300028"]||[obj.code isEqualToString:@"E1300003"]){
            //[Stockpile reshInfoWith:block];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
        }
    }];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:KLaseReshTokenTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //定时刷token——不再使用定时刷新的方式
    [SetTimeClockReshToken shareReshToken];
}

static dispatch_once_t onceToken;
+(instancetype)sharedStockpile{
    if (!_instance) {
        dispatch_once(&onceToken, ^{
            _instance=[Stockpile read];
            if (!_instance) {
                _instance=[[Stockpile alloc]init];
            }
        });
    }
   return _instance;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"tagId"           : @"id",
             };
}

#pragma mark - 序列化 & 反序列化

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self =[[Stockpile alloc]init];
    if (self) {
        @try{
            unsigned int count =0;
            Ivar *ivars= class_copyIvarList([Stockpile class], &count);
            for (int i=0 ;i<count;i++) {
                Ivar ivar = ivars[i];
                const char *name = ivar_getName(ivar);
                NSString *key =[NSString stringWithUTF8String:name];
                id value = [aDecoder decodeObjectForKey:key];
                [self setValue:value forKey:key];
            }
        }@catch(NSException *exception){} @finally{}
       
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    @try{
        unsigned int count =0;
        Ivar *ivars= class_copyIvarList([Stockpile class], &count);
        for (int i=0 ;i<count;i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key =[NSString stringWithUTF8String:name];
            id value = [self valueForKey:key];
            [aCoder encodeObject:value forKey:key];
        }
    }@catch(NSException *exception){} @finally{}
}

-(id)copyWithZone:(NSZone *)zone{
    Stockpile *model =[Stockpile sharedStockpile];
    if (model) {
        @try{
            unsigned int count =0;
            Ivar *ivars= class_copyIvarList([Stockpile class], &count);
            for (int i=0 ;i<count;i++) {
                Ivar ivar = ivars[i];
                const char *name = ivar_getName(ivar);
                NSString *key =[NSString stringWithUTF8String:name];
                id value = [self valueForKey:key];
                if (value) {
                      [model setValue:value forKey:key];
                }
            }
        }@catch(NSException *exception){} @finally{}
    }
    return model;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             
             };
}

-(void)destructionFile{
    unsigned int count =0;
    Ivar *ivars= class_copyIvarList([Stockpile class], &count);
    for (int i=0 ;i<count;i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key =[NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if (value != nil && [value isKindOfClass:[NSString class]] && (![key isEqualToString:@"_userName"] && ![key isEqualToString:@"_password"])) {
            value = @"";
        }else if ([value isKindOfClass:[NSNumber class]]){
            value = @0;
        }
        //反序列化
        [self setValue:value forKey:key];
    }
    [self save];
}

+(void)saveData:(id)data{
    Stockpile *stock=[Stockpile modelWithJSON:data];
   // [stock copy];
    [[stock copy] save];
}

-(void)save{
    NSString *temp = NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingPathComponent:@"Stockpile.key"];
   // NSDictionary *dic = [self yy_modelToJSONObject];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
  
}

+(void)attemptDealloc{
    onceToken = 0; //
    _instance = nil;
}

+(Stockpile *)read{
    NSString *temp = NSTemporaryDirectory();
    NSString *filePath = [temp stringByAppendingPathComponent:@"Stockpile.key"];
    Stockpile *sto  = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    //Stockpile *sto = [Stockpile yy_modelWithJSON:dic];
    if(!sto){
        [sto save];
    }
    return   sto;
}

-(BOOL)isLogin{
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"logo_token"];
    return ![token isEmptyString] && token;
}

-(NSString *)token{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"logo_token"];
}

-(NSString *)employeeId{
    if (!_employeeId) {
        _employeeId=@"";
    }
    return _employeeId;
}

-(NSString *)faceRequestId{
    if (!_faceRequestId) {
        _faceRequestId=@"";
    }
    return _faceRequestId;
}

//
-(NSString *)userSex{
    if (self.gender  == 2) {
       return LOCALIZATION(@"my_personal_gender_women");
        
    }else if (self.gender == 1) {
        return LOCALIZATION(@"my_personal_gender_man");
    }
   return LOCALIZATION(@"my_personal_gender_other");
}

-(NSString *)birthDateFormate{
    if (!self.birthDate || [self.birthDate isEqualToString:@"-1"]) {
        _birthDateFormate = @"";
    }else{
        
        _birthDateFormate = [BasicConfiguration getTimestamp:self.birthDate formatter:BasiceDateYMD];
    }
    return _birthDateFormate;
}

//使用[BasicConfiguration sharedInstance].timeFormateType
//时间格式 0：24小时制，1：12小时制(AM/PM).日期格式依从BasicConfiguration
- (NSInteger)timeFormat {
    NSString *format = [BasicConfiguration sharedInstance].timeFormate;
    if ([format isEqualToString:@"hh:mm a"]) {
        return 1;
    } else {
        return 0;
    }
}

- (NSString *)dateFormat {
    return [BasicConfiguration sharedInstance].dateFormate;
}

-(NSString *)hireDateFormate{
    if (!self.hireDate || [self.hireDate isEqualToString:@"-1"]) {
        _hireDateFormate = @"";
    }else{
        
        _hireDateFormate = [BasicConfiguration getTimestamp:self.hireDate formatter:BasiceDateYMD];
        
    }
    return _hireDateFormate;
}
@end

@implementation SetTimeClockReshToken
static SetTimeClockReshToken *t_instance = nil;
static dispatch_once_t timeToken;

+(id)shareReshToken{
    if (!t_instance) {
         dispatch_once(&timeToken, ^{
                t_instance=[[SetTimeClockReshToken alloc]init];
             
             [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNotificationReshTokenAction object:nil] subscribeNext:^(id x) {
                 [t_instance timeji_resh];
             }];
         });
     }
    return t_instance;
}

-(id)init{
    self=[super init];
    if (self) {
        self.timer= [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(timeji_resh) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
    }
    return self;
}

-(void)timeji_resh{
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setValue:date forKey:KLaseReshTokenTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [Stockpile reshToker:^(id obj) { }];
}

@end
