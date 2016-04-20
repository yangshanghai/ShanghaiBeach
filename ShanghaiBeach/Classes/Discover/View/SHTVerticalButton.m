//
//  SHTVerticalButton.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/20.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTVerticalButton.h"

@implementation SHTVerticalButton

-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

-(void)awakeFromNib
{
    [self setup];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.height;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}
@end
