//
//  KeyBoardFootView.h
//  YanWenZiBiaoQing
//
//  Created by hp on 15-1-30.
//  Copyright (c) 2015年 51mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyBoardFootDelegate <NSObject>

-(void)advanceToNextInputMode;
-(void)backSpace;
-(void)spaceButtonClicked;
-(void)send;
-(void)setting;
-(void)gotoNumKeyBoard;

@end

@interface KeyBoardFootView : UIView

@property (nonatomic, assign) id <KeyBoardFootDelegate> keyBoardFootDelegate;

@end
