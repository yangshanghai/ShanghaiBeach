//
//  SHTDialogueViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/15.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTDialogueViewController.h"

@interface SHTDialogueViewController ()

@end

@implementation SHTDialogueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"对话";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

- (void)friendsClick
{
    XMGLogFunc;
}

@end
