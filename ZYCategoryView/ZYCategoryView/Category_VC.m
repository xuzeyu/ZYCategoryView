//
//  Category_VC.m
//  ZYCategoryView
//
//  Created by XUZY on 2022/1/6.
//

#import "Category_VC.h"
#import "ZYCategoryView.h"
#import "Masonry.h"
#import "ViewController.h"

@interface Category_VC () <ZYCategoryViewDelegate>
@property (nonatomic, strong) ZYCategoryView *categoryView;
@end

@implementation Category_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.categoryView = [[ZYCategoryView alloc] init];
    self.categoryView.lineHeight = 1;
    self.categoryView.delegate = self;
    self.categoryView.titles = @[@"title1", @"title2", @"title3"];
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titleHeight = 45;
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(ZYCategoryView *)listContainerView {
    return 3;
}

// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)zy_listContainerView:(ZYCategoryView *)categoryView initListForIndex:(NSInteger)index {
    ViewController *vc = [[ViewController alloc] init];
    vc.index = index;
    return vc;
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}

@end
