//
//  ZYCategoryView.h
//  Fucaibao
//
//  Created by hc on 2020/11/19.
//  Copyright © 2020 sinodata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
#import "ZYCategoryViewRefreshDelegate.h"
#import "JXCategoryTitleView.h"

@class ZYCategoryView;
NS_ASSUME_NONNULL_BEGIN

@protocol ZYCategoryViewDelegate <NSObject>

@optional
// 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)zy_categoryView:(ZYCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

// 点击选中的情况才会调用该方法
- (void)zy_categoryView:(ZYCategoryView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

// 滚动选中的情况才会调用该方法
- (void)zy_categoryView:(ZYCategoryView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;

// 正在滚动中的回调
- (void)zy_categoryView:(ZYCategoryView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;

// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(ZYCategoryView *)listContainerView;

// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)zy_listContainerView:(ZYCategoryView *)categoryView initListForIndex:(NSInteger)index;

- (void)zy_callbackByContainerView:(ZYCategoryCallSuperParameter *)parameter;
@end

@interface ZYCategoryView : UIView <ZYCategoryViewRefreshDelegate>
@property (nonatomic, strong) JXCategoryTitleView *titleView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, weak) id<ZYCategoryViewDelegate> delegate;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger defaultSelectedIndex; //默认选择项
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) CGFloat containerViewOffsetY;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict;   //已经加载过的列表字典。key是index，value是对应的列表
@property (nonatomic, strong, readonly) NSObject *currentContainer; //当前内容
@property (nonatomic, assign) CGFloat titleHeight;
- (void)setIndicatorColor:(UIColor *)color;
- (void)setTitleColor:(UIColor *)titleColor;
- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor;
- (void)setTitleBackgroudColor:(UIColor *)color;
- (void)setContentScrollView:(UIScrollView *)scroll;
- (void)scrollEnable:(BOOL)isScrollEnable;
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
