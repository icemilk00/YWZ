//
//  KeyBoardBQShowView.h
//  YanWenZiBiaoQing
//
//  Created by hp on 15-2-2.
//  Copyright (c) 2015年 51mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  KeyBoardBQDelegate <NSObject>

-(void)bqButtonClicked:(UIButton *)sender;

@end

@interface KeyBoardBQShowView : UIView

@property (nonatomic, strong) UIScrollView *showBQScrollView;
@property (nonatomic, strong) NSDictionary *dataDic;

-(id)initWithFrame:(CGRect)frame andLoadData:(NSDictionary *)dataDic;

@property (nonatomic, assign) id <KeyBoardBQDelegate> keyBoardBQDelegate;

@end
