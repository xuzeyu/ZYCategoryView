//
//  ZYCategoryCallSubParameter.m
//  ZYCategoryView
//
//  Created by XUZY on 2022/1/6.
//

#import "ZYCategoryCallSubParameter.h"

@implementation ZYCategoryCallSubParameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak __typeof(self)weakSelf = self;
        self.sType = ^ZYCategoryCallSubParameter * _Nullable(ZYCategoryCallSubReloadType type) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.type = type;
            return strongSelf;
        };
        
        self.sIndex = ^ZYCategoryCallSubParameter * _Nullable(NSInteger index) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.index = index;
            return strongSelf;
        };
        
        self.sIsSelectorContinue = ^ZYCategoryCallSubParameter * _Nullable(BOOL isSelectorContinue) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isSelectorContinue = isSelectorContinue;
            return strongSelf;
        };
        
        self.sSelector = ^ZYCategoryCallSubParameter * _Nullable(SEL selector) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.selector = selector;
            return strongSelf;
        };
        
        self.sFirstObj = ^ZYCategoryCallSubParameter * _Nullable(NSObject * _Nonnull firstObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.firstObj = firstObj;
            return strongSelf;
        };
        
        self.sSecondObj = ^ZYCategoryCallSubParameter * _Nullable(NSObject * _Nonnull secondObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.secondObj = secondObj;
            return strongSelf;
        };
        
        self.sThirdObj = ^ZYCategoryCallSubParameter * _Nullable(NSObject * _Nonnull thirdObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.thirdObj = thirdObj;
            return strongSelf;
        };
        
        self.sIsImmediately = ^ZYCategoryCallSubParameter * _Nullable(BOOL isImmediately) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isImmediately = isImmediately;
            return strongSelf;
        };
        
        self.sIsForceLoad = ^ZYCategoryCallSubParameter * _Nullable(BOOL isForceLoad) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isForceLoad = isForceLoad;
            return strongSelf;
        };
    }
    return self;
}

@end
