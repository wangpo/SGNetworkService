//
//  SGNetworkService.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//  网络服务类

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
//请求方法
typedef NS_ENUM(NSInteger, SGRequestMethod) {
    SGRequestMethodGet = 0,//GET
    SGRequestMethodPost = 1,//POST
};

//按业务划分请求会话类型，区分不同的会话管理类
typedef NS_ENUM(NSInteger, SGHttpSessionType) {
    SGHttpSessionTypeService1,//业务1
    SGHttpsessionTypeService2,//业务2
    SGHttpsessionTypeService3,//业务3
};

typedef void (^SuccessCallback)(id data);//成功回调
typedef void (^FailureCallback)(NSError *error);//失败回调


@interface SGNetworkService : NSObject

@property (nonatomic, strong, readonly) AFHTTPRequestSerializer  *httpRequestSerializer;
@property (nonatomic, strong, readonly) AFJSONRequestSerializer  *jsonRequestSerializer;
@property (nonatomic, strong, readonly) AFJSONResponseSerializer *jsonResponseSerializer;

@property (nonatomic, strong, readonly) AFHTTPSessionManager *service1Client;
@property (nonatomic, strong, readonly) AFHTTPSessionManager *service2Client;
@property (nonatomic, strong, readonly) AFHTTPSessionManager *service3Client;

+ (instancetype)defaultService;
/**
 1、封装的get请求
 
 @param klass 接口以klass类返回
 @param sessionType 业务类型
 @param path 路径
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 @return 任务
 */
- (NSURLSessionDataTask *)sgcc_getModelClass:(Class)klass
                                sessionType:(SGHttpSessionType)sessionType
                                       path:(NSString *)path
                                 parameters:(id)parameters
                            successCallback:(SuccessCallback)success
                            failureCallback:(FailureCallback)failure;

/**
 2、封装的post请求
 
 @param klass 接口以klass类返回
 @param sessionType 业务类型
 @param path 路径
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 @return 任务
 */
- (NSURLSessionDataTask *)sgcc_postModelClass:(Class)klass
                                 sessionType:(SGHttpSessionType)sessionType
                                        path:(NSString *)path
                                  parameters:(id)parameters
                             successCallback:(SuccessCallback)success
                             failureCallback:(FailureCallback)failure;



/**
 Multi-Part Request
 
 @param klass 接口以klass类返回
 @param sessionType 业务类型
 @param path 路径
 @param parameters 参数
 @param block formData回调
 @param success 成功回调
 @param failure 失败回调
 @return 任务
 */
- (NSURLSessionDataTask *)sgcc_multipartPostModelClass:(Class)klass
                                          sessionType:(SGHttpSessionType)sessionType
                                                 path:(NSString *)path
                                           parameters:(id)parameters
                            constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                      successCallback:(SuccessCallback)success
                                      failureCallback:(FailureCallback)failure;



@end
