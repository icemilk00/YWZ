//
//  MainViewController.m
//  YanWenZiBiaoQing
//
//  Created by hp on 14-12-16.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import "MainViewController.h"
#import "ShowBiaoQingView.h"
#import "DefaultHead.h"

#import "DefaultHead.h"


@interface MainViewController ()
{
    CGPoint touchPoint;
    NSArray *_bgColorArray;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toShowBQViewAction:) name:TO_SHOW_BQ_VIEW object:nil];
    [self arrayInit];
    
    self.view.backgroundColor = [_bgColorArray objectAtIndex:0];
    
    self.showScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 80.0f, self.view.frame.size.width, self.view.frame.size.height - 80.0f - 40.0f)];
//    _showScrollView.backgroundColor = [UIColor whiteColor];
    _showScrollView.contentSize = CGSizeMake(_showScrollView.bounds.size.width * [BQData sharedInstance].BQShareArray.count, _showScrollView.bounds.size.height );
    _showScrollView.backgroundColor = [UIColor clearColor];
    _showScrollView.delegate = self;
    _showScrollView.pagingEnabled = YES;
    _showScrollView.showsHorizontalScrollIndicator = NO;
    _showScrollView.showsVerticalScrollIndicator = NO;
    _showScrollView.scrollsToTop = NO;
    [self.view addSubview:_showScrollView];
    
    for (int i = 0; i < [BQData sharedInstance].BQShareArray.count; i ++) {
        
        ShowBiaoQingView *view = [[ShowBiaoQingView alloc] initWithFrame:CGRectMake(i * _showScrollView.frame.size.width, 0.0f , _showScrollView.frame.size.width, _showScrollView.frame.size.height) andLoadData:[[BQData sharedInstance].BQShareArray objectAtIndex:i]];
        [_showScrollView addSubview:view];
    }
    
    self.leftTouchView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, _showScrollView.frame.origin.y, 30.0f, _showScrollView.frame.size.height)];
    _leftTouchView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_leftTouchView];
    
    self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 40.0f, 50.0f, 50.0f)];
    [_menuButton setImage:[UIImage imageNamed:@"left_menu"] forState:UIControlStateNormal];
    _menuButton.backgroundColor = [UIColor clearColor];
    [_menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_menuButton];
    
    self.showEnLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 20.0f - 200.0f, 40.0f, 200.0f, 50.0f)];
    _showEnLabel.textAlignment = NSTextAlignmentRight;
    _showEnLabel.backgroundColor = [UIColor clearColor];
    _showEnLabel.textColor = [UIColor whiteColor];
    _showEnLabel.text = [[[BQData sharedInstance].BQShareArray objectAtIndex:0] objectForKey:@"en"];
    [self.view addSubview:_showEnLabel];
    
}

-(void)arrayInit
{
    _bgColorArray = [NSArray arrayWithObjects:[self colorWithR:0.0f G:53.0f B:103.0f],  //深藏蓝
                     [self colorWithR:0.0f G:183.0f B:238.0f],                          //天蓝
                     [self colorWithR:236.0f G:105.0f B:65.0f],                         //暖橘色
                     [self colorWithR:228.0f G:0.0f B:127.0f],                          //桃红色
                     [self colorWithR:143.0f G:130.0f B:188.0f],                        //浅紫
                     [self colorWithR:255.0f G:241.0f B:0.0f],                          //黄色
                     nil];
}

#pragma mark -- 颜色 --
-(UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B
{
    return [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1];
}

-(void)menuButtonClicked:(UIButton *)sender
{
    [APPDELEGATE.sideViewController showLeftViewController:YES];
}

-(void)toShowBQViewAction:(NSNotification *)notification
{
    NSInteger clickRow = [notification.object integerValue];
    
    _showScrollView.contentOffset = CGPointMake(clickRow * _showScrollView.frame.size.width, 0.0f);
    
    NSInteger currentIndex = _showScrollView.contentOffset.x / _showScrollView.frame.size.width;
    self.view.backgroundColor = [_bgColorArray objectAtIndex:(currentIndex % _bgColorArray.count)];
    
    //设置右标签字
    _showEnLabel.text = [[[BQData sharedInstance].BQShareArray objectAtIndex:currentIndex] objectForKey:@"en"];
    
    //设置左侧栏颜色
    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_BG_COLOR object:self.view.backgroundColor];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x <= 100.0f) {
        if (_leftTouchView.frame.size.width != 100.0f) {
            _leftTouchView.frame = CGRectMake(_leftTouchView.frame.origin.x, _leftTouchView.frame.origin.y, 100.0f, _leftTouchView.frame.size.height);
        }
    }
    else
    {
        if (_leftTouchView.frame.size.width != 30.0f) {
            _leftTouchView.frame = CGRectMake(_leftTouchView.frame.origin.x, _leftTouchView.frame.origin.y, 30.0f, _leftTouchView.frame.size.height);
        }
    }
    
    //设置背景颜色
    NSInteger currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [_bgColorArray objectAtIndex:(currentIndex % _bgColorArray.count)];
    }];
    
    //设置右标签字
    _showEnLabel.text = [[[BQData sharedInstance].BQShareArray objectAtIndex:currentIndex] objectForKey:@"en"];
    
    //设置左侧栏颜色
    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_BG_COLOR object:self.view.backgroundColor];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesBegan");
//    UITouch *touch = [touches anyObject];
//    touchPoint = [touch locationInView:self.view];
//    NSLog(@"[%f, %f]", touchPoint.x, touchPoint.y);
////    [self setNeedsDisplay];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesMoved");
//    UITouch *touch = [touches anyObject];
//    CGPoint movePoint = [touch locationInView:self.view];
//    NSLog(@"[%f, %f]", movePoint.x, movePoint.y);
//    if (movePoint.x - touchPoint.x < 0) {
//        _showScrollView.userInteractionEnabled = YES;
//    }
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesEnded");
//    UITouch *touch = [touches anyObject];
//    touchPoint = [touch locationInView:self.view];
//    NSLog(@"[%f, %f]", touchPoint.x, touchPoint.y);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TO_SHOW_BQ_VIEW object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
