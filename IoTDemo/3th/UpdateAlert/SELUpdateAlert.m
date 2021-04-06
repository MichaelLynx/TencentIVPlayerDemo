//
//  SELUpdateAlert.m
//  SelUpdateAlert
//
//  Created by zhuku on 2018/2/7.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SELUpdateAlert.h"
#import "SELUpdateAlertConst.h"
#import "Localisator.h"
#import "DefaultPageSource.h"
#define DEFAULT_MAX_HEIGHT SCREEN_HEIGHT/3*2

@interface SELUpdateAlert()

/** 版本号 */
@property (nonatomic, copy) NSString *version;
/** 版本更新内容 */
@property (nonatomic, copy) NSString *desc;

@property(nonatomic,assign)NSInteger is_force;
@end

@implementation SELUpdateAlert

/**
 添加版本更新提示

 @param version 版本号
 @param descriptions 版本更新内容（数组）
 
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions
{
    if (!descriptions || descriptions.count == 0) {
        return;
    }
    
    //数组转换字符串，动态添加换行符\n
    NSString *description = @"";
    for (NSInteger i = 0;  i < descriptions.count; ++i) {
        id desc = descriptions[i];
        if (![desc isKindOfClass:[NSString class]]) {
            return;
        }
        description = [description stringByAppendingString:desc];
        if (i != descriptions.count-1) {
            description = [description stringByAppendingString:@"\n"];
        }
    }
    NSLog(@"====%@",description);
    SELUpdateAlert *updateAlert = [[SELUpdateAlert alloc]initVersion:version description:description Force:1];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}

/**
 添加版本更新提示

 @param version 版本号
 @param description 版本更新内容（字符串）
 
description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description
{
    SELUpdateAlert *updateAlert = [[SELUpdateAlert alloc]initVersion:version description:description Force:1];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}
+ (void)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description Force:(NSInteger)force {
    SELUpdateAlert *updateAlert = [[SELUpdateAlert alloc]initVersion:version description:description Force:force];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}
- (instancetype)initVersion:(NSString *)version description:(NSString *)description Force:(NSInteger)force
{
    self = [super init];
    if (self) {
        self.version = version;
        self.desc = description;
        self.is_force = force;
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    /*
    //获取更新内容高度
    CGFloat descHeight = [self _sizeofString:self.desc font:[UIFont systemFontOfSize:SELDescriptionFont] maxSize:CGSizeMake(self.frame.size.width - Ratio(80) - Ratio(56), 1000)].height;
    
    //bgView实际高度
    CGFloat realHeight = descHeight + Ratio(314);
    
    //bgView最大高度
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    //更新内容可否滑动显示
    BOOL scrollEnabled = NO;
    
    //重置bgView最大高度 设置更新内容可否滑动显示
    if (realHeight > DEFAULT_MAX_HEIGHT) {
        scrollEnabled = YES;
        descHeight = DEFAULT_MAX_HEIGHT - Ratio(314);
    }else
    {
        maxHeight = realHeight;
    }
    maxHeight = Ratio(258);
    //backgroundView
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.center = self.center;
//    bgView.image = [UIImage imageNamed:@"ico_70"];
    bgView.image = [[UIImage imageNamed:@"ico_70"] hts_imageFlippedForRightToLeftLayoutDirection];
    bgView.userInteractionEnabled = YES;//maxHeight+
    bgView.bounds = CGRectMake(0, 0, self.frame.size.width - Ratio(40),maxHeight+ Ratio(20));
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(AutoSize(330), AutoSize(400)));
        make.center.equalTo(self);
    }];
    
    //添加更新提示
    UIView *updateView = [[UIView alloc]initWithFrame:CGRectMake(Ratio(0), Ratio(0), bgView.frame.size.width - Ratio(0), bgView.frame.size.height)];
    updateView.backgroundColor = [UIColor clearColor];
    //updateView.layer.masksToBounds = YES;
    //updateView.layer.cornerRadius = 4.0f;
    [bgView addSubview:updateView];
    
    [updateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(bgView);
        make.trailing.equalTo(bgView).offset(-AutoSize(5));
        make.top.equalTo(bgView).offset(AutoSize(35));
    }];
    
    //20+166+10+28+10+descHeight+20+40+20 = 314+descHeight 内部元素高度计算bgView高度
//    UIImageView *updateIcon = [[UIImageView alloc]initWithFrame:CGRectMake((updateView.frame.size.width - Ratio(178))/2, Ratio(20), Ratio(178), Ratio(166))];
//    updateIcon.image = [UIImage imageNamed:@"VersionUpdate_Icon"];
//    [updateView addSubview:updateIcon];
    
    //版本号
    //    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Ratio(10) + CGRectGetMaxY(updateIcon.frame), updateView.frame.size.width, Ratio(28))];
    //    versionLabel.font = [UIFont boldSystemFontOfSize:18];
    //    versionLabel.textAlignment = NSTextAlignmentCenter;
    //    versionLabel.text = [NSString stringWithFormat:@"发现新版本 V%@",self.version];
    //    [updateView addSubview:versionLabel];
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Ratio(45) , updateView.frame.size.width, Ratio(28))];
    versionLabel.font = AutoBoldFontSize(28);
    //versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text =[NSString stringWithFormat:@"%@ %@", LOCALIZATION(@"new_version"),self.version];
    versionLabel.numberOfLines = 3;
    versionLabel.textColor = whiteLineColore;
    [updateView addSubview:versionLabel];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.bottom.equalTo(bgView);
        make.leading.equalTo(updateView).offset(AutoSize(20));
        make.top.equalTo(updateView).offset(AutoSize(23));
        make.trailing.lessThanOrEqualTo(updateView).offset(AutoSize(-130));
    }];
    
    //更新内容
    UITextView *descTextView = [[UITextView alloc]initWithFrame:CGRectMake(Ratio(25), Ratio(35) + CGRectGetMaxY(versionLabel.frame), updateView.frame.size.width - Ratio(50), updateView.frame.size.height - Ratio(172))];
    descTextView.font = AutoNormalFontSize(14);
    //descTextView.backgroundColor = redTextColor;
    descTextView.textContainer.lineFragmentPadding = 0;
    descTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    descTextView.text = self.desc;
    descTextView.editable = NO;
    descTextView.selectable = NO;
    descTextView.scrollEnabled = scrollEnabled;
    descTextView.showsVerticalScrollIndicator = scrollEnabled;
    descTextView.showsHorizontalScrollIndicator = NO;
    [updateView addSubview:descTextView];
    
    [descTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(updateView).offset(AutoSize(23));
        make.trailing.lessThanOrEqualTo(updateView).offset(AutoSize(-23));
        make.top.equalTo(updateView).offset(AutoSize(170));
        make.height.mas_lessThanOrEqualTo(AutoSize(125));
    }];
    
    if (scrollEnabled) {
        //若显示滑动条，提示可以有滑动条
        [descTextView flashScrollIndicators];
    }
    */
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.center = self.center;
    bgView.image = [[UIImage imageNamed:@"updated_bg"] hts_imageFlippedForRightToLeftLayoutDirection];
    bgView.userInteractionEnabled = YES;
    bgView.bounds = CGRectMake(0, 0, Ratio(300), Ratio(241));
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(AutoSize(300), AutoSize(241)));
        make.center.equalTo(self);
    }];
    
    UILabel *versionLabel = [[UILabel alloc]init];
    versionLabel.font = AutoBoldFontSize(24);
    versionLabel.text = LOCALIZATION(@"new_version");
    versionLabel.numberOfLines = 3;
    versionLabel.textColor = whiteLineColore;
    [bgView addSubview:versionLabel];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(40);
        make.left.equalTo(bgView).offset(22);
        make.right.equalTo(bgView).offset(-22);
    }];
    
    UILabel *latestDesLb = [UILabel new];
    latestDesLb.font = AutoNormalFontSize(15);
    latestDesLb.text = LOCALIZATION(@"latest_version:");
    latestDesLb.textColor = RGB(77, 77, 77);
    [bgView addSubview:latestDesLb];
    
    [latestDesLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(21);
        make.top.equalTo(bgView).offset(AutoSize(142));
    }];
    
    UILabel *latestLb = [UILabel new];
    latestLb.font = AutoNormalFontSize(15);
    latestLb.text = [NSString stringWithFormat:@"V%@", self.version];
    latestLb.textColor = DEFAULTSECTIONTITLECOLOR;
    [bgView addSubview:latestLb];
    
    [latestLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(latestDesLb.mas_right).offset(9);
        make.top.equalTo(latestDesLb);
    }];
    
    if (self.is_force == 1) {
        //更新按钮
        UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [updateButton setBackgroundImage:[UIImage imageNamed:@"button_green"] forState:(UIControlStateNormal)];
        updateButton.clipsToBounds = YES;
        [updateButton roundSize:AutoSize(4.5)];
        [updateButton addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
        [updateButton setTitle:LOCALIZATION(@"btn_updated") forState:UIControlStateNormal];
        updateButton.titleLabel.font = AutoNormalFontSize(15);
        [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bgView addSubview:updateButton];
        
        [updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView);
            make.leading.mas_equalTo(AutoSize(50));
            //make.size.equalTo(cancelButton);
            make.height.mas_equalTo(AutoSize(36));
            make.baseline.equalTo(bgView).offset(-AutoSize(30));
        }];
    }else{
        //取消按钮
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelButton.right = bgView.width/2.0-Ratio(13);
        [cancelButton setTitle:LOCALIZATION(@"btn_cancle") forState:UIControlStateNormal];
        cancelButton.titleLabel.font = AutoNormalFontSize(15);
        [cancelButton setTitleColor:DEFAULTSECTIONTITLECOLOR forState:UIControlStateNormal];
        cancelButton.clipsToBounds = YES;
        [cancelButton roundSize:AutoSize(4.5)];
        cancelButton.layer.borderWidth = 0.5;
        cancelButton.layer.borderColor = DEFAULTSECTIONTITLECOLOR.CGColor;
         [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
         [bgView addSubview:cancelButton];
        
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(bgView).offset(AutoSize(20));
            make.height.mas_equalTo(AutoSize(36));
            make.baseline.equalTo(bgView).offset(-AutoSize(30));
        }];
        
        //更新按钮
        UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [updateButton setBackgroundImage:[UIImage imageNamed:@"button_green"] forState:(UIControlStateNormal)];
        [updateButton roundSize:AutoSize(4.5)];
        [updateButton addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
        [updateButton setTitle:LOCALIZATION(@"btn_updated") forState:UIControlStateNormal];
        updateButton.titleLabel.font = AutoNormalFontSize(15);
        [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bgView addSubview:updateButton];
        
        [updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(bgView).offset(-AutoSize(20));
            make.leading.equalTo(cancelButton.mas_trailing).offset(AutoSize(12));
            make.size.equalTo(cancelButton);
            make.baseline.equalTo(bgView).offset(-AutoSize(30));
        }];
    }
    
    //取消按钮
   /* UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.center = CGPointMake(CGRectGetMaxX(updateView.frame), CGRectGetMinY(updateView.frame));
    cancelButton.bounds = CGRectMake(0, 0, Ratio(36), Ratio(36));
    [cancelButton setImage:[[UIImage imageNamed:@"VersionUpdate_Cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelButton];*/
    
    //显示更新
    [self showWithAlert:bgView];
}

/** 更新按钮点击事件 跳转AppStore更新 */
- (void)updateVersion
{
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", APP_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/** 取消按钮点击事件 */
- (void)cancelAction
{
    [self dismissAlert];
}

/**
 添加Alert入场动画
 @param alert 添加动画的View
 */
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = SELAnimationTimeInterval;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}


/** 添加Alert出场动画 */
- (void)dismissAlert{
    
    [UIView animateWithDuration:SELAnimationTimeInterval animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

/**
 计算字符串高度
 @param string 字符串
 @param font 字体大小
 @param maxSize 最大Size
 @return 计算得到的Size
 */
- (CGSize)_sizeofString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}




@end
