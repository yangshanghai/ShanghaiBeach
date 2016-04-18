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

//遵守协议和代理
@interface SHTRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSArray *categories;

@property (nonatomic, strong)NSArray *users;

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@end

@implementation SHTRecommendViewController

static NSString * const SHTCategoryId = @"category";
static NSString * const SHTUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categories = [SHTRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
        
    }];
    
    
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(tableView == self.categoryTableView){
//        return self.categories.count;
//    }else{
//        return 0;
//    }
    
    if(tableView == self.categoryTableView){
        
        return self.categories.count;
    }else{
        return self.users.count;
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
        cell.user = self.users[indexPath.row];
        return cell;
        
    }
    

}


//代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTRecommendCategory *c = self.categories[indexPath.row];
    NSLog(@"%@",c.name);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.users = [SHTRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                XMGLog(@"%@",self.users);
        [self.userTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"%@", error);
        
    }];
    
}




@end
