//
//  ShowBiaoQingView.h
//  YanWenZiBiaoQing
//
//  Created by hp on 14-12-16.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowBiaoQingView : UIView

@property (nonatomic, strong) UIScrollView *showBQScrollView;
@property (nonatomic, strong) NSDictionary *dataDic;

-(id)initWithFrame:(CGRect)frame andLoadData:(NSDictionary *)dataDic;

@end
