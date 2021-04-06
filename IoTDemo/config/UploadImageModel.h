//
//  UploadImageModel.h
//  TimeClock
//
//  Created by Apple on 2019/12/31.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "BaseModel.h"
#import "DefaultBlock.h"
NS_ASSUME_NONNULL_BEGIN

@interface UploadImageModel : BaseModel
@property (nonatomic, strong) NSString *url;//oss返回路径
@property (nonatomic, strong) NSString *faceUrl;//oss返回路径
@property (nonatomic, strong) NSString *avatarUrl;//oss返回路径
@property (nonatomic, strong) NSURL *path_url;//本地图片路径
@property (nonatomic, strong) NSData *data;//图片data
@property(nonatomic,strong)UIImage *image;

-(id)copyToModel:(UploadImageModel *)model;
@end

@interface UploadImage :BaseModel
+(id)shareUpload;
+(void)uploadEmployeeFacesWithData:(UploadImageModel *)model block:(backBlock)block;

+(void)uploadAdminFacesWithData:(UploadImageModel *)model block:(backBlock)block;

+(void)uploadCommontWithData:(NSArray<UploadImageModel*> *)model block:(backBlock)block;

///Visitor-Visitor(check in status).
+(void)uploadVisitorAvatarWithData:(UploadImageModel *)model block:(backBlock)block;

@end
NS_ASSUME_NONNULL_END
