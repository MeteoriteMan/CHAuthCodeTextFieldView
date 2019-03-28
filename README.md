# CHAuthCodeTextField
一个输入框框架

## 效果

![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHAuthCodeTextFieldView-iPhone%208%20Plus-Demo.gif?raw=true)

## 使用

```
 self.authCodeTextFieldView = [[CHAuthCodeTextFieldView alloc] init];
    self.authCodeTextFieldView.numberOfTextField = 6;
    self.authCodeTextFieldView.sizeOfTextField = CGSizeMake(40, 43);
    self.authCodeTextFieldView.textFieldInterval = 4
    __weak typeof(self) weakSelf = self;
    self.authCodeTextFieldView.authCodeTextFieldViewInputEndBlock = ^(NSString *numberStr) {
		//在这里进行输入数据是否正确的判断
	};
    [self.view addSubview:self.authCodeTextFieldView];
    [self.authCodeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuide).offset(44);
    }];

    [self.authCodeTextFieldView reloadData];
```

## 自定义样式的实现.

### 仿美团样式(UI颜色就懒得还原了).

![](https://github.com/MeteoriteMan/Assets/blob/master/png/CHAuthCodeTextFieldView-Demo(0.0.2)@2x.png?raw=true)

**注:传入的类一定是CHAuthCodeTextField类的子类**
重写`- (instancetype)initWithFrame:(CGRect)frame`之后一定要调用一下`[self setTextfieldNormal]`不然不能刷新正常状态的UI.

```
- (void)setTextFieldNormarl {
	[super setTextFieldNormarl];
	/// 正常状态
}

- (void)setTextFieldEdit {
    [super setTextFieldEdit];
    /// 编辑状态
}

创建验证码视图的时候
`- (instancetype)initWithCHAuthCodeTextTextFieldSubClass:(Class)authCodeTextField;`
class传入你自定义的Class

```



## 安装

使用 [CocoaPods](http://www.cocoapods.com/) 集成.
首先在podfile中
>`pod 'CHAuthCodeTextFieldView'`

安装一下pod

>`#import <CHAuthCodeTextFieldView/CHAuthCodeTextFieldView.h>`


## 更新记录

|版本|更新内容|
|:--|:--|
|0.0.3|新增secureTextEntry明/暗文支持|
|0.0.2|支持自定义控件,高度为父控件高度.内容物宽度为自动计算|
|0.0.1|初版,不支持自定义,以及边框大小得传入|