//
//  SHTHomeViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/15.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTHomeViewController.h"
#import "SHTRecommendTagsViewController.h"
#import "SHTAllViewController.h"
#import "SHTVideoViewController.h"
#import "SHTVoiceViewController.h"
#import "SHTPictureViewController.h"
#import "SHTWordViewController.h"

@interface SHTHomeViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, weak) UIButton *selectedButton;

@property (nonatomic, weak) UIView *titlesView;

//底部的所有内容
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation SHTHomeViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self setupNav];
    
    [self setupChildVces];
	
	[self setupTitlesView];
	
	[self setupContentView];
	
}

-(void)setupChildVces
{
    SHTAllViewController *all = [[SHTAllViewController alloc] init];
    [self addChildViewController:all];
    
    SHTVideoViewController *video = [[SHTVideoViewController alloc] init];
    [self addChildViewController:video];
    
    SHTVoiceViewController *voice = [[SHTVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    SHTPictureViewController *picture = [[SHTPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    SHTWordViewController *word = [[SHTWordViewController alloc] init];
    [self addChildViewController:word];
}

-(void)setupContentView
{
	//不要自动调整inset
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	UIScrollView *contentView = [[UIScrollView alloc] init];
	
	contentView.frame = self.view.bounds;
    
    contentView.delegate = self;
    
    //ScrollView分页功能，否则在手势滑动的时候就会出现无法分页，效果难用
    contentView.pagingEnabled = YES;
	
	//以下方案导致scrollview不能有穿透效果
//    contentView.width = self.view.width;
//    contentView.y = 99;
//    contentView.height = self.view.height - contentView.y - self.tabBarController.tabBar.height;

    //设置内边距
//	CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//	CGFloat buttom = self.tabBarController.tabBar.height;
//	contentView.contentInset = UIEdgeInsetsMake(top, 0, buttom, 0);
//	contentView.backgroundColor = [UIColor yellowColor];
	[self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
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
	self.titlesView = titlesView;
	
	//底部的红色指示器
	UIView *indicatorView = [[UIView alloc] init];
	indicatorView.height = 2;
	indicatorView.y = titlesView.height - indicatorView.height;
	indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.tag = -1;
	self.indicatorView = indicatorView;
	
	//内部的子标签
	NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
	CGFloat width = self.view.width / titles.count;
	CGFloat height = titlesView.height;
	
	for(NSInteger i = 0; i < titles.count; i++) {
		UIButton *button = [[UIButton alloc] init];
		button.width = width;
		button.height = height;
		button.x = i * width;
        button.tag = i;
		[button setTitle:titles[i] forState:UIControlStateNormal];
		//[button layoutIfNeeded]; //强制布局（强制更新子控件的frame）
		[button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
		button.titleLabel.font = [UIFont systemFontOfSize:14];
		[button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
		
		[titlesView addSubview:button];
		
		//默认点击了第一个按钮
		if(i == 0) {
			button.enabled = NO;
			self.selectedButton = button;
			
			//让按钮内部的labe感觉文字内容来计算尺寸
			//[button.titleLabel sizeToFit];
			//计算宽度第二种方案
			self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;
			//self.indicatorView.width = button.titleLabel.width;
			self.indicatorView.centerX = button.centerX;
		}
	}
    [titlesView addSubview:indicatorView];
	
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
    
    //切换子控制器（滚动）
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
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

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
