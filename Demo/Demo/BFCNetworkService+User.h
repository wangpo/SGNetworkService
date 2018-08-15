//
//  SGNetworkService+User.h
//  WPDevelopProject
//
//  Created by wangpo on 2018/3/6.
//  Copyright © 2018年 BaoFeng. All rights reserved.
//

#import "SGNetworkService.h"

@interface SGNetworkService (User)

/**
 post方法  url-form

 @param contact 联系方式
 @param text 反馈建议
 @param success
 @param failure
 @return 数据请求任务
 */
- (NSURLSessionDataTask *)bfc_postFeedBack:(NSString *)contact
                                      text:(NSString *)text
                           successCallback:(SuccessCallback)success
                           failureCallback:(FailureCallback)failure;


/**
 post multipart

 @param image 头像
 @param success
 @param failure
 @return  数据上传任务
 */
- (NSURLSessionDataTask *)bfc_uploadImage:(UIImage *)image
                          successCallback:(SuccessCallback)success
                          failureCallback:(FailureCallback)failure;

@end
