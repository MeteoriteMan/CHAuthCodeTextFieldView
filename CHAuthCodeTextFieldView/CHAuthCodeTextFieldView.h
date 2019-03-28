//
//  CHAuthCodeTextFieldView.h
//  张晨晖
//
//  Created by 张晨晖 on 2018/7/12.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAuthCodeTextFieldView;
@class CHAuthCodeTextField;

typedef void(^CHAuthCodeTextFieldViewInputEndBlock)(CHAuthCodeTextFieldView *authCodeTextFieldView , NSString *numberStr);

@protocol CHAuthCodeTextFieldViewDelegate <NSObject>

@optional
- (void)authCodeTextFieldView:(CHAuthCodeTextFieldView *)authCodeTextFieldView inputEnd:(NSString *)numberStr;

@end

@interface CHAuthCodeTextFieldView : UIView

- (instancetype)initWithCHAuthCodeTextTextFieldSubClass:(Class)authCodeTextField;

@property (nonatomic ,weak) id <CHAuthCodeTextFieldViewDelegate> delegate;

/// 输入完成Block
@property (nonatomic ,copy) CHAuthCodeTextFieldViewInputEndBlock authCodeTextFieldViewInputEndBlock;

/// 输入键盘样式
@property (nonatomic ,assign) UIKeyboardType textFiledKeyboardType;

/// 输入框个数
@property (nonatomic ,assign) NSInteger numberOfTextField;

/// 是否开启安全输入
@property (nonatomic ,assign) BOOL secureTextEntry;

/// 左边间距
@property (nonatomic ,assign) CGFloat intervalLeft;

/// 右边间距
@property (nonatomic ,assign) CGFloat intervalRight;

/// 输入框之间间距
@property (nonatomic ,assign) CGFloat textFieldInterval;

/// 输入框边框大小
@property (nonatomic ,assign) CGFloat textFieldBorderWidth;

/// 输入框边框圆角
@property (nonatomic ,assign) CGFloat textFieldBorderCornerRadius;

/// 输入框文字颜色.
@property (nonatomic ,strong) UIColor *textFieldColor;

/// 输入框字体
@property (nonatomic ,strong) UIFont *textFieldNormalFont;

/// 输入框字体(可以通过设置两种字体大小的不同"调整"光标高度)
@property (nonatomic ,strong) UIFont *textFieldEditingFont;

// Mark: BorderColor
/// 光标颜色
@property (nonatomic ,strong) UIColor *textFieldCursorColor;

/// 输入框边框普通状态颜色
@property (nonatomic ,strong) UIColor *textFieldBorderNormalColor;

/// 输入框边框编辑状态颜色
@property (nonatomic ,strong) UIColor *textFieldBorderEditingColor;

/// 刷新输入框控件(仅仅重置控件).要起调输入框使用becomEditStatus
- (void)reloadData;

/// 清除已输入信息(仅仅清除已有输入)
- (void)clearAllInputs;

/// 开启输入状态
- (void)becomeEditStatus;

/// 结束输入状态
- (void)resignEditStatus;

@end
