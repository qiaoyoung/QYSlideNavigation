//
//  QYSlideNavigationDelegate.h
//  SlideNavigationDemo
//
//  Created by Joeyoung on 2018/8/3.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QYSlideNavigationDelegate<NSObject>

/**
 current selected information.
 
 @param viewController selected VC.
 @param index current
 */
- (void)selectedViewController:(UIViewController *)viewController index:(NSUInteger)index;

@end
