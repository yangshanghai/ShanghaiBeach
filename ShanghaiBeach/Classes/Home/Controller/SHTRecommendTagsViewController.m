//
//  SHTRecommendTagsViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/19.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "SHTRecommendTag.h"
#import "SHTRecommendTagCell.h"

static NSString * const SHTTagsId = @"tag";

@interface SHTRecommendTagsViewController ()

//AFN请求管理者
//@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSArray *tags;

@end



@implementation SHTRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    
    [self setupTableView];
    
    [self loadTags];
    
    
}

-(void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:SHTTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.backgroundColor = XMGGlobalBg;
}

- (void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        self.tags = [SHTRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
    
    // 发送请求
//    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        //self.tags = [XMGRecommendTag objectArrayWithKeyValuesArray:responseObject];
//        //[self.tableView reloadData];
//        NSLog(@"%@", responseObject);
//        
//        [SVProgressHUD dismiss];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHTRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:SHTTagsId];
    
    // Configure the cell...
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}



@end
