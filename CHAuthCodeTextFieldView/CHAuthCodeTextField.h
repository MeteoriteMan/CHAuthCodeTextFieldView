//
//  CHAuthCodeTextField.h
//  张晨晖
//
//  Created by 张晨晖 on 2018/7/9.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHAuthCodeTextFieldDeleteBackwardDelegate<NSObject>

/// 无内容物时的删除
- (void)deleteBackward:(UITextField *)textField;

@end

@interface CHAuthCodeTextField : UITextField

@property (nonatomic ,weak) id<CHAuthCodeTextFieldDeleteBackwardDelegate> authCodeTextFieldDeleteBackwardDelegate;

@end
