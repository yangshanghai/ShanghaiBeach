//
//  SHTRecommendCategory.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/18.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTRecommendCategory.h"

@implementation SHTRecommendCategory

//懒加载
-(NSMutableArray *)users
{
    if(!_users){
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
