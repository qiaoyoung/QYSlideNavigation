//
//  QYSlideNavigationViewController.h
//   
//
//  Created by Joeyoung on 2018/7/25.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSlideNavigationViewController : UIViewController

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

@end
