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
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toShowBQViewAction:) name:TO_SHOW_BQ_VIEW object:nil];
    
    self.showScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 80.0f, self.view.frame.size.width, self.view.frame.size.height - 80.0f - 40.0f)];
    _showScrollView.backgroundColor = [UIColor whiteColor];
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
    
    self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 30.0f, 50.0f, 50.0f)];
    _menuButton.backgroundColor = [UIColor redColor];
    [_menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_menuButton];
    
}

-(void)menuButtonClicked:(UIButton *)sender
{
    [APPDELEGATE.sideViewController showLeftViewController:YES];
}

-(void)toShowBQViewAction:(NSNotification *)notification
{
    NSInteger clickRow = [notification.object integerValue];
    
    _showScrollView.contentOffset = CGPointMake(clickRow * _showScrollView.frame.size.width, 0.0f);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender.contentOffset.x <= 100.0f) {
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
