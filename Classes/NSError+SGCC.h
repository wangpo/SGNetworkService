//
//  NSError+SGCC.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import <Foundation/Foundation.h>

//服务器返回的错误码，根据服务器定义代码修改
typedef NS_ENUM(NSInteger, SGStatusCode) {
    SGParametersError  = -5,       //参数错误
    SGDataFormatError  = -4,       //返回数据格式错误
    SGSuccess          = 10000,    // 成功
    SGShowMsg          = 10001,    // 打印服务器信息
    SGNetLinkError,                // 网络链接错误
    SGOtherError,                  // 其他错误
    
};

@interface NSError (SGCC)

+ (instancetype)sgcc_errorWithCode:(NSInteger)code description:(NSString *)description;

@end
