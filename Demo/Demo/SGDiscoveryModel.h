//
//  SGDiscoveryModel.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGJsonModel.h"

@interface SGDiscoveryModel : SGJsonModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;

@end
