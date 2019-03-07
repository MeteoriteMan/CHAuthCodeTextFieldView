//
//  CHAuthCodeTextFieldMeiTuanStyle.m
//  CHAuthCodeTextFieldViewDemo
//
//  Created by 张晨晖 on 2019/3/6.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "CHAuthCodeTextFieldMeiTuanStyle.h"
#import <Masonry.h>

@interface CHAuthCodeTextFieldMeiTuanStyle ()

@property (nonatomic ,strong) UIView *viewBottomLine;

@end

@implementation CHAuthCodeTextFieldMeiTuanStyle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }   
    [self setTextFieldNormarl];
    return self;
}

- (void)setupUI {
    self.viewBottomLine = [UIView new];
    [self addSubview:self.viewBottomLine];
    [self.viewBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(.5);
    }];
}

- (void)setTextFieldNormarl {
    [super setTextFieldNormarl];
    self.viewBottomLine.backgroundColor = [UIColor lightGrayColor];
}

- (void)setTextFieldEdit {
    [super setTextFieldEdit];
    self.viewBottomLine.backgroundColor = [UIColor darkGrayColor];
}

@end
