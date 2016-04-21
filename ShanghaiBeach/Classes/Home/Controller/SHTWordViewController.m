//
//  SHTWordViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/21.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTWordViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface SHTWordViewController ()

/**帖子数据*/
@property (nonatomic, strong) NSArray *topics;

@end

@implementation SHTWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";

    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@", responseObject);
        self.topics = responseObject[@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *aID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aID];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:aID];
    }
    
    NSDictionary *topic = self.topics[indexPath.row];
    
    cell.textLabel.text = topic[@"name"];
    cell.detailTextLabel.text = topic[@"text"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic[@"profile_image"]] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@-----%zd", [self class], indexPath.row];
    
    return cell;
}


@end
