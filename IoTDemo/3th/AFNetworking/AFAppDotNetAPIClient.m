// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"
#import "DefaultPageSource.h"
#import "NSString+Encrypt.h"
#import "NSString+Helper.h"
#import "NSString+YYAdd.h"
#import "ClockObject.h"
static NSString * const AFAppDotNetAPIBaseURLString = @"";
static AFAppDotNetAPIClient *_sharedClient = nil;

@interface AFAppDotNetAPIClient()

@property(nonatomic,strong)AFHTTPSessionManager * httpManager;

@end

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *urlstring = [NSString stringWithFormat:@"%@%@",YuMing,AFAppDotNetAPIBaseURLString];
        _sharedClient = [AFAppDotNetAPIClient new];
        _sharedClient.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:urlstring]];
       [_sharedClient.httpManager.requestSerializer setTimeoutInterval:30];
    });
     [_sharedClient.httpManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return _sharedClient;
}


- (void)setUrl:(NSString *)url
{
    self.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    [self.httpManager.requestSerializer setTimeoutInterval:30];
    [self.httpManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

- ( AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer
{
    return self.httpManager.requestSerializer;
}

-(NSArray <NSURLSessionTask *> *)tasks
{
    return self.httpManager.tasks;
}


-(NSURLSessionDataTask *)PATCH:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure{
    return [_httpManager PATCH:URLString parameters:parameters headers:[self setHttpHeadersWithParameters:parameters] success:success failure:failure];
}
-(NSURLSessionDataTask *)HEAD:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure{
    
      return [_httpManager HEAD:URLString parameters:parameters headers:[self setHttpHeadersWithParameters:parameters] success:success failure:failure];
}

-(NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure{
    return [_httpManager PUT:URLString parameters:parameters headers:[self setHttpHeadersWithParameters:parameters] success:success failure:failure];
}
-(NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure{
    return [_httpManager DELETE:URLString parameters:parameters headers:[self setHttpHeadersWithParameters:parameters] success:success failure:failure];
}

-(NSURLSessionDataTask*)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure{
   // [self setHttpHeadDataWithURL:URLString];
    return [_httpManager GET:URLString parameters:parameters headers:[self setHttpHeadersWithParameters:parameters] progress:downloadProgress success:success failure:failure];
}
-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> obj))block progress:(void (^)(NSProgress * progress))uploadProgress success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure{
    //  [self setHttpHeadDataWithURL:URLString];
    return [_httpManager POST:URLString parameters:parameters headers:[self setHttpHeadersWithParameters:parameters] constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
}
-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * progress))uploadProgress success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure{
    
    return [_httpManager POST:URLString parameters:parameters headers:[self setHttpHeadersWithParameters:parameters] progress:uploadProgress success:success failure:failure];
}
-(NSDictionary *)setHttpHeadersWithParameters:(id)parameters{
    
    NSMutableDictionary *header=[NSMutableDictionary new];
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    
    [header setValue:LOCALIZATION(@"app_header_lang") forKey:@"lang"];
    [header setValue:@"application/json" forKey:@"Accept"];
    [header setValue:timeZone.name forKey:@"tz"];
    NSString *logotoken = [[NSUserDefaults standardUserDefaults] valueForKey:KUserDefaultLog_Token];
    if (logotoken && logotoken.length>0) {
        [header setValue:[NSString stringWithFormat:@"Bearer %@",logotoken] forKey:@"Authorization"];
    }
    
    return header;
}


//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    //
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if ([dict objectForKey:categoryId]) {
            NSString *value = [NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]];
            if (![value isEqualToString:@""]){
                [contentString appendFormat:@"&%@=%@", categoryId, [dict objectForKey:categoryId]];
            }
        }
    }
    if (contentString.length>0) {
        [contentString deleteCharactersInRange:NSMakeRange(0, 1)];
        //contentString = [contentString substringFromIndex:1];
    }
    
    
    NSString *md5Sign =[[NSString sha1:contentString] md5ForType:MD532UpCode];
    return md5Sign;
}

-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
@end
