//
//  MainViewController.h
//  YanWenZiBiaoQing
//
//  Created by hp on 14-12-16.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *showScrollView;
@property (nonatomic, strong) UIView *leftTouchView;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UILabel *showEnLabel;
@property (nonatomic, strong) UIScrollView *footShowScrollView;

@end
