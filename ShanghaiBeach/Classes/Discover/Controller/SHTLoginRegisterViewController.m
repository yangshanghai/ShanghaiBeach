//
//  SHTLoginRegisterViewController.m
//  ShanghaiBeach
//
//  Created by 杨上海 on 16/4/19.
//  Copyright © 2016年 杨上海. All rights reserved.
//

#import "SHTLoginRegisterViewController.h"

@interface SHTLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *passField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;


@end

@implementation SHTLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view insertSubview:self.bgView atIndex:0];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    NSAttributedString *passPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:attrs];
    
    self.phoneField.attributedPlaceholder = placeholder;
    self.passField.attributedPlaceholder = passPlaceholder;
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} range:NSMakeRange(0, 1)];
//    
//    [placeholder setAttributes:@{
//                                NSForegroundColorAttributeName: [UIColor yellowColor],
//                                NSFontAttributeName: [UIFont systemFontOfSize:30],
//                                } range:NSMakeRange(1, 1)];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(2, 1)];
//    
//    self.phoneField.attributedPlaceholder = placeholder;
    
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    //退出键盘
    [self.view endEditing:YES];
    
    if(self.loginViewLeftMargin.constant == 0){
        self.loginViewLeftMargin.constant = -self.view.width;
        button.selected = YES;
    }else{
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
