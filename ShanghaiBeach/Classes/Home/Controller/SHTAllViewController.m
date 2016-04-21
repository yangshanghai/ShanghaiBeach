//
//  SHTAllViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/21.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTAllViewController.h"

@interface SHTAllViewController ()

@end

@implementation SHTAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *aID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aID];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aID];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-----%zd", [self class], indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", NSStringFromUIEdgeInsets(tableView.contentInset));
    NSLog(@"%@", NSStringFromCGRect(tableView.frame));
}





@end
