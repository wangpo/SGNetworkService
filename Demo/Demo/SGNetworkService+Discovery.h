//
//  SGNetworkService+Discovery.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGNetworkService.h"

@interface SGNetworkService (Discovery)

- (NSURLSessionDataTask *)getDiscoveryList:(NSString *)after
                             successCallback:(SuccessCallback)success
                             failureCallback:(FailureCallback)failure;

@end
