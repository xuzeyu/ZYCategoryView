//
//  ZYCategoryView.m
//  Fucaibao
//
//  Created by hc on 2020/11/19.
//  Copyright © 2020 sinodata. All rights reserved.
//

#import "ZYCategoryView.h"
#import "JXCategoryIndicatorLineView.h"
#import <objc/runtime.h>

@interface JXCategoryListContainerView ()
- (void)listWillAppear:(NSInteger)index;
@end

@interface ZYCategoryView () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, JXCategoryTitleViewDataSource>
@property (nonatomic, strong) NSMutableDictionary *refreshDict;
@property (nonatomic, assign) NSInteger oldSelectIndex;
@end

@implementation ZYCategoryView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleHeight = 50;
        //初始化 JXCategoryTitleView：
        self.titleView = [[JXCategoryTitleView alloc] init];
        self.titleView.delegate = self;
        self.titleView.titleDataSource = self;
//        self.titleView.backgroundColor = [UIColor whiteColor];
        self.titleView.cellSpacing = 0.0f;
        self.titleView.titleFont = [UIFont systemFontOfSize:15];
        self.titleView.titleColor = [UIColor colorWithRed:90/255.0f green:90/255.0f blue:90/255.0f alpha:1];
        [self addSubview:self.titleView];
        
        //添加指示器
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor redColor];
        lineView.indicatorWidth = 20;
        lineView.componentPosition = JXCategoryComponentPosition_Bottom;
//        lineView.indicatorCornerRadius = 0;
        self.titleView.indicators = @[lineView];
        
        //初始化 JXCategoryListContainerView 并关联到 titleView
        self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
        [self addSubview:self.listContainerView];
        // 关联到 titleView
        self.titleView.listContainer = self.listContainerView;
        
        //底部线
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, CGRectGetWidth(self.frame), self.lineHeight)];
//        self.line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        self.line.hidden = YES;
        [self addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleView.frame = CGRectMake(0, 0, self.frame.size.width, self.titleHeight);
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), self.frame.size.width, self.lineHeight);
    if (self.titles.count == 0) {
        self.titleView.hidden = self.line.hidden = YES;
        self.listContainerView.frame = CGRectMake(0, self.containerViewOffsetY, self.frame.size.width, self.frame.size.height);
    }else {
        self.titleView.hidden = self.line.hidden = NO;
        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.line.frame) + self.containerViewOffsetY, self.frame.size.width, self.frame.size.height - CGRectGetMaxY(self.line.frame));
    }
    
    if ([self.delegate numberOfListsInlistContainerView:self] == 0) {
        self.listContainerView.hidden = YES;
    }else {
        self.listContainerView.hidden = NO;
    }

//    [self.listContainerView reloadData];
}

#pragma mark - 属性
- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    if (self.titleView.indicators.count > 0) {
        JXCategoryIndicatorLineView *lineView = (JXCategoryIndicatorLineView *)self.titleView.indicators[0];
        lineView.indicatorWidth = indicatorWidth;
    }
}

- (void)setIndicatorColor:(UIColor *)color {
    if (self.titleView.indicators.count > 0) {
        JXCategoryIndicatorLineView *lineView = (JXCategoryIndicatorLineView *)self.titleView.indicators[0];
        lineView.indicatorColor = color;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (self.titleView.titleColor != titleColor) {
        self.titleView.titleColor = titleColor;
        [self.titleView refreshState];
        [self.titleView.collectionView.collectionViewLayout invalidateLayout];
        [self.titleView.collectionView reloadData];
    }
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    if (self.titleView.titleSelectedColor != titleSelectedColor) {
        self.titleView.titleSelectedColor = titleSelectedColor;
        [self.titleView refreshState];
        [self.titleView.collectionView.collectionViewLayout invalidateLayout];
        [self.titleView.collectionView reloadData];
    }
}

- (void)setTitleBackgroudColor:(UIColor *)color {
    self.titleView.backgroundColor = color;
}

- (void)setContentScrollView:(UIScrollView *)scroll {
    self.titleView.contentScrollView = scroll;
}

- (void)scrollEnable:(BOOL)isScrollEnable {
    self.listContainerView.contentScrollView.scrollEnabled = isScrollEnable;
}

- (void)reloadData {
    [self.titleView reloadData];
    [self.listContainerView reloadData];
}

- (void)setTitles:(NSArray *)titles {
    if (_titles.count > 0 || titles.count == 0) {
        [self layoutIfNeeded];
    }
    _titles = titles;
    self.titleView.titles = titles;
    [self.titleView reloadData];
    
    NSString *title = nil;
    for (NSString *str in titles) {
        if (str.length > title.length) {
            title = str;
        }
    }
    [self setIndicatorWidth:[self widthForFont:self.titleView.titleFont text:title] + 10];
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;
    self.titleView.defaultSelectedIndex = defaultSelectedIndex;
    self.oldSelectIndex = defaultSelectedIndex;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    [self.titleView selectItemAtIndex:selectIndex];
    [self.listContainerView didClickSelectedItemAtIndex:selectIndex];
}

- (NSInteger)selectIndex {
    return self.titleView.selectedIndex;
}

- (NSDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *)validListDict {
    return self.listContainerView.validListDict;
}

- (id)currentContainer {
    return [self.listContainerView.validListDict objectForKey:@(self.titleView.selectedIndex)];
}

#pragma mark - Function
- (UIViewController *)zy_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (NSInteger)zy_selectIndex {
    return self.selectIndex;
}

//刷新子内容
- (void)zy_reloadContainers:(ZYCategoryCallSubParameter *)parameter {
    if (!parameter) return;
    if (parameter.type == ZYCategoryCallSubReloadTypeIndex) {
        if (parameter.selector) {
            [self.refreshDict setObject:parameter forKey:@(parameter.index)];
        }else {
            [self.refreshDict setObject:@(YES) forKey:@(parameter.index)];
        }
        
        if (parameter.isImmediately || self.selectIndex == parameter.index){
            [self refreshContentVC:parameter.index isForceLoad:parameter.isForceLoad];
        }
    }else if (parameter.type == ZYCategoryCallSubReloadTypeCurrentContainer) {
        if (parameter.selector) {
            [self.refreshDict setObject:parameter forKey:@(self.selectIndex)];
        }else {
            [self.refreshDict setObject:@(YES) forKey:@(self.selectIndex)];
        }
        
        [self refreshContentVC:self.selectIndex isForceLoad:YES];
    }else if (parameter.type == ZYCategoryCallSubReloadTypeOther) {
        NSInteger count = [self numberOfListsInlistContainerView:self.listContainerView];
        for (NSInteger i = 0; i<count; i++) {
            if (i != self.selectIndex) {
                if (parameter.selector) {
                    [self.refreshDict setObject:parameter forKey:@(i)];
                }else {
                    [self.refreshDict setObject:@(YES) forKey:@(i)];
                }
                
                if (parameter.isImmediately){
                    [self refreshContentVC:i isForceLoad:parameter.isForceLoad];
                }
            }
        }
    }else if (parameter.type == ZYCategoryCallSubReloadTypeAll) {
        NSInteger count = [self numberOfListsInlistContainerView:self.listContainerView];
        for (NSInteger i = 0; i<count; i++) {
            if (parameter.selector) {
                [self.refreshDict setObject:parameter forKey:@(i)];
            }else {
                [self.refreshDict setObject:@(YES) forKey:@(i)];
            }
            
            if (parameter.isImmediately){
                [self refreshContentVC:i isForceLoad:parameter.isForceLoad];
            }
        }
    }
}

- (void)refreshContentVC:(NSInteger)index isForceLoad:(BOOL)isForceLoad {
    if ([self.refreshDict.allKeys containsObject:@(index)]) {
        if (isForceLoad) {
            if ([self.validListDict.allKeys containsObject:@(index)]) {
                id<JXCategoryListContentViewDelegate> list = [self.validListDict objectForKey:@(index)];
                if ([[self.refreshDict objectForKey:@(index)] isKindOfClass:[ZYCategoryCallSubParameter class]]) {
                    ZYCategoryCallSubParameter *parameter = [self.refreshDict objectForKey:@(index)];
                    if ([list respondsToSelector:parameter.selector]) {
                        [list performSelector:parameter.selector withObject:parameter.firstObj withObject:parameter.secondObj];
                    }
                }else {
                    [[list listView] removeFromSuperview];
                    if ([list isKindOfClass:[UIViewController class]]) {
                        [(UIViewController *)list removeFromParentViewController];
                    }
                    NSMutableDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict = (NSMutableDictionary *)self.validListDict;
                    [validListDict removeObjectForKey:@(index)];
                    [self.listContainerView listWillAppear:index];
                }
            }else {
                [self.listContainerView listWillAppear:index];
                id<JXCategoryListContentViewDelegate> list = [self.validListDict objectForKey:@(index)];
                if (list && [[self.refreshDict objectForKey:@(index)] isKindOfClass:[ZYCategoryCallSubParameter class]]) {
                    ZYCategoryCallSubParameter *parameter = [self.refreshDict objectForKey:@(index)];
                    if (parameter.isSelectorContinue && [list respondsToSelector:parameter.selector]) {
                        [list performSelector:parameter.selector withObject:parameter.firstObj withObject:parameter.secondObj];
                    }
                }
            }
            [self.refreshDict removeObjectForKey:@(index)];
        }else {
            if ([self.validListDict.allKeys containsObject:@(index)]) {
                id<JXCategoryListContentViewDelegate> list = [self.validListDict objectForKey:@(index)];
                if ([[self.refreshDict objectForKey:@(index)] isKindOfClass:[ZYCategoryCallSubParameter class]]) {
                    ZYCategoryCallSubParameter *parameter = [self.refreshDict objectForKey:@(index)];
                    if ([list respondsToSelector:parameter.selector]) {
                        [list performSelector:parameter.selector withObject:parameter.firstObj withObject:parameter.secondObj];
                    }
                }else {
                    [[list listView] removeFromSuperview];
                    if ([list isKindOfClass:[UIViewController class]]) {
                        [(UIViewController *)list removeFromParentViewController];
                    }
                    NSMutableDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict = (NSMutableDictionary *)self.validListDict;
                    [validListDict removeObjectForKey:@(index)];
                    [self.listContainerView listWillAppear:index];
                }
                [self.refreshDict removeObjectForKey:@(index)];
            }else {
                if ([[self.refreshDict objectForKey:@(index)] isKindOfClass:[ZYCategoryCallSubParameter class]]) {
                    ZYCategoryCallSubParameter *parameter = [self.refreshDict objectForKey:@(index)];
                    if (!parameter.isSelectorContinue) {
                        [self.refreshDict removeObjectForKey:@(index)];
                    }
                }else {
                    [self.refreshDict removeObjectForKey:@(index)];
                }
            }
        }
    }
}

- (void)zy_callbackSuperVC:(ZYCategoryCallSuperParameter *)parameter {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zy_callbackByContainerView:)]) {
        if (parameter.index < 0 && parameter.target) {
            NSNumber *indexNumber = nil;
            for (NSNumber *number in self.validListDict) {
                id sObj = self.validListDict[number];
                if (parameter.target == sObj) {
                    indexNumber = number;
                    break;
                }
            }
            if (indexNumber) {
                parameter.index = [indexNumber integerValue];
            }
        }
        
        if (parameter > 0 && !parameter.target) {
            NSObject *target = nil;
            for (NSNumber *number in self.validListDict) {
                if (number.integerValue == parameter.index) {
                    target = self.validListDict[number];
                    break;
                }
            }
            if (target) {
                parameter.target = target;
            }
        }
        
        [self.delegate zy_callbackByContainerView:parameter];
    }
}

- (UIView *)listView {
    return [self valueForKey:@"view"];
}

#pragma mark - Runtime
- (UIViewController *)rep_viewController {
    ZYCategoryView *category = objc_getAssociatedObject(self, @selector(categoryVCDelegate));
    if (category) {
        return [category zy_viewController];
    }
    return nil;
}
- (NSInteger)rep_selectIndex {
    ZYCategoryView *category = objc_getAssociatedObject(self, @selector(categoryVCDelegate));
    if (category) {
        return [category zy_selectIndex];
    }
    return 0;
}

- (void)rep_reloadContainers:(ZYCategoryCallSubParameter *)parameter {
    ZYCategoryView *category = objc_getAssociatedObject(self, @selector(categoryVCDelegate));
    if (category) {
        [category zy_reloadContainers:parameter];
    }
}

- (void)rep_callbackSuperVC:(ZYCategoryCallSuperParameter *)parameter {
    ZYCategoryView *category = objc_getAssociatedObject(self, @selector(categoryVCDelegate));
    if (category) {
        [category zy_callbackSuperVC:parameter];
    }
}


#pragma mark - JXCategoryTitleViewDataSource
- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title {
    if (self.titles.count > 6) {
        return self.frame.size.width/6.5;
    }
    return self.frame.size.width/self.titles.count;
}

#pragma mark - JXCategoryViewDelegate
// 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(zy_categoryView:didSelectedItemAtIndex:)]) {
        [self.delegate zy_categoryView:self didSelectedItemAtIndex:index];
    }
    self.oldSelectIndex = index;
    
    [self refreshContentVC:index isForceLoad:YES];
}

// 点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(zy_categoryView:didClickSelectedItemAtIndex:)]) {
        [self.delegate zy_categoryView:self didClickSelectedItemAtIndex:index];
    }
}

// 滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(zy_categoryView:didScrollSelectedItemAtIndex:)]) {
        [self.delegate zy_categoryView:self didScrollSelectedItemAtIndex:index];
    }
}

// 正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    if ([self.delegate respondsToSelector:@selector(zy_categoryView:scrollingFromLeftIndex:toRightIndex:ratio:)]) {
        [self.delegate zy_categoryView:self scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio];
    }
}

#pragma mark - JXCategoryListContainerViewDelegate
// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    if ([self.delegate respondsToSelector:@selector(numberOfListsInlistContainerView:)]) {
        return [self.delegate numberOfListsInlistContainerView:self];
    };
    return 0;
}

// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(zy_listContainerView:initListForIndex:)]) {
        NSObject<JXCategoryListContentViewDelegate> *delegate = [self.delegate zy_listContainerView:self initListForIndex:index];
        
        if (![delegate respondsToSelector:@selector(listView)]) {
            SEL sel = @selector(listView);
            Method addMethod = class_getInstanceMethod([self class], sel);
            class_addMethod([delegate class], sel, class_getMethodImplementation([self class], sel), method_getTypeEncoding(addMethod));
        }
        
        BOOL isConform = NO;
        UIViewController *viewController = (UIViewController *)delegate;
        do {
            isConform = [viewController conformsToProtocol:@protocol(ZYCategoryViewRefreshDelegate)];
            if (!isConform) {
                while (viewController.nextResponder) {
                    viewController = (UIViewController *)viewController.nextResponder;
                    if ([viewController isKindOfClass:[UIViewController class]]) {
                        break;
                    }
                }
            }
        } while (!isConform && viewController);
        if (isConform) {
            if (![delegate respondsToSelector:@selector(setCategoryVCDelegate)]) {
                objc_setAssociatedObject(delegate, @selector(categoryVCDelegate), self, OBJC_ASSOCIATION_ASSIGN);
            }
            
            if (![delegate respondsToSelector:@selector(zy_selectIndex)]) {
                SEL sel = @selector(zy_selectIndex);
                SEL repSel = @selector(rep_selectIndex);
                Method addMethod = class_getInstanceMethod([self class], repSel);
                class_addMethod([delegate class], sel, class_getMethodImplementation([self class], repSel), method_getTypeEncoding(addMethod));
            }
            
            if (![delegate respondsToSelector:@selector(zy_viewController)]) {
                SEL sel = @selector(zy_viewController);
                SEL repSel = @selector(rep_viewController);
                Method addMethod = class_getInstanceMethod([self class], repSel);
                class_addMethod([delegate class], sel, class_getMethodImplementation([self class], repSel), method_getTypeEncoding(addMethod));
            }
            
            if (![delegate respondsToSelector:@selector(zy_reloadContainers:)]) {
                SEL sel = @selector(zy_reloadContainers:);
                SEL repSel = @selector(rep_reloadContainers:);
                Method addMethod = class_getInstanceMethod([self class], repSel);
                class_addMethod([delegate class], sel, class_getMethodImplementation([self class], repSel), method_getTypeEncoding(addMethod));
            }
            
            if (![delegate respondsToSelector:@selector(zy_callbackSuperVC:)]) {
                SEL sel = @selector(zy_callbackSuperVC:);
                SEL repSel = @selector(rep_callbackSuperVC:);
                Method addMethod = class_getInstanceMethod([self class], repSel);
                class_addMethod([delegate class], sel, class_getMethodImplementation([self class], repSel), method_getTypeEncoding(addMethod));
            }
        }
        return delegate;
    }
    return nil;
}

/** 返回自定义UIScrollView或UICollectionView的Class 某些特殊情况需要自己处理UIScrollView内部逻辑。比如项目用了FDFullscreenPopGesture，需要处理手势相关代理。
 */
- (Class)scrollViewClassInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return NSClassFromString(@"ZYCategoryListContainerScrollView");
}


#pragma mark - Other
- (NSMutableDictionary *)refreshDict {
    if (!_refreshDict) {
        _refreshDict = [NSMutableDictionary dictionary];
    }
    return _refreshDict;
}

- (CGFloat)widthForFont:(UIFont *)font text:(NSString *)text {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping text:text];
    return size.width;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode text:(NSString *)text {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [text sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}
@end
