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

//遵守协议和代理
@interface SHTRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation SHTRecommendViewController

static NSString * const SHTCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHTRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:SHTCategoryId];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = XMGGlobalBg;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SHTCategoryId];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}




@end
