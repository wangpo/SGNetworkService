//
//  BFCNetworkService+User.m
//  WPDevelopProject
//
//  Created by wangpo on 2018/3/6.
//  Copyright © 2018年 BaoFeng. All rights reserved.
//

#import "BFCNetworkService+User.h"
#import "SGNetworkEnvelop.h"
#import "NSError+SGCC.h"
#import "BFCUploadImageEnvelop.h"

@implementation SGNetworkService (User)
- (NSURLSessionDataTask *)bfc_postFeedBack:(NSString *)contact
                                      text:(NSString *)text
                           successCallback:(SuccessCallback)success
                           failureCallback:(FailureCallback)failure
{
    if (![contact isNotBlank]) {
        contact = @"";
    }
    if (![text isNotBlank]) {
        failure([NSError sgcc_errorWithCode:SGParametersError description:@"参数错误"]);
        return nil;
    }
   return [self sgcc_postModelClass:[SGNetworkEnvelop class] sessionType:SGHttpsessionTypeService2 path:@"/feedback/add" parameters:@{@"text":text,@"contact":contact,@"app_version":[UIApplication sharedApplication].appVersion} successCallback:success failureCallback:failure];
}


- (NSURLSessionDataTask *)bfc_uploadImage:(UIImage *)image
                          successCallback:(SuccessCallback)success
                          failureCallback:(FailureCallback)failure
{
    if (!(image && [image isKindOfClass:[UIImage class]])) {
        failure([NSError sgcc_errorWithCode:SGParametersError description:@"参数错误"]);
        return nil;
    }
    return [self sgcc_multipartPostModelClass:[BFCUploadImageEnvelop class]
                                 sessionType:SGHttpsessionTypeService3
                                        path:@"fast.liebao.sports.baofeng.com/user/avatar/update"
                                  parameters:@{@"token": @"bMwqql1fuvkXDOaow6IDeiCBFVoaS69bPPD_Yzbzvm4=", @"image": image}
                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                                float fileLength = [imageData length];
                                float maxLength = 1024 * 1024; //上传图片大小不超过 1mb
                                if (fileLength > maxLength) {
                                    imageData = UIImageJPEGRepresentation(image, maxLength / fileLength);
                                }
                                [formData appendPartWithFileData:imageData name:@"image" fileName:@"imageFile" mimeType:@"image/jpeg"];
                            }
                             successCallback:success
                             failureCallback:failure];
    
}
@end
