# QYSlideNavigation

## 功能:
* 目前功能比较简单， 只是满足项目需求。 以后有需要添加的功能会继续完善。
* 根据滑动进度动态调整文字大小；
* 可以修改滚动标题的字体大小、颜色、缩放比例等。

```
/**
An array of view controllers that are content of the scrollView.
eg:
vc.controllerItems = @[[ViewControllerA new],[ViewControllerB new],[ViewControllerC new]];
*/
@property (nonatomic, copy) NSArray<UIViewController *> *controllerItems;
/**
An array of titles that are content of the scrollView.
eg:
vc.titleItems = @[@"TitleA",@"TitleB",@"TitleC"];
*/
@property (nonatomic, copy) NSArray<NSString *> *titleItems;
/**
The font of the title. Default is 14-point system font.
*/
@property (nonatomic, strong) UIFont *titleFont;
/**
The color of the normal title. Default is lightGray.
*/
@property (nonatomic, strong) UIColor *normalColor;
/**
The color of the selected title. Default is blue.
*/
@property (nonatomic, strong) UIColor *selectedColor;
/**
The scale by which the text title is scaled. Default is 1.2f.
*/
@property (nonatomic, assign) CGFloat makeScale;
```
## 使用方法如下:
```
QYSlideNavigationViewController *slideVC = [[QYSlideNavigationViewController alloc] init];
slideVC.controllerItems = @[[TestViewController new],[TestViewController new],[TestViewController new],
[TestViewController new],[TestViewController new],[TestViewController new],
[TestViewController new],[TestViewController new],[TestViewController new]];
slideVC.titleItems = @[@"titleA",@"titleB",@"titleC",
@"titleD",@"titleE",@"titleF",
@"titleG",@"titleH",@"titleI"];
slideVC.selectedColor = [UIColor cyanColor];
slideVC.makeScale = 1.5f;
[self addChildViewController:slideVC];
[self.view addSubview:slideVC.view];
// 或者:
// [self.navigationController pushViewController:slideVC animated:YES];
```
##  效果：
![](https://github.com/qiaoyoung/QYSlideNavigation/blob/master/QYSlideNavigation.gif)


