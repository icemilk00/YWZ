//
//  LeftViewController.h
//  YanWenZiBiaoQing
//
//  Created by hp on 14-12-16.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong , nonatomic) UITableView *leftTableView;

@end
