//
//  BQData.m
//  YanWenZiBiaoQing
//
//  Created by hp on 15-1-6.
//  Copyright (c) 2015年 51mvbox. All rights reserved.
//

#import "BQData.h"
static BQData *BQShareData = nil;
@implementation BQData

+(BQData *)sharedInstance
{
    @synchronized (self)
    {
        if (BQShareData == nil) {

            BQShareData = [[self alloc] init];
            
        }
    }
    
    return BQShareData;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (BQShareData == nil) {
            BQShareData = [super allocWithZone:zone];
            return  BQShareData;
        }
    }
    return nil;
}

-(NSMutableArray *)BQShareArray
{
    if (_BQShareArray == nil) {
        NSError *error;
         NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"] encoding:NSUTF8StringEncoding error: & error];
        
        _BQShareArray = [[NSMutableArray alloc] initWithArray:[textFileContents objectFromJSONString]];
    }
    
    return _BQShareArray;
}

@end
