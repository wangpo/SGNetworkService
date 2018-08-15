//
//  NSError+SGCC.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "NSError+SGCC.h"

@implementation NSError (SGCC)

+ (instancetype)sgcc_errorWithCode:(NSInteger)code description:(NSString *)description {
    NSDictionary *userInfo = nil;
    if (description.length) {
        userInfo = @{
                     NSLocalizedDescriptionKey: description
                     };
    }
    return [NSError errorWithDomain:NSURLErrorDomain code:code userInfo:userInfo];
}

@end
