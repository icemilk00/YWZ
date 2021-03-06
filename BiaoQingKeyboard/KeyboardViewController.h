//
//  KeyboardViewController.h
//  BiaoQingKeyboard
//
//  Created by hp on 14-12-2.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultHead.h"
#import "KeyBoardFootView.h"
#import "KeyBoardBQShowView.h"
#import "NumKeyBoardView.h"

@interface KeyboardViewController : UIInputViewController <KeyBoardFootDelegate, UIScrollViewDelegate, KeyBoardBQDelegate, NumKeyBoardDelegate>
{
    BOOL _isNeedReloadRecentBQ;
}
@property (nonatomic, strong) NSMutableArray *dataBqArray;
@property (nonatomic, strong) NSMutableDictionary *recentBQDic;
@property (nonatomic, strong) UIScrollView *categoryScrollView;
@property (nonatomic, strong) KeyBoardFootView *keyBoardFootView;

@property (nonatomic, strong) UIView *keyBoardMainView;
@property (nonatomic, strong) UIScrollView *keyBoardBQScrollView;

@property (nonatomic, strong) NSMutableArray *hasLoadBQViewIndexArray;

@property (nonatomic, strong) NSUserDefaults *groupDefaults;
@end
