//
//  BFCUploadImageEnvelop.h
//  BFCoplay
//
//  Created by  on 2017/10/9.
//  Copyright © 2017年 BaoFeng. All rights reserved.
//

#import "SGJsonModel.h"

@interface BFCUploadImageEnvelop : SGJsonModel
@property(nonatomic, strong) NSString *avatar;// 更新头像使用

// 上传图片使用这2个属性
@property(nonatomic, strong) NSString *pid;
@property(nonatomic, assign) NSUInteger nbytes;
@end
