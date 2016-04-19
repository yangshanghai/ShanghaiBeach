//
//  SHTRecommendTagCell.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/19.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTRecommendTagCell.h"
#import "SHTRecommendTag.h"
#include <UIImageView+WebCache.h>

@interface SHTRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation SHTRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRecommendTag:(SHTRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if(recommendTag.sub_number < 10000){
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    
    self.subNumberLabel.text = subNumber;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    
    frame.size.width -= 2 * frame.origin.x;
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
