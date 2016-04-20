//
//  SHTHomeViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/15.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTHomeViewController.h"
#import "SHTRecommendTagsViewController.h"

@interface SHTHomeViewController ()
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation SHTHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTitlesView];
    
   
}

-(void)setupTitlesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    //颜色设置透明度选择方案
    //titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    //内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = self.view.width / titles.count;
    CGFloat height = titlesView.height;
    
    for(NSInteger i = 0; i < titles.count; i++){
        UIButton *button = [[UIButton alloc] init];
        button.width = width;
        button.height = height;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //[button layoutIfNeeded]; //强制布局（强制更新子控件的frame）
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if(i == 0){
            button.enabled = NO;
            self.selectedButton = button;
            
            //让按钮内部的labe感觉文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
}

-(void)titleClick:(UIButton *)button
{
    //处理选中按钮
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    //动画切换
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}

-(void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

- (void)tagClick
{
    SHTRecommendTagsViewController *tags = [[SHTRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

@end
