//
//  QYSlideNavigationViewController.m
//   
//
//  Created by Joeyoung on 2018/7/25.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import "QYSlideNavigationViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
#define kNavHeightTotal [[UIApplication sharedApplication] statusBarFrame].size.height + 44.f

static CGFloat const kTitle_W = 80.f;
static CGFloat const kTitle_H = 44.f;

@interface QYSlideNavigationViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIScrollView *controllerScrollView;
@property (nonatomic ,strong) UIButton * selectedBtn;

@end

@implementation QYSlideNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // normal
    if (!_normalColor) self.normalColor = [UIColor lightGrayColor];
    if (!_selectedColor) self.selectedColor = [UIColor blueColor];
    if (!_titleFont) self.titleFont = [UIFont systemFontOfSize:14];
    if (!_makeScale) self.makeScale = 1.2f;

    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.controllerScrollView];
}

#pragma mark - event
- (void)titleButtonClick:(UIButton *)sender {
    [self currentSelectedTitleButton:sender];
    NSInteger index = sender.tag-1000;
    CGFloat offset_x  = index * kScreenWidth;
    self.controllerScrollView.contentOffset = CGPointMake(offset_x, 0);
    [self addControllerViewWithIndex:index];
}
- (void)addControllerViewWithIndex:(NSInteger)index {
    if (index >= self.childViewControllers.count) return;
    CGFloat origin_x  = index * kScreenWidth;
    UIViewController *vc = self.childViewControllers[index];
    if (vc.view.superview) return;
    vc.view.frame = CGRectMake(origin_x, 0, kScreenWidth, kScreenHight - self.controllerScrollView.frame.origin.y);
    [self.controllerScrollView addSubview:vc.view];
}
- (void)currentSelectedTitleButton:(UIButton *)button {
    [self.selectedBtn setTitleColor:_normalColor forState:UIControlStateNormal];
    self.selectedBtn.transform = CGAffineTransformIdentity;
    [button setTitleColor:_selectedColor forState:UIControlStateNormal];
    button.transform = CGAffineTransformMakeScale(_makeScale, _makeScale);
    self.selectedBtn = button;
    [self setupTitleCenter:button];
}
- (void)setupTitleCenter:(UIButton *)sender {
    if (self.titleScrollView.contentSize.width <= kScreenWidth) return;
    CGFloat offset_x = sender.center.x - kScreenWidth * 0.5;
    if (offset_x < 0) offset_x = 0;
    CGFloat maxOffset  = self.titleScrollView.contentSize.width - kScreenWidth;
    if (offset_x > maxOffset)  offset_x = maxOffset;
    [self.titleScrollView setContentOffset:CGPointMake(offset_x, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index  = self.controllerScrollView.contentOffset.x / kScreenWidth;
    UIButton *selectedBtn = (UIButton *)[self.titleScrollView viewWithTag:(index+1000)];
    if (selectedBtn) [self currentSelectedTitleButton:selectedBtn];
    [self addControllerViewWithIndex:index];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_makeScale == 1) return;
    NSInteger index  = scrollView.contentOffset.x / kScreenWidth;
    if (index >= (self.titleItems.count-1)) return;
    UIButton *leftButton = (UIButton *)[self.titleScrollView viewWithTag:(index+1000)];
    UIButton *rightButton = (UIButton *)[self.titleScrollView viewWithTag:(index+1+1000)];
    CGFloat scaleR  = scrollView.contentOffset.x / kScreenWidth - index;
    CGFloat scaleL  = 1 - scaleR;
    CGFloat transScale = _makeScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
//    UIColor *rightColor = [UIColor colorWithRed:(174+66*scaleR)/255.0 green:(174-71*scaleR)/255.0 blue:(174-174*scaleR)/255.0 alpha:1];
//    UIColor *leftColor = [UIColor colorWithRed:(174+66*scaleL)/255.0 green:(174-71*scaleL)/255.0 blue:(174-174*scaleL)/255.0 alpha:1];
//    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
//    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
}

#pragma mark - setter
- (void)setControllerItems:(NSArray<UIViewController *> *)controllerItems {
    _controllerItems = controllerItems;
    [_controllerItems enumerateObjectsUsingBlock:^(UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
    }];
}
- (void)setNormalColor:(UIColor *)normalColor {
   if (_normalColor != normalColor) _normalColor = normalColor;
}
- (void)setSelectedColor:(UIColor *)selectedColor {
    if (_selectedColor != selectedColor) _selectedColor = selectedColor;
}
- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont != titleFont) _titleFont = titleFont;
}
- (void)setMakeScale:(CGFloat)makeScale {
    if (_makeScale != makeScale) _makeScale = makeScale;
}

#pragma mark - getter
- (UIScrollView *)controllerScrollView {
    if (!_controllerScrollView) {
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        NSUInteger count = MIN(self.controllerItems.count, self.titleItems.count);
        CGRect rect = CGRectMake(0, kNavHeightTotal+kTitle_H, kScreenWidth, kScreenHight - (kNavHeightTotal+kTitle_H));
        _controllerScrollView = [[UIScrollView alloc] initWithFrame:rect];
        _controllerScrollView.contentSize = CGSizeMake(count * kScreenWidth, 0);
        _controllerScrollView.pagingEnabled = YES;
        _controllerScrollView.showsHorizontalScrollIndicator  = NO;
        _controllerScrollView.showsVerticalScrollIndicator = NO;
        _controllerScrollView.bounces = NO;
        _controllerScrollView.delegate = self;
    }
    return _controllerScrollView;
}
- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        NSUInteger count = MIN(self.controllerItems.count, self.titleItems.count);
        CGRect rect  = CGRectMake(0, kNavHeightTotal, kScreenWidth, kTitle_H);
        _titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.bounces = NO;
        __block CGFloat orighin_x = 0.f;
        __weak typeof(self) weakSelf = self;
        [self.titleItems enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            orighin_x = idx * kTitle_W;
            CGRect rect = CGRectMake(orighin_x, 0, kTitle_W, kTitle_H);
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            titleBtn.frame = rect;
            titleBtn.tag = idx+1000;
            [titleBtn setTitle:weakSelf.titleItems[idx] forState:UIControlStateNormal];
            [titleBtn setTitleColor:weakSelf.normalColor forState:UIControlStateNormal];
            titleBtn.titleLabel.font = weakSelf.titleFont;
            [titleBtn addTarget:weakSelf
                         action:@selector(titleButtonClick:)
               forControlEvents:UIControlEventTouchDown];
            [weakSelf.titleScrollView addSubview:titleBtn];
            if (idx == 0) [weakSelf titleButtonClick:titleBtn];
        }];
        _titleScrollView.contentSize = CGSizeMake(count * kTitle_W, 0);
    }
    return _titleScrollView;
}

@end
