//
//  NumKeyBoardView.m
//  YanWenZiBiaoQing
//
//  Created by hp on 15-2-3.
//  Copyright (c) 2015年 51mvbox. All rights reserved.
//

#import "NumKeyBoardView.h"

@implementation NumKeyBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(IBAction)numClicked:(UIButton *)sender
{
    if (self.numKeyBoardDelegate && [self.numKeyBoardDelegate respondsToSelector:@selector(numButtonClicked:)]) {
        [self.numKeyBoardDelegate numButtonClicked:sender];
    }
}


- (IBAction)back:(id)sender {
    [self removeFromSuperview];
}

@end
