//
//  ViewController.m
//  ZYCategoryView
//
//  Created by XUZY on 2021/12/31.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

static int tag = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%ld - %d", (long)self.index, tag++);
    });
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 100, 200, 50);
}

- (void)buttonClick {
//    [self zy_reloadContainers:ZYCategoryCallSubParameter.new.sType(ZYCategoryCallSubReloadTypeOther).sIsImmediately(YES).sIsForceLoad(NO).sIsSelectorContinue(YES).sSelector(@selector(reloadData))];
    [self.zy_viewController.navigationController popViewControllerAnimated:YES];
}

- (void)reloadData {
    NSLog(@"reloadData %ld - %d", (long)self.index, tag++);
}

@end
