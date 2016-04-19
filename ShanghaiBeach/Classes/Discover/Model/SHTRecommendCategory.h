//
//  SHTRecommendCategory.h
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/18.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHTRecommendCategory : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic,copy) NSString *name;

//这个类别对应的用户数据
@property (nonatomic, strong) NSMutableArray *users;

/**总数*/
@property (nonatomic, assign) NSInteger total;

/**当前页码*/
@property (nonatomic, assign) NSInteger currentPage;

@end
