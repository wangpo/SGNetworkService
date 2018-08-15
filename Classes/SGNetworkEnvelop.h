//
//  SGNetworkEnvelop.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//  网络封包对象

#import "SGJsonModel.h"

@interface SGNetworkEnvelop : SGJsonModel

@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, copy)   NSString *errorMessage;
@property (nonatomic, strong) NSDictionary *data;//业务数据

@end
