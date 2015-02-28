//
//  NumKeyBoardView.h
//  YanWenZiBiaoQing
//
//  Created by hp on 15-2-3.
//  Copyright (c) 2015年 51mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NumKeyBoardDelegate <NSObject>

-(void)numButtonClicked:(UIButton *)sender;

@end

@interface NumKeyBoardView : UIView

@property (nonatomic, assign) id <NumKeyBoardDelegate> numKeyBoardDelegate;

@end
