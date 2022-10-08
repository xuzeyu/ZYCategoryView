//
//  ViewController.h
//  ZYCategoryView
//
//  Created by XUZY on 2021/12/31.
//

#import <UIKit/UIKit.h>
#import "ZYCategoryViewRefreshDelegate.h"

@interface ViewController : UIViewController <ZYCategoryViewRefreshDelegate>
@property (nonatomic, assign) NSInteger index;

@end

