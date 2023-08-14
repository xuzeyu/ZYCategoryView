//
//  ZYCategoryCallSuperParameter.m
//  ZYCategoryView
//
//  Created by XUZY on 2022/1/5.
//

#import "ZYCategoryCallSuperParameter.h"

@implementation ZYCategoryCallSuperParameter

@synthesize sSelector = _sSelector;
@synthesize sKey = _sKey;
@synthesize sTarget = _sTarget;
@synthesize sIndex = _sIndex;
@synthesize sFirstObj = _sFirstObj;
@synthesize sSecondObj = _sSecondObj;
@synthesize sThirdObj = _sThirdObj;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.index = - 1;
        __weak __typeof(self)weakSelf = self;
        _sSelector = ^ZYCategoryCallSuperParameter * _Nullable(SEL selector) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.selector = selector;
            return strongSelf;
        };
        
        _sKey = ^ZYCategoryCallSuperParameter * _Nullable(NSString * _Nonnull key) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.key = key;
            return strongSelf;
        };
        
        _sTarget = ^ZYCategoryCallSuperParameter * _Nullable(NSObject * _Nonnull target) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.target = target;
            return strongSelf;
        };
        
        _sIndex = ^ZYCategoryCallSuperParameter * _Nullable(NSInteger index) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.index = index;
            return strongSelf;
        };
            
        
        _sFirstObj = ^ZYCategoryCallSuperParameter * _Nullable(NSObject * _Nonnull firstObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.firstObj = firstObj;
            return strongSelf;
        };
        
        _sSecondObj = ^ZYCategoryCallSuperParameter * _Nullable(NSObject * _Nonnull secondObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.secondObj = secondObj;
            return strongSelf;
        };
        
        _sThirdObj = ^ZYCategoryCallSuperParameter * _Nullable(NSObject * _Nonnull thirdObj) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.thirdObj = thirdObj;
            return strongSelf;
        };
    }
    return self;
}

@end
