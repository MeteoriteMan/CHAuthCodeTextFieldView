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

@property (nonatomic ,strong) NSArray <CHAuthCodeTextField *> *textFieldArray;

@end

@implementation CHAuthCodeTextFieldView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setup {

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)reloadData {
    for (UIView *textField in self.textFieldArray) {
        [textField removeFromSuperview];
    }
    [self layoutIfNeeded];
    CGFloat interval = (self.bounds.size.width - self.intervalLeft - self.intervalRight - self.numberOfTextField * self.sizeOfTextField.width) / (self.numberOfTextField - 1);
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < self.numberOfTextField; i++) {
        CHAuthCodeTextField *textFiled = [[CHAuthCodeTextField alloc] init];
        textFiled.delegate = self;
        textFiled.authCodeTextFieldDeleteBackwardDelegate = self;
        [self addSubview:textFiled];
        textFiled.tintColor = self.textFieldCursorColor;
        textFiled.font = [UIFont systemFontOfSize:18];
        textFiled.textAlignment = NSTextAlignmentCenter;
        textFiled.layer.borderWidth = self.textFieldBorderWidth;
        textFiled.layer.cornerRadius = self.textFieldBorderCornerRadius;
        textFiled.layer.borderColor = self.textFieldBorderNormalColor.CGColor;
        textFiled.keyboardType = self.textFiledKeyboardType;
        [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(self.sizeOfTextField.height);
        }];
        textFiled.tag = i;
        [textFiled addTarget:self action:@selector(textFieldPhoneEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [arrayM addObject:textFiled];
    }
    [arrayM.copy mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:interval leadSpacing:self.intervalLeft tailSpacing:self.intervalRight];
    [arrayM.copy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.bottom.offset(0);
    }];
    self.textFieldArray = arrayM.copy;

    [self.textFieldArray.firstObject becomeFirstResponder];
}

- (void)textFieldPhoneEditingChanged:(UITextField *)sender {
    if (sender.text.length == 1) {
        [sender endEditing:YES];
        //切换到下一个
        CHAuthCodeTextField *nextTextField;
        if (sender.tag < self.numberOfTextField - 1) {//如果不是最后一个
            for (CHAuthCodeTextField *textField in self.textFieldArray) {
                if (textField.tag == sender.tag + 1) {
                    nextTextField = textField;
                    break;
                }
            }
            [nextTextField becomeFirstResponder];
        } else if (sender.tag == self.numberOfTextField - 1) {//输入完直接验证
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
    if (range.length == 1 && string.length == 0) {
        if (textField.tag != 0) {//不是第一个
            //清除textField
            //1.把后头的删掉
            for (NSInteger i = textField.tag; i < self.textFieldArray.count; i++) {
                self.textFieldArray[i].text = @"";
            }
            //2.把前头的删掉
            [textField endEditing:YES];
            [self.textFieldArray[textField.tag - 1] becomeFirstResponder];
        } else {
            textField.text = @"";
        }
        return NO;
    } else if (textField.text.length >= 1) {//切换到下个
        textField.text = [textField.text substringToIndex:1];
        CHAuthCodeTextField *nextTextField;
        if (textField.tag < self.numberOfTextField - 1) {//如果不是最后一个
            for (CHAuthCodeTextField *textFieldNext in self.textFieldArray) {
                if (textFieldNext.tag == textField.tag + 1) {
                    nextTextField = textFieldNext;
                    break;
                }
            }
            nextTextField.text = string;
            if (nextTextField.tag < self.numberOfTextField) {//不是最后一个
                for (CHAuthCodeTextField *textFieldNext in self.textFieldArray) {
                    if (textFieldNext.tag == nextTextField.tag + 1) {
                        nextTextField = textFieldNext;
                        break;
                    }
                }
                [nextTextField becomeFirstResponder];
            }
        }
        return NO;
    }

    return YES;
}

// 变成第一响应者调用
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = self.textFieldBorderEditingColor.CGColor;
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
    if (self.authCodeTextFieldViewInputEndBlock) {
        NSMutableString *stringM = [NSMutableString string];
        for (CHAuthCodeTextField *textField in self.textFieldArray) {
            [stringM appendString:textField.text];
        }
        self.authCodeTextFieldViewInputEndBlock(stringM.copy);
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
    [self.textFieldArray.firstObject becomeFirstResponder];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint convertPoint = [self convertPoint:point toView:self];
    NSLog(@"%@",NSStringFromCGPoint(convertPoint));
    if (CGRectContainsPoint(self.bounds, convertPoint)) {
        return self;
    } else {
        for (CHAuthCodeTextFieldView *textField in self.textFieldArray) {
            [textField resignFirstResponder];
        }
        return [super hitTest:point withEvent:event];
    }
}

@end
