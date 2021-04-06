//
//  Localisator.h
//  CustomLocalisator
//
//  Created by Michael Azevedo on 05/03/2014.
//

#import <Foundation/Foundation.h>

#define LOCALIZATION(text) [[Localisator sharedInstance] localizedStringForKey:(text)]

static NSString * const kNotificationLanguageChanged = @"kNotificationLanguageChanged";

@interface Localisator : NSObject

@property (nonatomic, readonly) NSArray* availableLanguagesArray;
@property (nonatomic, assign) BOOL saveInUserDefaults;
@property(nonatomic,strong) NSString * currentLanguage;

+ (Localisator*)sharedInstance;
-(NSString *)localizedStringForKey:(NSString*)key;
-(BOOL)setLanguage:(NSString*)newLanguage;

//新增
+ (BOOL)isChinese;

@end
