//
//  ShowBiaoQingView.m
//  YanWenZiBiaoQing
//
//  Created by hp on 14-12-16.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import "ShowBiaoQingView.h"
#import "DefaultHead.h"

#define BASE_APART_WIDTH  4.0f

#define BASE_BQ_WIDTH  (_showBQScrollView.frame.size.width - 4*BASE_APART_WIDTH)/3
#define DOUBLE_BASE_BQ_WIDTH  BASE_BQ_WIDTH*2 + BASE_APART_WIDTH
#define MOST_BQ_WIDTH  _showBQScrollView.frame.size.width - BASE_APART_WIDTH*2

#define BASE_BQ_HEIGHT  30.0f

#define BASE_BEGIN_X  4.0f
#define BASE_BEGIN_Y  4.0f

@implementation ShowBiaoQingView
{
    CGFloat bqHeight;
    
    CGPoint nextBqPoint;
    
}

-(id)initWithFrame:(CGRect)frame andLoadData:(NSDictionary *)dataDic
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect showViewFrame = CGRectMake(20.0f, 20.0f, frame.size.width - 40.0f, frame.size.height - 40.0f);
        
        self.showBQScrollView = [[UIScrollView alloc] initWithFrame:showViewFrame];
        _showBQScrollView.backgroundColor = [UIColor whiteColor];
        _showBQScrollView.layer.cornerRadius = 15;
        _showBQScrollView.layer.masksToBounds = YES;
        
        _showBQScrollView.layer.shadowOffset = CGSizeMake(0, 3); //设置阴影的偏移量
        _showBQScrollView.layer.shadowRadius = 5.0;  //设置阴影的半径
        _showBQScrollView.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        _showBQScrollView.layer.shadowOpacity = 0.7; //设置阴影的不透明度
        
        [self addSubview:_showBQScrollView];
        
        self.dataDic = dataDic;
        
        [self loadBQToShow];
    }
    
    return self;
}

-(void)loadBQToShow
{
    nextBqPoint = CGPointMake(BASE_BEGIN_X, BASE_BEGIN_Y);
    
    NSArray *dataArray = [_dataDic objectForKey:@"yan"];
    NSLog(@"dataarray = %@", dataArray);
    for (int i = 0; i < dataArray.count; i ++) {
        
        UIButton *bqButton = [[UIButton alloc] init];
        
        NSString *bqTempStr = [dataArray objectAtIndex:i];
        
        CGFloat bqTempStrWidth = [self bqStrWidth:bqTempStr];
        
        CGFloat bqButtonWidth;
        if (bqTempStrWidth <= BASE_BQ_WIDTH) {
            bqButtonWidth = BASE_BQ_WIDTH;
        }
        else if (bqTempStrWidth > BASE_BQ_WIDTH && bqTempStrWidth <= DOUBLE_BASE_BQ_WIDTH)
        {
            bqButtonWidth = DOUBLE_BASE_BQ_WIDTH;
        }
        else if (bqTempStrWidth > DOUBLE_BASE_BQ_WIDTH)
        {
            bqButtonWidth = MOST_BQ_WIDTH;
        }

        if (nextBqPoint.x + bqButtonWidth > _showBQScrollView.frame.size.width) {
            nextBqPoint.y += (BASE_BQ_HEIGHT + BASE_APART_WIDTH);
            nextBqPoint.x = BASE_BEGIN_X;
        }
        
        bqButton.frame = CGRectMake(nextBqPoint.x, nextBqPoint.y, bqButtonWidth, BASE_BQ_HEIGHT);
        
        if (nextBqPoint.x + bqButtonWidth + BASE_APART_WIDTH > _showBQScrollView.frame.size.width) {
            nextBqPoint.y += (BASE_BQ_HEIGHT + BASE_APART_WIDTH);
            nextBqPoint.x = BASE_BEGIN_X;
        }
        else
        {
            nextBqPoint.x +=  (BASE_APART_WIDTH + bqButtonWidth);
        }
        
        bqButton.layer.cornerRadius = 5;
        
        bqButton.tag = 1000 + i;
        
        bqButton.titleLabel.font = DEFAULT_FONT(12);
        [bqButton setTitle:bqTempStr forState:UIControlStateNormal];
        bqButton.backgroundColor = [UIColor redColor];
        [_showBQScrollView addSubview:bqButton];
        
        bqHeight = bqButton.frame.origin.y + bqButton.frame.size.height;
    }
    
    if (bqHeight > _showBQScrollView.frame.size.height) {
        _showBQScrollView.contentSize = CGSizeMake(_showBQScrollView.frame.size.width, bqHeight);
    }
    else
    {
        _showBQScrollView.contentSize = CGSizeMake(_showBQScrollView.frame.size.width, _showBQScrollView.frame.size.height + 1);
    }
}

-(CGFloat)bqStrWidth:(NSString *)bqStr
{
    CGFloat bqWidth = [bqStr sizeWithFont:DEFAULT_FONT(12) constrainedToSize:CGSizeMake(MOST_BQ_WIDTH, BASE_BQ_HEIGHT)
                                                 lineBreakMode:NSLineBreakByWordWrapping].width;
    return bqWidth;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
