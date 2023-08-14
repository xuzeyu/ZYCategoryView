//
//  ZYCategoryCallSubParameter.h
//  ZYCategoryView
//
//  Created by XUZY on 2022/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ZYCategoryCallSubReloadType) {
    ZYCategoryCallSubReloadTypeIndex,            //刷新指定index内容
    ZYCategoryCallSubReloadTypeCurrentContainer  = 0, //刷新当前内容
    ZYCategoryCallSubReloadTypeOther,                 // 刷新除当前内容的其他内容
    ZYCategoryCallSubReloadTypeAll,                   //刷新所有内容
};

@interface ZYCategoryCallSubParameter : NSObject
@property (nonatomic, assign) ZYCategoryCallSubReloadType type;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isSelectorContinue; //如果NO 容器未加载则废弃调用selector YES 容器未加载则等待加载后继续调用selector
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) NSObject *firstObj;
@property (nonatomic, strong) NSObject *secondObj;
@property (nonatomic, strong) NSObject *thirdObj;
@property (nonatomic, assign) BOOL isImmediately; //是否马上刷新
@property (nonatomic, assign) BOOL isForceLoad; //是否强制加载刷新 即容器没加载的也强制加载

@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sType)(ZYCategoryCallSubReloadType type);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sIndex)(NSInteger index);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sIsSelectorContinue)(BOOL isSelectorContinue);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sSelector)(SEL selector);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sFirstObj)(NSObject *firstObj);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sSecondObj)(NSObject *secondObj);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sThirdObj)(NSObject *thirdObj);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sIsImmediately)(BOOL isImmediately);
@property (nonatomic, strong, readonly) ZYCategoryCallSubParameter * __nullable(^sIsForceLoad)(BOOL isForceLoad);
@end

NS_ASSUME_NONNULL_END
