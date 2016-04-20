//
//  SHTPushGuideView.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/20.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTPushGuideView.h"

@implementation SHTPushGuideView

+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)clode:(id)sender {
    [self removeFromSuperview];
}

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    //获取当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if(![currentVersion isEqualToString:sanboxVersion]){
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        SHTPushGuideView *guideView = [SHTPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}


@end
