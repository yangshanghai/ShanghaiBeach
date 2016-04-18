//
//  SHTRecommendUser.h
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/18.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHTRecommendUser : NSObject
@property (nonatomic, copy) NSString *header;
@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, strong) NSString *screen_name;

@end
