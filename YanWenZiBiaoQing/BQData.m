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

        NSUserDefaults *_groupDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.recentBQ"];
        
        if ([_groupDefaults objectForKey:RECENTDATA] == nil) {
            NSDictionary *baseRecentDic = [NSDictionary dictionaryWithObjectsAndKeys:@"Rencent", @"en",
                                           @"最近使用", @"one",
                                           @"最近使用", @"text",
                                           [NSArray array], @"yan",nil];
            
            [_groupDefaults setObject:baseRecentDic forKey:RECENTDATA];
        }
        
        NSLog(@"aaaaa = %@", [_groupDefaults objectForKey:RECENTDATA]);

        [_BQShareArray insertObject:[_groupDefaults objectForKey:RECENTDATA] atIndex:0];
    }
    
    return _BQShareArray;
}

@end
