//
//  NetClient+ToPaths.m
//  Carte
//
//  Created by CJK on 13-3-25.
//  Copyright (c) 2013年 cjk. All rights reserved.
//

#import "NetClient+ToPaths.h"
#import "KHHUser.h"
#import "UIImage+KHH.h"

@implementation NetClient (ToPaths)

- (void)getPath_:(NSString *)methodPath
      parameters:(NSDictionary *)parameters
         success:(void (^)(NSDictionary *responseDict))success
         failure:(void (^)(NSDictionary *responseDict))failure
{
    
    [self getPath:[self queryStringWithMethod:methodPath] parameters:parameters success:^( AFHTTPRequestOperation *operation, id responseObject){
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
}

- (void)doInselfPath:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSMutableDictionary *))failure
{
    [self doInselfPath:method methodPath:methodPath parameters:parameters success:success failure:failure arrImageDic:nil multipart:NO];
}

- (void)multipart:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure arrImageDic:(NSArray *)arrImageDic
{
    [self doInselfPath:method methodPath:methodPath parameters:parameters success:success failure:failure arrImageDic:arrImageDic multipart:YES];
}

- (void)multipart:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure
{
    [self doInselfPath:method methodPath:methodPath parameters:parameters success:success failure:failure arrImageDic:nil multipart:YES];
}

- (void)doInselfPath:(NSString *)method methodPath:(NSString *)methodPath parameters:(NSDictionary *)parameters success:(void (^)(NSMutableDictionary *responseDict))success failure:(void (^)(NSMutableDictionary *responseDict))failure arrImageDic:(NSArray *)arrImageDic multipart:(Boolean)multipart
{
    if ([self.r currentReachabilityStatus] == NotReachable) {
        if (failure) {
            NSMutableDictionary *result = [[NSMutableDictionary alloc]initWithCapacity:2];
            result[@"state"] = [NSNumber numberWithInt:-1003];
            result[@"note"] = @"网络连接不可用";
            failure(result);
        }
        return;
    }
    if (![KHHUser shareInstance].sessionId){
        if ([self defaultValueForHeader:@"authentication"]) {
            [self clearAuthorizationHeader];
        }
    }
    
    if ([KHHUser shareInstance].sessionId) {
        if (![self defaultValueForHeader:@"authentication"]||![[self defaultValueForHeader:@"authentication"] isEqualToString:[KHHUser shareInstance].sessionId]) {
            [self setDefaultHeader:@"authentication" value:[KHHUser shareInstance].sessionId];
        }
        
    }
    
  //  void (^weakSuccess)(NSMutableDictionary *responseDict)  = success;
    
    void (^success1)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject){
        NSMutableDictionary *responseDict = [self JSONDictionaryWithResponse:responseObject];
       
       
        if ([responseDict[@"state"] isEqualToNumber:[NSNumber numberWithInt:0]]||[responseDict[@"state"] isEqual:@"0"]) {          
            if (success) {
                success(responseDict);
            }
            return;
        }else{
            if (failure) {
                failure(responseDict);
            }
        }
        
    };
    
    void (^failure1)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSMutableDictionary *result = [[NSMutableDictionary alloc]initWithCapacity:2];
        result[@"state"] = [NSNumber numberWithInt:-1002];
        result[@"note"] = @"服务器忙，请稍后再试";
        if (failure) {
            failure(result);
        }
    };
    if (arrImageDic||multipart) {
        
        void(^construction)(id <AFMultipartFormData> formData);
        if (arrImageDic) {            
              construction = ^(id <AFMultipartFormData> formData) {                  
                  for (int i=0; i<[arrImageDic count]; i++) {
                      NSData *imageData = [[arrImageDic[i] allValues][0] resizedImageDataForKHHUpload];
                      [formData appendPartWithFileData:imageData
                                                  name:[arrImageDic[i] allKeys][0]
                                              fileName:@"imgs.jpg"
                                              mimeType:@"image/jpeg"];
                  }
                
            };
        }
       
        if ([method isEqualToString:@"put"]) {
            [self multipartFormRequestWithPUTPath:methodPath parameters:parameters constructingBodyWithBlock:construction success:success1 failure:failure1];
            return;
        }
        [self multipartFormRequestWithPOSTPath:methodPath parameters:parameters constructingBodyWithBlock:construction success:success1 failure:failure1];
         return;
    }
    
    if ([method isEqualToString:@"get"]) {
        [self getPath:[self queryStringWithMethod:methodPath] parameters:parameters success:success1 failure:failure1];
    }
    
    if ([method isEqualToString:@"post"]) {
        [self postPath:[self queryStringWithMethod:methodPath] parameters:parameters success:success1 failure:failure1];
    }
    
    if ([method isEqualToString:@"put"]) {
        [self putPath:[self queryStringWithMethod:methodPath] parameters:parameters success:success1 failure:failure1];
    }
    
    if ([method isEqualToString:@"delete"]) {
        [self deletePath:[self queryStringWithMethod:methodPath] parameters:parameters success:success1 failure:failure1];
    }
}

#pragma mark - do in self

- (NSString *)queryStringWithMethod:(NSString *) method
{
    NSLog(@"businesscard/%@",method);
    return [NSString stringWithFormat:@"businesscard/%@",method];
    
    NSMutableString *cellvisiting = [[NSMutableString alloc]init];
    
#ifdef HAIBO
    [cellvisiting appendString:@"businesscard"];
#else
    [cellvisiting appendString:@"cellvisiting"];
#endif
    
    if ([method isEqualToString:@"register"]) {
        return [NSString stringWithFormat:@"%@/account/register",cellvisiting];
    }
    if ([method isEqualToString:@"login"]) {
        
        return [NSString stringWithFormat:@"%@/account/login",cellvisiting];
    }
    if ([method rangeOfString:@"resetPwd"].location == 0) {
        return [NSString stringWithFormat:@"%@/account/%@",cellvisiting,method];
    }
    [cellvisiting appendString:@"/mobile/%@/%@/%@"];
    NSString *urlFormat = cellvisiting;
    return urlFormat;//[NSString stringWithFormat:urlFormat,[KHHUser shareInstance].sessionId ,[KHHUser shareInstance].companyId,method];
}



//解析返回结果
- (NSMutableDictionary *)JSONDictionaryWithResponse:(NSData *)responseData
{
    
    //    NSString *base64 = [[NSString alloc] initWithBytes:[responseData bytes]
    //                                                length:[responseData length]
    //                                              encoding:NSASCIIStringEncoding];
    // NSData *decodedData = [NSData dataWithBase64EncodedString:base64];
   
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
    // NSLog(@"%@",base64);
    NSMutableDictionary *result = dict;
    
    if (result[@"state"]) {
        NSNumber *state = result[@"state"];
        if ([state isEqualToNumber:[NSNumber numberWithInt:0]]) {
            return result;
        }
        if ([state isEqualToNumber:[NSNumber numberWithInt:-1000]]) {
            result[@"note"] = @"服务器忙，请稍后再试";
            return result;
        }
        
        if ([state isEqualToNumber:[NSNumber numberWithInt:-999]]) {
            result[@"note"] = @"无效的密钥";
            return result;
        }
        return result;
    }
    if (!result) {
        result = [[NSMutableDictionary alloc]initWithCapacity:2];
    }
    result[@"state"] = [NSNumber numberWithInt:-1001];
    result[@"note"] = @"服务器忙，请稍后再试";
    return result;
    
    
    
    
    
    NSNumber *state = result[@"state"];
    NSInteger code = 10000; //不可解析
    if (result) {
        if (state) {
            code = state.integerValue;
        } else {
            code = 3000;
        }
    } else {
        // 确保返回的 result 不是nil
        result = [NSMutableDictionary dictionaryWithCapacity:2];
        result[@"note"] = @"服务器忙，请稍后再试";
        result[@"state"] = [NSNumber numberWithInteger:code];
    }
    // 根据状态，插入errorCode
    
    // DLog(@"[II] result class = %@, value = %@", [result class], result);
    return result;
}

#pragma mark - 新增时，有文件要上传时的接口
- (void) multipartFormRequestWithPOSTPath:(NSString *)methodPath
                               parameters:(NSDictionary *)parameters
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))construction
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
   
    
    // 组合query url
    NSString *realpath = [self queryStringWithMethod:methodPath];
   
    
    NSURLRequest *request = [self
                             multipartFormRequestWithMethod:@"POST"
                             path:realpath
                             parameters:parameters
                             constructingBodyWithBlock:construction];
    AFHTTPRequestOperation *reqOperation = [self
                                            HTTPRequestOperationWithRequest:request
                                            success:success
                                            failure:failure];
    // 实际发送请求
    [self enqueueHTTPRequestOperation:reqOperation];
}

#pragma mark - 修改时，有文件要上传时的接口
- (void) multipartFormRequestWithPUTPath:(NSString *)methodPath
                              parameters:(NSDictionary *)parameters
               constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))construction
                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    
    // 组合query url
    NSString *realpath = [self queryStringWithMethod:methodPath];
    
    
    NSURLRequest *request = [self
                             multipartFormRequestWithMethod:@"PUT"
                             path:realpath
                             parameters:parameters
                             constructingBodyWithBlock:construction];
    AFHTTPRequestOperation *reqOperation = [self
                                            HTTPRequestOperationWithRequest:request
                                            success:success
                                            failure:failure];
    // 实际发送请求
    [self enqueueHTTPRequestOperation:reqOperation];
}

@end
