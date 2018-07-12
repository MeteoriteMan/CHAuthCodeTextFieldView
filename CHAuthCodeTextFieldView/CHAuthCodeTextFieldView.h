//
//  CHAuthCodeTextFieldView.h
//  张晨晖
//
//  Created by 张晨晖 on 2018/7/12.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CHAuthCodeTextFieldViewInputEndBlock)(NSString *numberStr);

@interface CHAuthCodeTextFieldView : UIView

/// 输入键盘样式
@property (nonatomic ,assign) UIKeyboardType textFiledKeyboardType;

/// 输入框个数
@property (nonatomic ,assign) NSInteger numberOfTextField;

/// 输入框大小
@property (nonatomic ,assign) CGSize sizeOfTextField;

/// 左边间距
@property (nonatomic ,assign) CGFloat intervalLeft;

/// 右边间距
@property (nonatomic ,assign) CGFloat intervalRight;

/// 输入框边框大小
@property (nonatomic ,assign) CGFloat textFieldBorderWidth;

/// 输入框边框大小
@property (nonatomic ,assign) CGFloat textFieldBorderCornerRadius;

// Mark: BorderColor
/// 光标颜色
@property (nonatomic ,strong) UIColor *textFieldCursorColor;

/// 输入框边框普通状态颜色
@property (nonatomic ,strong) UIColor *textFieldBorderNormalColor;

/// 输入框边框编辑状态颜色
@property (nonatomic ,strong) UIColor *textFieldBorderEditingColor;

/// 输入完成Block
@property (nonatomic ,copy) CHAuthCodeTextFieldViewInputEndBlock authCodeTextFieldViewInputEndBlock;

/// 刷新输入框控件
- (void)reloadData;

/// 清除已输入信息
- (void)clearAllInputs;

@end
