//
//  SGDiscoveryListEnvelop.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGDiscoveryListEnvelop.h"

@implementation SGDiscoveryListEnvelop

+ (NSDictionary *)sgcc_modelContainerPropertyGenericClass {
    return @{
             @"contents": [SGDiscoveryModel class],
             };
}

@end
