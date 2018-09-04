# CHAuthCodeTextField
一个输入框框架

## 效果

![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHAuthCodeTextFieldView-iPhone%208%20Plus-Demo.gif?raw=true)

## 使用

```
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
		//在这里进行输入数据是否正确的判断
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
```

## 安装

使用 [CocoaPods](http://www.cocoapods.com/) 集成.
首先在podfile中
>`pod 'CHAuthCodeTextFieldView'`

安装一下pod

>`#import <CHAuthCodeTextFieldView/CHAuthCodeTextFieldView.h>`
