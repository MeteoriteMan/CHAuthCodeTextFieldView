//
//  CHAuthCodeTextField.m
//  张晨晖
//
//  Created by 张晨晖 on 2018/7/9.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import "CHAuthCodeTextField.h"

@implementation CHAuthCodeTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)deleteBackward {//删除键
    [super deleteBackward];
    BOOL conform = [self.authCodeTextFieldDeleteBackwardDelegate conformsToProtocol:@protocol(CHAuthCodeTextFieldDeleteBackwardDelegate)];
    BOOL canResponse = [self.authCodeTextFieldDeleteBackwardDelegate respondsToSelector:@selector(deleteBackward:)];
    if (conform && canResponse) {
        [self.authCodeTextFieldDeleteBackwardDelegate deleteBackward:self];
    }
}

@end
