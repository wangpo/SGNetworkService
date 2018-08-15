//
//  SGJsonModel.m
//  SGCC
//
//  Created by wangpo on 2018/6/8.
//  Copyright © 2018年 SGCC. All rights reserved.
//

#import "SGJsonModel.h"

typedef id (*SGCC_IMP)(__strong id, SEL, ...);
typedef id (*SGCC_IMP1)(__strong id, SEL, __strong id, ...);
typedef void (*SGCC_VIMP)(__strong id, SEL, ...);
typedef BOOL (*SGCC_BIMP)(__strong id, SEL, ...);
typedef BOOL (*SGCC_BIMP1)(__strong id, SEL, __strong id, ...);

@implementation SGJsonModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder: aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self modelInitWithCoder:aDecoder];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}

- (NSUInteger)hash {
    return [self modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self modelIsEqual: object];
}

- (NSString *)description {
    return [self modelDescription];
}

#pragma mark YYModel Protocol
- (instancetype)init {
    self = [super init];
    if (self) {
#ifdef DEBUG
        if (![[self className] isEqualToString:@"SGJsonModel"]) {
            NSAssert([[self class] methodForSelector:@selector(modelCustomPropertyMapper)] ==
                     [SGJsonModel methodForSelector:@selector(modelCustomPropertyMapper)],
                     @"Your class:%@ should use sgcc_modellCustomPropertyMapper: instead", [self className]);
            
            NSAssert([[self class] methodForSelector:@selector(modelContainerPropertyGenericClass)] ==
                     [SGJsonModel methodForSelector:@selector(modelContainerPropertyGenericClass)],
                     @"Your class:%@ should use sgcc_modellContainerPropertyGenericClassMapper: instead", [self className]);
            
            NSAssert([[self class] methodForSelector:@selector(modelCustomClassForDictionary:)] ==
                     [SGJsonModel methodForSelector:@selector(modelCustomClassForDictionary:)],
                     @"Your class:%@ should use sgcc_modellCustomClassFromDictionary: instead", [self className]);
            
            NSAssert([[self class] methodForSelector:@selector(modelPropertyBlacklist)] ==
                     [SGJsonModel methodForSelector:@selector(modelPropertyBlacklist)],
                     @"Your class:%@ should use sgcc_modellPropertyBlackList: instead", [self className]);
            
            NSAssert([[self class] methodForSelector:@selector(modelPropertyWhitelist)] ==
                     [SGJsonModel methodForSelector:@selector(modelPropertyWhitelist)],
                     @"Your class:%@ should use sgcc_modellPropertyWhiteList: instead", [self className]);
            
            NSAssert([self methodForSelector:@selector(modelCustomWillTransformFromDictionary:)] ==
                     [SGJsonModel instanceMethodForSelector:@selector(modelCustomWillTransformFromDictionary:)],
                     @"Your class:%@ should use sgcc_modellCustomWillTransformFromDictionary:toDictionary: instead", [self className]);
            
            NSAssert([self methodForSelector:@selector(modelCustomTransformFromDictionary:)] ==
                     [SGJsonModel instanceMethodForSelector:@selector(modelCustomTransformFromDictionary:)],
                     @"Your class:%@ should use sgcc_modellCustomTransformFromDictionary:result: instead", [self className]);
            
            NSAssert([self methodForSelector:@selector(modelCustomTransformToDictionary:)] ==
                     [SGJsonModel instanceMethodForSelector:@selector(modelCustomTransformToDictionary:)],
                     @"Your class:%@ should use sgcc_modellCustomTransformToDictionary:result: instead", [self className]);
        }
#endif
    }
    return self;
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    NSMutableDictionary<NSString *, id> *mapper = [[NSMutableDictionary<NSString *, id> alloc] init];
    NSMutableArray *clsArray = [[NSMutableArray alloc] init];
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        [clsArray addObject:cls];
        cls = [cls superclass];
    }
    if (clsArray.count > 0) {
        for (NSInteger i = clsArray.count - 1; i >= 0; --i) {
            cls = clsArray[i];
            Method method = class_getClassMethod(cls, @selector(sgcc_modelCustomPropertyMapper));
            Method superMethod = class_getClassMethod([cls superclass], @selector(sgcc_modelCustomPropertyMapper));
            if (method && method != superMethod) {
                SGCC_IMP clsImp = (SGCC_IMP)method_getImplementation(method);
                NSDictionary *dic = clsImp(cls, @selector(sgcc_modelCustomPropertyMapper));
                if (dic.count > 0) {
                    [mapper addEntriesFromDictionary:dic];
                }
            }
        }
    }
    if (mapper.count > 0) {
        return [mapper copy];
    }
    return nil;
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    NSMutableDictionary<NSString *, id> *mapper = [[NSMutableDictionary<NSString *, id> alloc] init];
    NSMutableArray *clsArray = [[NSMutableArray alloc] init];
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        [clsArray addObject:cls];
        cls = [cls superclass];
    }
    if (clsArray.count > 0) {
        for (NSInteger i = clsArray.count - 1; i >= 0; --i) {
            cls = clsArray[i];
            Method method = class_getClassMethod(cls, @selector(sgcc_modelContainerPropertyGenericClass));
            Method superMethod = class_getClassMethod([cls superclass], @selector(sgcc_modelContainerPropertyGenericClass));
            if (method && method != superMethod) {
                SGCC_IMP clsImp = (SGCC_IMP)method_getImplementation(method);
                NSDictionary *dic = clsImp(cls, @selector(sgcc_modelContainerPropertyGenericClass));
                if (dic.count > 0) {
                    [mapper addEntriesFromDictionary:dic];
                }
            }
        }
    }
    if (mapper.count > 0) {
        return [mapper copy];
    }
    return nil;
}

+ (nullable Class)modelCustomClassForDictionary:(NSDictionary *)dic {
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        Method method = class_getClassMethod(cls, @selector(sgcc_modelCustomClassForDictionary:));
        Method superMethod = class_getClassMethod([cls superclass], @selector(sgcc_modelCustomClassForDictionary:));
        if (method && method != superMethod) {
            SGCC_IMP1 clsImp = (SGCC_IMP1)method_getImplementation(method);
            Class retCls = clsImp(cls, @selector(sgcc_modelCustomClassForDictionary:), dic);
            if (retCls) {
                return retCls;
            }
        }
        cls = [cls superclass];
    }
    return nil;
}

+ (nullable NSArray<NSString *> *)modelPropertyBlacklist {
    NSMutableArray<NSString *> *blackList = [[NSMutableArray<NSString *> alloc] init];
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        Method method = class_getClassMethod(cls, @selector(sgcc_modelPropertyBlacklist));
        Method superMethod = class_getClassMethod([cls superclass], @selector(sgcc_modelPropertyBlacklist));
        if (method && method != superMethod) {
            SGCC_IMP clsImp = (SGCC_IMP)method_getImplementation(method);
            NSArray *arr = clsImp(cls, @selector(sgcc_modelPropertyBlacklist));
            if (arr.count > 0) {
                [blackList addObjectsFromArray:arr];
            }
        }
        cls = [cls superclass];
    }
    if (blackList.count > 0) {
        return [blackList copy];
    }
    return nil;
}

+ (nullable NSArray<NSString *> *)modelPropertyWhitelist {
    NSMutableArray<NSString *> *whiteList = [[NSMutableArray<NSString *> alloc] init];
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        Method method = class_getClassMethod(cls, @selector(sgcc_modelPropertyWhitelist));
        Method superMethod = class_getClassMethod([cls superclass], @selector(sgcc_modelPropertyWhitelist));
        if (method && method != superMethod) {
            SGCC_IMP clsImp = (SGCC_IMP)method_getImplementation(method);
            NSArray *arr = clsImp(cls, @selector(sgcc_modelPropertyWhitelist));
            if (arr.count > 0) {
                [whiteList addObjectsFromArray:arr];
            }
        }
        cls = [cls superclass];
    }
    if (whiteList.count > 0) {
        return [whiteList copy];
    }
    return nil;
}

- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic {
    NSDictionary *result = dic;
    NSMutableArray *clsArray = [[NSMutableArray alloc] init];
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        [clsArray addObject:cls];
        cls = [cls superclass];
    }
    if (clsArray.count > 0) {
        for (NSInteger i = clsArray.count - 1; i >= 0; --i) {
            cls = clsArray[i];
            Method method = class_getInstanceMethod(cls, @selector(sgcc_modelCustomWillTransformFromDictionary:));
            Method superMethod = class_getInstanceMethod([cls superclass], @selector(sgcc_modelCustomWillTransformFromDictionary:));
            if (method && method != superMethod) {
                SGCC_IMP1 clsImp = (SGCC_IMP1)method_getImplementation(method);
                NSDictionary *tmp = clsImp(self, @selector(sgcc_modelCustomWillTransformFromDictionary:), result);
                if (tmp.count > 0) {
                    result = tmp;
                }
            }
        }
    }
    if (result.count > 0) {
        return [result copy];
    }
    return dic;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    BOOL ret = YES;
    NSMutableArray *clsArray = [[NSMutableArray alloc] init];
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        [clsArray addObject:cls];
        cls = [cls superclass];
    }
    if (clsArray.count > 0) {
        for (NSInteger i = clsArray.count - 1; i >= 0; --i) {
            cls = clsArray[i];
            Method method = class_getInstanceMethod(cls, @selector(sgcc_modelCustomTransformFromDictionary:));
            Method superMethod = class_getInstanceMethod([cls superclass], @selector(sgcc_modelCustomTransformFromDictionary:));
            if (method && method != superMethod) {
                SGCC_BIMP1 clsImp = (SGCC_BIMP1)method_getImplementation(method);
                BOOL tmp = clsImp(self, @selector(sgcc_modelCustomTransformFromDictionary:), dic);
                if (!tmp) {
                    return NO;
                }
            }
        }
    }
    return ret;
}

- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    BOOL ret = YES;
    NSMutableArray *clsArray = [[NSMutableArray alloc] init];
    Class cls = [self class];
    while (![NSStringFromClass(cls) isEqual:@"SGJsonModel"]) {
        [clsArray addObject:cls];
        cls = [cls superclass];
    }
    if (clsArray.count > 0) {
        for (NSInteger i = clsArray.count - 1; i >= 0; --i) {
            cls = clsArray[i];
            Method method = class_getInstanceMethod(cls, @selector(sgcc_modelCustomTransformToDictionary:));
            Method superMethod = class_getInstanceMethod([cls superclass], @selector(sgcc_modelCustomTransformToDictionary:));
            if (method && method != superMethod) {
                SGCC_BIMP1 clsImp = (SGCC_BIMP1)method_getImplementation(method);
                BOOL tmp = clsImp(self, @selector(sgcc_modelCustomTransformToDictionary:), dic);
                if (!tmp) {
                    return NO;
                }
            }
        }
    }
    return ret;
}

#pragma mark - Default Empty Implementation
+ (nullable NSDictionary<NSString *, id> *)sgcc_modelCustomPropertyMapper {
    return nil;
}

+ (nullable NSDictionary<NSString *, id> *)sgcc_modelContainerPropertyGenericClass {
    return nil;
}

+ (nullable Class)sgcc_modelCustomClassForDictionary:(nullable NSDictionary *)dictionary {
    return nil;
}

+ (nullable NSArray<NSString *> *)sgcc_modelPropertyBlacklist {
    return nil;
}

+ (nullable NSArray<NSString *> *)sgcc_modelPropertyWhitelist {
    return nil;
}

- (nonnull NSDictionary *)sgcc_modelCustomWillTransformFromDictionary:(nullable NSDictionary *)dic {
    return nil;
}

- (BOOL)sgcc_modelCustomTransformFromDictionary:(nullable NSDictionary *)dic {
    return YES;
}

- (BOOL)sgcc_modelCustomTransformToDictionary:(nullable NSMutableDictionary *)dic {
    return YES;
}
@end
