//
//  SGJsonModel.h
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//  Model父类，自动解析dictionary->model

#import <Foundation/Foundation.h>
#import <YYKit/YYKit.h>

@interface SGJsonModel : NSObject<YYModel>

/**
 * 为了子类能够继承父类的处理，
 * 禁止使用YYKit的回调函数，必须使用SGJsonModel的函数来处理
 */
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper NS_UNAVAILABLE;
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass NS_UNAVAILABLE;
+ (nullable Class)modelCustomClassForDictionary:(nullable NSDictionary *)dictionary NS_UNAVAILABLE;
+ (nullable NSArray<NSString *> *)modelPropertyBlacklist NS_UNAVAILABLE;
+ (nullable NSArray<NSString *> *)modelPropertyWhitelist NS_UNAVAILABLE;
- (nonnull NSDictionary *)modelCustomWillTransformFromDictionary:(nullable NSDictionary *)dic NS_UNAVAILABLE;
- (BOOL)modelCustomTransformFromDictionary:(nullable NSDictionary *)dic NS_UNAVAILABLE;
- (BOOL)modelCustomTransformToDictionary:(nullable NSMutableDictionary *)dic NS_UNAVAILABLE;


/**
 * 以下是SGJsonModel的处理函数
 */
+ (nullable NSDictionary<NSString *, id> *)sgcc_modelCustomPropertyMapper;
+ (nullable NSDictionary<NSString *, id> *)sgcc_modelContainerPropertyGenericClass;
+ (nullable Class)sgcc_modelCustomClassForDictionary:(nullable NSDictionary *)dictionary;
+ (nullable NSArray<NSString *> *)sgcc_modelPropertyBlacklist;
+ (nullable NSArray<NSString *> *)sgcc_modelPropertyWhitelist;
- (nonnull NSDictionary *)sgcc_modelCustomWillTransformFromDictionary:(nullable NSDictionary *)dic;
- (BOOL)sgcc_modelCustomTransformFromDictionary:(nullable NSDictionary *)dic;
- (BOOL)sgcc_modelCustomTransformToDictionary:(nullable NSMutableDictionary *)dic;

@end
