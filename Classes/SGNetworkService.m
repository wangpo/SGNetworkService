//
//  SGNetworkService.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGNetworkService.h"
#import "SGNetworkEnvelop.h"
#import "NSError+SGCC.h"

#define SG_PROPERTY_LOCK(name) \
@synchronized (name) { \
if (!name) { \
do {} while(0)

#define SG_PROPERTY_UNLOCK() \
}} do {} while(0)

static NSString * const KSGNetworkAPIURLString_Service1 = @"https://liebao.sports.baofeng.com/";
static NSString * const KSGNetworkAPIURLString_Service2 = @"http://m.liebao.sports.baofeng.com/";
static NSString * const KSGNetworkAPIURLString_Service3 = @"https://fort.sports.baofeng.com/";

@interface SGNetworkService ()

@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;

@end

@implementation SGNetworkService

@synthesize service1Client = _service1Client;
@synthesize service2Client = _service2Client;
@synthesize service3Client = _service3Client;

@synthesize httpRequestSerializer = _httpRequestSerializer;
@synthesize jsonRequestSerializer = _jsonRequestSerializer;
@synthesize jsonResponseSerializer = _jsonResponseSerializer;

+ (instancetype) defaultService
{
    static SGNetworkService *_defaultService = nil;
    static dispatch_once_t _onceToken;
    dispatch_once (&_onceToken, ^ () {
        _defaultService = [[self alloc] init];
    });
    return _defaultService;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.networkStatus = AFNetworkReachabilityStatusUnknown;
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            self.networkStatus = status;
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}

#pragma mark - 根据不同的服务创建不同的会话管理类
- (AFHTTPSessionManager *)service1Client {
    SG_PROPERTY_LOCK(_service1Client);
    NSURL *baseURL = [NSURL URLWithString:[KSGNetworkAPIURLString_Service1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest = 15.f;
    sessionConfiguration.timeoutIntervalForResource = 30.f;
    _service1Client = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL
                                               sessionConfiguration:sessionConfiguration];
    _service1Client.requestSerializer = self.jsonRequestSerializer;
    _service1Client.responseSerializer = self.jsonResponseSerializer;
    SG_PROPERTY_UNLOCK();
    return _service1Client;
}

- (AFHTTPSessionManager *)service2Client {
    SG_PROPERTY_LOCK(_service2Client);
    NSURL *baseURL = [NSURL URLWithString:[KSGNetworkAPIURLString_Service2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest = 15.f;
    sessionConfiguration.timeoutIntervalForResource = 30.f;
    _service2Client = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL
                                               sessionConfiguration:sessionConfiguration];
    _service2Client.requestSerializer = self.httpRequestSerializer;
    _service2Client.responseSerializer = self.jsonResponseSerializer;
    SG_PROPERTY_UNLOCK();
    return _service2Client;
}

- (AFHTTPSessionManager *)service3Client {
    SG_PROPERTY_LOCK(_service3Client);
    NSURL *baseURL = [NSURL URLWithString:[KSGNetworkAPIURLString_Service3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest = 15.f;
    sessionConfiguration.timeoutIntervalForResource = 30.f;
    _service3Client = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL
                                               sessionConfiguration:sessionConfiguration];
    _service3Client.requestSerializer = self.jsonRequestSerializer;
    _service3Client.responseSerializer = self.jsonResponseSerializer;
    SG_PROPERTY_UNLOCK();
    return _service3Client;
}

#pragma mark - 请求相应序列化

/**
  Content-Type: application/x-www-form-urlencoded
 1、GET请求
 Query String Parameter Encoding
 GET http://example.com?foo=bar&baz[]=1&baz[]=2&baz[]=3
 
 2、POST请求
 URL Form Parameter Encoding
 POST http://example.com/
 foo=bar&baz[]=1&baz[]=2&baz[]=3
 */
- (AFHTTPRequestSerializer *)httpRequestSerializer {
    SG_PROPERTY_LOCK(_httpRequestSerializer);
    _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    SG_PROPERTY_UNLOCK();
    return _httpRequestSerializer;
}

/**
 3、POST请求
 POST http://example.com/
 Content-Type: application/json
 {"foo": "bar", "baz": [1,2,3]}
 */
- (AFJSONRequestSerializer *)jsonRequestSerializer {
    SG_PROPERTY_LOCK(_jsonRequestSerializer);
    _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    SG_PROPERTY_UNLOCK();
    return _jsonRequestSerializer;
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    SG_PROPERTY_LOCK(_jsonResponseSerializer);
    _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    SG_PROPERTY_UNLOCK();
    return _jsonResponseSerializer;
}

#pragma mark - 请求方法
- (NSURLSessionDataTask *)sgcc_requsetWithMethod:(SGRequestMethod)requestMethod
                                    sessionType:(SGHttpSessionType)sessionType
                                     modelClass:(Class)klass
                                           path:(NSString *)path
                                     parameters:(id)parameters
                                successCallback:(SuccessCallback)success
                                failureCallback:(FailureCallback)failure {
    if (self.networkStatus == AFNetworkReachabilityStatusNotReachable) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure([NSError sgcc_errorWithCode:SGNetLinkError description:@"似乎已断开与互联网的连接。"]);
        });
        return nil;
    }
    #warning ...根据不同服务，定义不同的SessionManager
    AFHTTPSessionManager *sessionManager = nil;
    if (sessionType == SGHttpSessionTypeService1) {
        sessionManager = self.service1Client;
    } else if (sessionType == SGHttpsessionTypeService2){
        sessionManager = self.service2Client;
    }else if (sessionType == SGHttpsessionTypeService3){
        sessionManager = self.service3Client;
    }
    //...继续拓展
    
    NSURLSessionDataTask *dataTask = nil;
    if (requestMethod == SGRequestMethodGet) {
        dataTask = [sessionManager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            SGNetworkEnvelop *responseEnvelop = [SGNetworkEnvelop modelWithJSON:responseObject];
            if (!responseEnvelop) {
                failure([NSError sgcc_errorWithCode:SGDataFormatError description:nil]);
                return;
            }else if (responseEnvelop.errorCode != SGSuccess) {
                failure([NSError sgcc_errorWithCode:responseEnvelop.errorCode description:responseEnvelop.errorMessage]);
                return;
            }
            if (responseEnvelop.data) {
                if ([klass respondsToSelector:@selector(modelWithJSON:)]) {
                    success([klass modelWithJSON:responseEnvelop.data]);
                    return;
                }
            }
            NSError *error = [NSError sgcc_errorWithCode:SGDataFormatError description:@"invalid json format"];
            failure(error);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
        
    } else if (requestMethod == SGRequestMethodPost) {
        dataTask = [sessionManager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            SGNetworkEnvelop *responseEnvelop = [SGNetworkEnvelop modelWithJSON:responseObject];
            if (!responseEnvelop) {
                failure([NSError sgcc_errorWithCode:SGDataFormatError description:nil]);
                return;
            }else if (responseEnvelop.errorCode != SGSuccess) {
                failure([NSError sgcc_errorWithCode:responseEnvelop.errorCode description:responseEnvelop.errorMessage]);
                return;
            }
            if (responseEnvelop.data) {
                if ([klass respondsToSelector:@selector(modelWithJSON:)]) {
                    success([klass modelWithJSON:responseEnvelop.data]);
                    return;
                }
            }
            NSError *error = [NSError sgcc_errorWithCode:SGDataFormatError description:@"invalid json format"];
            failure(error);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
        
    }
    return dataTask;
}



/**
 Upload Task for a Multi-Part Request

 multipart/form-data
 */
- (NSURLSessionDataTask *)sgcc_multipartPostModelClass:(Class)klass
                                          sessionType:(SGHttpSessionType)sessionType
                                                 path:(NSString *)path
                                           parameters:(id)parameters
                            constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                      successCallback:(SuccessCallback)success
                                      failureCallback:(FailureCallback)failure;
{
    if (self.networkStatus == AFNetworkReachabilityStatusNotReachable) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure([NSError sgcc_errorWithCode:SGNetLinkError description:@"似乎已断开与互联网的连接。"]);
        });
        return nil;
    }
    //...根据不同服务，定义不同的SessionManager
    AFHTTPSessionManager *sessionManager = nil;
    if (sessionType == SGHttpsessionTypeService3) {
        sessionManager = self.service3Client;
    }
    NSURLSessionDataTask * dataTask = [sessionManager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SGNetworkEnvelop *responseEnvelop = [SGNetworkEnvelop modelWithJSON:responseObject];
        if (!responseEnvelop) {
            failure([NSError sgcc_errorWithCode:SGDataFormatError description:nil]);
            return;
        }else if (responseEnvelop.errorCode != SGSuccess) {
            failure([NSError sgcc_errorWithCode:responseEnvelop.errorCode description:responseEnvelop.errorMessage]);
            return;
        }
        if (responseEnvelop.data) {
            if ([klass respondsToSelector:@selector(modelWithJSON:)]) {
                success([klass modelWithJSON:responseEnvelop.data]);
                return;
            }
        }
        NSError *error = [NSError sgcc_errorWithCode:SGDataFormatError description:@"invalid json format"];
        failure(error);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return dataTask;
    
}

- (NSURLSessionDataTask *)sgcc_getModelClass:(Class)klass
                                sessionType:(SGHttpSessionType)sessionType
                                       path:(NSString *)path
                                 parameters:(id)parameters
                            successCallback:(SuccessCallback)success
                            failureCallback:(FailureCallback)failure
{
    return [self sgcc_requsetWithMethod:SGRequestMethodGet
                           sessionType:sessionType
                            modelClass:klass
                                  path:path
                            parameters:parameters
                       successCallback:success
                       failureCallback:failure];
}

- (NSURLSessionDataTask *)sgcc_postModelClass:(Class)klass
                                 sessionType:(SGHttpSessionType)sessionType
                                        path:(NSString *)path
                                  parameters:(id)parameters
                             successCallback:(SuccessCallback)success
                             failureCallback:(FailureCallback)failure
{
    return [self sgcc_requsetWithMethod:SGRequestMethodPost
                           sessionType:sessionType
                            modelClass:klass
                                  path:path
                            parameters:parameters
                       successCallback:success
                       failureCallback:failure];
}
@end
