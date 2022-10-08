//
//  Root_VC.m
//  ZYCategoryView
//
//  Created by XUZY on 2022/1/6.
//

#import "Root_VC.h"
#import "Category_VC.h"

@interface Root_VC ()

@end

@implementation Root_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 100, 200, 50);
}

- (void)buttonClick {
    Category_VC *vc = [[Category_VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
