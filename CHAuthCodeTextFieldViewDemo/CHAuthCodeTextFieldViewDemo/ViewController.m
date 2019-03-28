//
//  ViewController.m
//  CHAuthCodeTextFieldViewDemo
//
//  Created by 张晨晖 on 2018/7/12.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "CHAuthCodeTextFieldViewHeader.h"
#import <Masonry.h>
#import <MBProgressHUD.h>
#import "CHAuthCodeTextFieldMeiTuanStyle.h"

@interface ViewController ()

@property (nonatomic ,strong) CHAuthCodeTextFieldView *authCodeTextFieldView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.authCodeTextFieldView = [[CHAuthCodeTextFieldView alloc] initWithCHAuthCodeTextTextFieldSubClass:[CHAuthCodeTextFieldMeiTuanStyle class]];
    self.authCodeTextFieldView.secureTextEntry = YES;
    self.authCodeTextFieldView.numberOfTextField = 4;
    self.authCodeTextFieldView.textFieldInterval = 8;
    self.authCodeTextFieldView.textFieldNormalFont = [UIFont systemFontOfSize:30];
    self.authCodeTextFieldView.textFieldCursorColor = [UIColor darkGrayColor];
    self.authCodeTextFieldView.textFiledKeyboardType = UIKeyboardTypeNumberPad;
    [self.authCodeTextFieldView becomeEditStatus];
    __weak typeof(self) weakSelf = self;
    self.authCodeTextFieldView.authCodeTextFieldViewInputEndBlock = ^(CHAuthCodeTextFieldView *authCodeTextFieldView, NSString *numberStr) {
        if ([numberStr isEqualToString:@"1111"]) {
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            progressHUD.label.text = @"验证通过";
            [progressHUD hideAnimated:YES afterDelay:2];
            progressHUD.completionBlock = ^{
                [weakSelf.authCodeTextFieldView clearAllInputs];
            };
        } else {
            MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            progressHUD.label.text = @"验证码错误,请重新输入";
            [progressHUD hideAnimated:YES afterDelay:2];
            progressHUD.completionBlock = ^{
                [weakSelf.authCodeTextFieldView clearAllInputs];
            };
        }
    };
    [self.view addSubview:self.authCodeTextFieldView];
    [self.authCodeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(22);
        make.right.offset(-22);
        make.top.equalTo(self.mas_topLayoutGuide).offset(44);
        make.height.offset(80);
    }];

    [self.authCodeTextFieldView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
