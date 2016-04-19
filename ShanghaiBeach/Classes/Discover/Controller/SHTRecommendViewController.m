//
//  SHTRecommendViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/18.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "SHTRecommendCategoryCell.h"
#import <MJExtension.h>
#import "SHTRecommendCategory.h"
#import "SHTRecommendUserCell.h"
#import "SHTRecommendUser.h"
#import <MJRefresh.h>

//定义一个当前选中的类别的宏
#define SHTSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

//遵守协议和代理
@interface SHTRecommendViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray *categories;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

//请求参数
@property (nonatomic, strong) NSDictionary *parmas;

//AFN请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation SHTRecommendViewController

static NSString * const SHTCategoryId = @"category";
static NSString * const SHTUserId = @"user";

-(AFHTTPSessionManager *)manager
{
    if(!_manager){
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
    
    [self setupRefresh];
    
    [self loadCategories];
    
}

//加载左侧表格数据
-(void)loadCategories
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categories = [SHTRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
        
    }];
}

//控件初始化
-(void)setupTableView
{
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:SHTCategoryId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:SHTUserId];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    self.view.backgroundColor = XMGGlobalBg;
}

-(void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

-(void)loadNewUsers
{
    SHTRecommendCategory *rc = SHTSelectedCategory;
    //设置当前页码为1
    rc.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    
    self.parmas = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *users = [SHTRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [rc.users removeAllObjects];
        
        //添加到当前类别的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if(self.parmas != params) return;
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
   
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if(self.parmas != params) return;
        
        [self.userTableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
    }];
}

#pragma mark - 加载用户数据
-(void)loadMoreUsers
{
    SHTRecommendCategory *category = SHTSelectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.parmas = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *users = [SHTRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当前类别的用户数组中
        [category.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if(self.parmas != params) return;
        
        [self.userTableView reloadData];
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(self.parmas != params) return;
        
        [self.userTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *时刻监测footer的状态
 */
-(void)checkFooterState
{
    SHTRecommendCategory *rc = SHTSelectedCategory;
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    //让底部控件结束刷新
    if(rc.users.count == rc.total){
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

//数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.categoryTableView){
        return self.categories.count;
    }else{
        //监测footer状态
        [self checkFooterState];
        return [SHTSelectedCategory users].count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(tableView == self.categoryTableView){
        SHTRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SHTCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{
        SHTRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:SHTUserId];
        cell.user = [SHTSelectedCategory users][indexPath.row];
        return cell;
    }
}


//代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    SHTRecommendCategory *c = self.categories[indexPath.row];
    
    if(c.users.count){
        [self.userTableView reloadData];
    }else{
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header beginRefreshing];
    }
    
}

#pragma mark - 控制器销毁
-(void)dealloc
{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}




@end
