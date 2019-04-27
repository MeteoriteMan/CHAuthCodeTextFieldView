//
//  CHAuthCodeTextFieldView.m
//  张晨晖
//
//  Created by 张晨晖 on 2018/7/12.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import "CHAuthCodeTextFieldView.h"
#import "CHAuthCodeTextField.h"
#import <Masonry/Masonry.h>

@interface CHAuthCodeTextFieldView () <UITextFieldDelegate ,CHAuthCodeTextFieldDeleteBackwardDelegate>

@property (nonatomic ,strong) Class authCodeTextFieldViewClass;

@property (nonatomic ,strong) NSArray <CHAuthCodeTextField *> *textFieldArray;

@property (nonatomic ,strong) UITextField *firstResponderTextFiled;

@end

@implementation CHAuthCodeTextFieldView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (Class)authCodeTextFieldViewClass {
    if (!_authCodeTextFieldViewClass) {
        _authCodeTextFieldViewClass = [CHAuthCodeTextField class];
    }
    return _authCodeTextFieldViewClass;
}

- (UIColor *)textFieldColor {
    if (!_textFieldColor) {
        _textFieldColor = [UIColor darkTextColor];
    }
    return _textFieldColor;
}

- (UIFont *)textFieldNormalFont {
    if (!_textFieldNormalFont) {
        _textFieldNormalFont = [UIFont systemFontOfSize:14];
    }
    return _textFieldNormalFont;
}

- (UIFont *)textFieldEditingFont {
    if (!_textFieldEditingFont) {
        _textFieldEditingFont = self.textFieldNormalFont;
    }
    return _textFieldEditingFont;
}

- (instancetype)initWithCHAuthCodeTextTextFieldSubClass:(Class)authCodeTextField {
    if (self = [super init]) {
        self.authCodeTextFieldViewClass = authCodeTextField;
    }
    return self;
}

- (void)reloadData {
    for (UIView *textField in self.textFieldArray) {
        [textField removeFromSuperview];
    }
    [self layoutIfNeeded];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < self.numberOfTextField; i++) {
        CHAuthCodeTextField *textFiled = [[[self.authCodeTextFieldViewClass class] alloc] init];
        textFiled.delegate = self;
        textFiled.authCodeTextFieldDeleteBackwardDelegate = self;
        if (@available(iOS 12.0, *)) {
            textFiled.textContentType = UITextContentTypeOneTimeCode;
        } else {
            // Fallback on earlier versions
            if (@available(iOS 10.0, *)) {
                textFiled.textContentType = @"one-time-code";
            }
        }
        [self addSubview:textFiled];
        textFiled.secureTextEntry = self.secureTextEntry;
        textFiled.tintColor = self.textFieldCursorColor;
        textFiled.textColor = self.textFieldColor;
        textFiled.textFieldNormalFont = self.textFieldNormalFont;
        textFiled.textFieldEditingFont = self.textFieldEditingFont;
        textFiled.textAlignment = NSTextAlignmentCenter;
        textFiled.layer.borderWidth = self.textFieldBorderWidth;
        textFiled.layer.cornerRadius = self.textFieldBorderCornerRadius;
        textFiled.layer.borderColor = self.textFieldBorderNormalColor.CGColor;
        textFiled.keyboardType = self.textFiledKeyboardType;
        [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
        }];
        textFiled.tag = i;
        [textFiled addTarget:self action:@selector(textFieldPhoneEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [arrayM addObject:textFiled];
    }
    [arrayM.copy mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.textFieldInterval leadSpacing:self.intervalLeft tailSpacing:self.intervalRight];
    [arrayM.copy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.bottom.offset(0);
    }];
    self.textFieldArray = arrayM.copy;
}

- (void)textFieldPhoneEditingChanged:(UITextField *)sender {
    if (sender.text.length == 1) {
        [sender endEditing:YES];
        //切换到下一个
        CHAuthCodeTextField *nextTextField;
        if (sender.tag < self.textFieldArray.count - 1) {//如果不是最后一个
            nextTextField = self.textFieldArray[sender.tag + 1];
            [nextTextField becomeFirstResponder];
        } else if (sender.tag == self.textFieldArray.count - 1) {//输入完直接验证
            BOOL allComplete = YES;
            for (CHAuthCodeTextField *textField in self.textFieldArray) {
                if ([textField.text isEqualToString:@""]) {
                    allComplete = NO;
                }
            }
            if (allComplete) {
                //验证
                [self inputComplete];
            } else {
                //没有收入完
            }
        }
    }
}

// 变成第一响应者调用
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = self.textFieldBorderEditingColor.CGColor;
    self.firstResponderTextFiled = textField;
    return YES;
}

// 失去第一响应者时调用
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.layer.borderColor = self.textFieldBorderNormalColor.CGColor;
    return YES;
}

- (void)deleteBackward:(UITextField *)textField {
    //先删除本个textField以及后面的textField
    for (NSInteger i = textField.tag; i < self.textFieldArray.count; i++) {
        textField.text = @"";
    }
    if (textField.tag != 0) {//不是第一个
        self.textFieldArray[textField.tag - 1].text = @"";
        [self.textFieldArray[textField.tag - 1] becomeFirstResponder];
    }
}

- (void)inputComplete {
    NSMutableString *stringM = [NSMutableString string];
    for (CHAuthCodeTextField *textField in self.textFieldArray) {
        [stringM appendString:textField.text];
    }
    if (self.authCodeTextFieldViewInputEndBlock) {
        self.authCodeTextFieldViewInputEndBlock(self ,stringM.copy);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(authCodeTextFieldView:inputEnd:)]) {
        [self.delegate authCodeTextFieldView:self inputEnd:stringM.copy];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self textFileBecomeFirstResponder];
}

- (void)textFileBecomeFirstResponder {
    for (CHAuthCodeTextField *textField in self.textFieldArray) {
        if ([textField.text isEqualToString:@""]) {
            [textField becomeFirstResponder];
            return;
        }
    }
    //到这里表示都不对
}

- (void)clearAllInputs {
    for (CHAuthCodeTextField *textField in self.textFieldArray) {
        textField.text = @"";
    }
}

/// 开启输入状态
- (void)becomeEditStatus {
    [self textFileBecomeFirstResponder];
}

/// 结束输入状态
- (void)resignEditStatus {
    [self.firstResponderTextFiled resignFirstResponder];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint convertPoint = [self convertPoint:point toView:self];
    NSLog(@"%@",NSStringFromCGPoint(convertPoint));
    if (CGRectContainsPoint(self.bounds, convertPoint)) {
        return self;
    } else {
        [self.firstResponderTextFiled resignFirstResponder];
        return [super hitTest:point withEvent:event];
    }
}

@end
