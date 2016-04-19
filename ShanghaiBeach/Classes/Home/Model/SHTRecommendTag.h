//
//  SHTRecommendTag.h
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/19.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHTRecommendTag : NSObject

/**图片*/
@property (nonatomic, copy) NSString *image_list;
/**名字*/
@property (nonatomic, copy) NSString *theme_name;
/**订阅数*/
@property (nonatomic, assign) NSInteger sub_number;

@end
