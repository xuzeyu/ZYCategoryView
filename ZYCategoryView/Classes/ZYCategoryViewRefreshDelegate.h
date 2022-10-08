//
//  ZYCategoryViewRefreshDelegate.h
//  ReadBook
//
//  Created by XUZY on 2021/5/25.
//  Copyright © 2021 xuzy. All rights reserved.
//

#ifndef ZYCategoryViewRefreshDelegate_h
#define ZYCategoryViewRefreshDelegate_h

#import "ZYCategoryCallSuperParameter.h"
#import "ZYCategoryCallSubParameter.h"
@protocol ZYCategoryViewRefreshDelegate <NSObject>
@optional
- (UIViewController *)zy_viewController; //父viewController
- (NSInteger)zy_selectIndex; //返回当前选择的index
- (void)zy_reloadContainers:(ZYCategoryCallSubParameter *)parameter; //刷新子内容
- (void)zy_callbackSuperVC:(ZYCategoryCallSuperParameter *)parameter; //回调父viewController
@end

#endif /* ZYCategoryViewRefreshDelegate_h */
