//
//  KeyBoardFootView.m
//  YanWenZiBiaoQing
//
//  Created by hp on 15-1-30.
//  Copyright (c) 2015年 51mvbox. All rights reserved.
//

#import "KeyBoardFootView.h"

@implementation KeyBoardFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)numButtonClicked:(id)sender {
    if (self.keyBoardFootDelegate && [self.keyBoardFootDelegate respondsToSelector:@selector(gotoNumKeyBoard)]) {
        [self.keyBoardFootDelegate gotoNumKeyBoard];
    }
}

- (IBAction)nextKeyBoardButtonClicked:(id)sender {
    if (self.keyBoardFootDelegate && [self.keyBoardFootDelegate respondsToSelector:@selector(advanceToNextInputMode)]) {
        [self.keyBoardFootDelegate advanceToNextInputMode];
    }
}

- (IBAction)settingButtonClicked:(id)sender {
    if (self.keyBoardFootDelegate && [self.keyBoardFootDelegate respondsToSelector:@selector(setting)]) {
        [self.keyBoardFootDelegate setting];
    }
}

- (IBAction)spaceButtonClicked:(id)sender {
    if (self.keyBoardFootDelegate && [self.keyBoardFootDelegate respondsToSelector:@selector(spaceButtonClicked)]) {
        [self.keyBoardFootDelegate spaceButtonClicked];
    }
}

- (IBAction)backSpaceButtonClicked:(id)sender {
    if (self.keyBoardFootDelegate && [self.keyBoardFootDelegate respondsToSelector:@selector(backSpace)]) {
        [self.keyBoardFootDelegate backSpace];
    }
}

- (IBAction)sendButtonClicked:(id)sender {
    if (self.keyBoardFootDelegate && [self.keyBoardFootDelegate respondsToSelector:@selector(send)]) {
        [self.keyBoardFootDelegate send];
    }
}


@end
