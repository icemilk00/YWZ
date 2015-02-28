//
//  BQData.h
//  YanWenZiBiaoQing
//
//  Created by hp on 15-1-6.
//  Copyright (c) 2015年 51mvbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefaultHead.h"

@interface BQData : NSObject
+(BQData *)sharedInstance;

@property (strong , nonatomic) NSMutableArray *BQShareArray;

@end
