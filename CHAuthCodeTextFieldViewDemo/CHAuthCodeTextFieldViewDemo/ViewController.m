//
//  ViewController.m
//  CHAuthCodeTextFieldViewDemo
//
//  Created by 张晨晖 on 2018/7/12.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "CHAuthCodeTextFieldView.h"
#import <Masonry.h>
#import <MBProgressHUD.h>

@interface ViewController ()

@property (nonatomic ,strong) CHAuthCodeTextFieldView *authCodeTextFieldView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.authCodeTextFieldView = [[CHAuthCodeTextFieldView alloc] init];
    self.authCodeTextFieldView.numberOfTextField = 6;
    self.authCodeTextFieldView.sizeOfTextField = CGSizeMake(40, 43);
    self.authCodeTextFieldView.intervalLeft = 26;
    self.authCodeTextFieldView.intervalRight = 26;
    self.authCodeTextFieldView.textFieldBorderWidth = 1;
    self.authCodeTextFieldView.textFieldBorderCornerRadius = 4;
    self.authCodeTextFieldView.textFieldCursorColor = [UIColor greenColor];
    self.authCodeTextFieldView.textFiledKeyboardType = UIKeyboardTypeNumberPad;
    self.authCodeTextFieldView.textFieldBorderNormalColor = [UIColor darkTextColor];
    self.authCodeTextFieldView.textFieldBorderEditingColor = [UIColor greenColor];
    __weak typeof(self) weakSelf = self;
    self.authCodeTextFieldView.authCodeTextFieldViewInputEndBlock = ^(NSString *numberStr) {

        if ([numberStr isEqualToString:@"111111"]) {
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
            [weakSelf.authCodeTextFieldView clearAllInputs];
        }
    };
    [self.view addSubview:self.authCodeTextFieldView];
    [self.authCodeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide).offset(44);
    }];

    [self.authCodeTextFieldView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
