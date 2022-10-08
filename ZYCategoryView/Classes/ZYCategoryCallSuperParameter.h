//
//  ZYCategoryCallSuperParameter.h
//  ZYCategoryView
//
//  Created by XUZY on 2022/1/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYCategoryCallSuperParameter : NSObject
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSObject *target;
@property (nonatomic, assign) NSInteger index; //小于0代表未设置
@property (nonatomic, strong) NSObject *firstObj;
@property (nonatomic, strong) NSObject *secondObj;
@property (nonatomic, strong) NSObject *thirdObj;

@property (nonatomic, strong) ZYCategoryCallSuperParameter * __nullable(^sSelector)(SEL selector);
@property (nonatomic, strong) ZYCategoryCallSuperParameter * __nullable(^sKey)(NSString *key);
@property (nonatomic, strong) ZYCategoryCallSuperParameter * __nullable(^sTarget)(NSObject *target);
@property (nonatomic, strong) ZYCategoryCallSuperParameter * __nullable(^sIndex)(NSInteger index);
@property (nonatomic, strong) ZYCategoryCallSuperParameter * __nullable(^sFirstObj)(NSObject *firstObj);
@property (nonatomic, strong) ZYCategoryCallSuperParameter * __nullable(^sSecondObj)(NSObject *secondObj);
@property (nonatomic, strong) ZYCategoryCallSuperParameter * __nullable(^sThirdObj)(NSObject *thirdObj);
@end

NS_ASSUME_NONNULL_END
