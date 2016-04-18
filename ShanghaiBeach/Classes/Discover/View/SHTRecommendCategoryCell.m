//
//  SHTRecommendCategoryCell.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/18.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTRecommendCategoryCell.h"
#import "SHTRecommendCategory.h"

@interface SHTRecommendCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation SHTRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = XMGRGBColor(244, 244, 244);
//    self.textLabel.textColor = XMGRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = XMGRGBColor(219, 21, 26);
//    
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? XMGRGBColor(219, 21, 26) : XMGRGBColor(78, 78, 78);
    
}
-(void)setCategory:(SHTRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 1;
    self.textLabel.height = self.contentView.height - 10;
}
@end
