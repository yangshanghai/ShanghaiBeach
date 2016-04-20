//
//  SHTDiscoverViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/15.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTDiscoverViewController.h"
#import "SHTRecommendViewController.h"
#import "SHTLoginRegisterViewController.h"

@interface SHTDiscoverViewController ()

@end

@implementation SHTDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

- (void)friendsClick
{
    SHTRecommendViewController *vc = [[SHTRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister {
    
    SHTLoginRegisterViewController *login = [[SHTLoginRegisterViewController alloc] init];
    
    [self presentViewController:login animated:YES completion:nil]; //modal方式
}


@end
