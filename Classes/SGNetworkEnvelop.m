//
//  SGNetworkEnvelop.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGNetworkEnvelop.h"

@implementation SGNetworkEnvelop

+ (NSDictionary *)sgcc_modelCustomPropertyMapper {
    return @{
             @"errorCode"   : @"errno",
             @"errorMessage": @"message",
             @"data"        : @"data",
             };
}

@end
