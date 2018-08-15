//
//  SGNetworkService+Discovery.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGNetworkService+Discovery.h"
#import "SGDiscoveryListEnvelop.h"

@implementation SGNetworkService (Discovery)

- (NSURLSessionDataTask *)getDiscoveryList:(NSString *)after
                           successCallback:(SuccessCallback)success
                           failureCallback:(FailureCallback)failure
{
     return [self sgcc_getModelClass:[SGDiscoveryListEnvelop class] sessionType:SGHttpSessionTypeService1 path:@"/base/content/list" parameters:@{@"after": after,@"limit": @(3),@"tags" : @""} successCallback:success failureCallback:failure];
}
@end
