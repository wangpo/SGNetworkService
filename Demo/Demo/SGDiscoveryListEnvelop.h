//
//  SGDiscoveryListEnvelop.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGJsonModel.h"
#import "SGDiscoveryModel.h"

@interface SGDiscoveryListEnvelop : SGJsonModel

@property (nonatomic, copy) NSArray<SGDiscoveryModel *> *contents;

@end
