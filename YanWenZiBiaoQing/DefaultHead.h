//
//  DefaultHead.h
//  YanWenZiBiaoQing
//
//  Created by hp on 14-12-22.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#ifndef YanWenZiBiaoQing_DefaultHead_h
#define YanWenZiBiaoQing_DefaultHead_h

#import "AppDelegate.h"

#define RECENTDATA @"recentData"

#define APPDELEGATE ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define TO_SHOW_BQ_VIEW @"toShowBQView"
#define CHANGE_BG_COLOR @"changeBgColor"
#define DEFAULT_FONT(fontSize) [UIFont fontWithName:@"Helvetica" size:fontSize]     //通用字体，可定义大小
#endif
