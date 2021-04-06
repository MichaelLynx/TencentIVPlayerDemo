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

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFAppDotNetAPIClient : NSObject

- ( AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;
-(NSArray <NSURLSessionTask *> *)tasks;
+ (instancetype)sharedClient;
- (void)setUrl:(NSString *)url;
//重写方法

-(NSURLSessionDataTask *)PATCH:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure;

-(NSURLSessionDataTask *)HEAD:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure;

-(NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure;

-(NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure;

-(NSURLSessionDataTask*)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure;

-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * progress))uploadProgress success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure;

-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> obj))block progress:(void (^)(NSProgress * progress))uploadProgress success:(void (^)(NSURLSessionDataTask * data, id obj))success failure:(void (^)(NSURLSessionDataTask * data, NSError * error))failure;
@end
