//
//  ZYCategoryCallSubParameter.m
//  ZYCategoryView
//
//  Created by XUZY on 2022/1/6.
//

#import "ZYCategoryCallSubParameter.h"

@implementation ZYCategoryCallSubParameter

@synthesize sType = _sType;
@synthesize sIndex = _sIndex;
@synthesize sIsSelectorContinue = _sIsSelectorContinue;
@synthesize sSelector = _sSelector;
@synthesize sFirstObj = _sFirstObj;
@synthesize sSecondObj = _sSecondObj;
@synthesize sThirdObj = _sThirdObj;
@synthesize sIsImmediately = _sIsImmediately;
@synthesize sIsForceLoad = _sIsForceLoad;

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak __typeof(self)weakSelf = self;
        _sType = ^ZYCategoryCallSubParameter * _Nullable(ZYCategoryCallSubReloadType type) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.type = type;
            return strongSelf;
        };
        
        _sIndex = ^ZYCategoryCallSubParameter * _Nullable(NSInteger index) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.index = index;
            return strongSelf;
        };
        
        _sIsSelectorContinue = ^ZYCategoryCallSubParameter * _Nullable(BOOL isSelectorContinue) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isSelectorContinue = isSelectorContinue;
            return strongSelf;
        };
        
        _sSelector = ^ZYCategoryCallSubParameter * _Nullable(SEL selector) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.selector = selector;
            return strongSelf;
        };
        
        _sFirstObj = ^ZYCategoryCallSubParameter * _Nullable(NSObject * _Nonnull firstObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.firstObj = firstObj;
            return strongSelf;
        };
        
        _sSecondObj = ^ZYCategoryCallSubParameter * _Nullable(NSObject * _Nonnull secondObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.secondObj = secondObj;
            return strongSelf;
        };
        
        _sThirdObj = ^ZYCategoryCallSubParameter * _Nullable(NSObject * _Nonnull thirdObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.thirdObj = thirdObj;
            return strongSelf;
        };
        
        _sIsImmediately = ^ZYCategoryCallSubParameter * _Nullable(BOOL isImmediately) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isImmediately = isImmediately;
            return strongSelf;
        };
        
        _sIsForceLoad = ^ZYCategoryCallSubParameter * _Nullable(BOOL isForceLoad) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isForceLoad = isForceLoad;
            return strongSelf;
        };
    }
    return self;
}

@end
