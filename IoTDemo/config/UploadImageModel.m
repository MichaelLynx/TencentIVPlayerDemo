//
//  UploadImageModel.m
//  TimeClock
//
//  Created by Apple on 2019/12/31.
//  Copyright © 2019 Apple. All rights reserved.
//
//------made in china-------
/**   The code comes frome breakfly
 *
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　━　　　┃
 * 　　┃ 　^      ^ 　┃
 * 　　┃　　　┻　　　┃
 * 　　┗━━━━━━━┛
 *
 * --------萌萌哒-------
 */
#import "UploadImageModel.h"
#import <objc/runtime.h>
#import "AnalyzeObject.h"
#import "MBProgressHUD+Add.h"
#import "UIImage+Helper.h"
@interface UploadImageModel ()

@end

@implementation UploadImageModel
//-(UIImage *)image{
//    if (self.data) {
//        return [UIImage imageWithData:self.data];
//    }
//    if (self.path_url) {
//        return [UIImage imageWithContentsOfFile:self.path_url.absoluteString];
//    }
//    return _image;
//}

-(void)setImage:(UIImage *)image{
    _image = [image imageByScalingToSize:CGSizeMake(900, 900)];
}

-(NSData *)data{
    if (!_data) {
        _data = UIImageJPEGRepresentation(self.image, 0.9);
    }
    return _data;
}

-(id)copyToModel:(UploadImageModel *)model{
//    Stockpile *model =[Stockpile sharedStockpile];
    if (model) {
        @try{
            unsigned int count =0;
            Ivar *ivars= class_copyIvarList([UploadImageModel class], &count);
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

@end
@implementation UploadImage
+(id)shareUpload{
    static UploadImage *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[UploadImage alloc] init];
    });
    return _sharedInstance;
}

+(void)uploadEmployeeFacesWithData:(UploadImageModel *)model block:(backBlock)block{
    [[AnalyzeObject new] publicPostFileWithService:Kfaces_enroll parameters:@[model.data] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            UploadImageModel *resulr = [UploadImageModel modelWithJSON:obj.payload.results];
            if (block) {
                block([resulr copyToModel:model]);
            }
        }else{
            if (block) {
                block(model);
            }
            [MBProgressHUD showMessage:obj.message];
        }
       }];
}

+(void)uploadAdminFacesWithData:(UploadImageModel *)model block:(backBlock)block{
    [[AnalyzeObject new] publicPostFileWithService:Kteams_employees_faces parameters:@[model.data] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            UploadImageModel *resulr = [UploadImageModel modelWithJSON:obj.payload.results];
            if (block) {
                block([resulr copyToModel:model]);
            }
        }else{
            if (block) {
                block(model);
            }
            [MBProgressHUD showMessage:obj.message];
        }
    }];
}
+(void)uploadCommontWithData:(NSArray<UploadImageModel*> *)model block:(backBlock)block{
    [[AnalyzeObject new] publicPostFileWithService:Kcommon_upload parameters:[model valueForKeyPath:@"@unionOfObjects.data"] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            NSArray *Arr = [obj.payload.results objectForKey:@"urls"];
            for (int i=0; i<Arr.count; i++) {
                UploadImageModel *mo = [model objectAtIndex:i];
                mo.url = [Arr objectAtIndex:i];
            }
        }else{
            [MBProgressHUD showMessage:obj.message];
        }
        if (block) {
            block(model);
        }
    }];
}

///Visitor-Visitor(check in status).
+(void)uploadVisitorAvatarWithData:(UploadImageModel *)model block:(backBlock)block {
    [[AnalyzeObject new] publicPostFileWithService:KvisitorUploadAvatar parameters:@[model.data] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            UploadImageModel *resulr = [UploadImageModel modelWithJSON:obj.payload.results[@"vo"]];
            if (block) {
                block([resulr copyToModel:model]);
            }
        }else{
            if (block) {
                block(model);
            }
            [MBProgressHUD showMessage:obj.message];
        }
    }];
}

@end
