//
//  SHTRecommendUserCell.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/18.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTRecommendUserCell.h"
#import "SHTRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface SHTRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation SHTRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUser:(SHTRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    NSString *fanscount = nil;
    if(user.fans_count < 10000){
        fanscount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    }else{
        fanscount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    
    self.fansCountLabel.text = fanscount;
    

    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

@end
