//
//  LeftViewController.m
//  YanWenZiBiaoQing
//
//  Created by hp on 14-12-16.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "DefaultHead.h"
#import "SettingViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor:) name:CHANGE_BG_COLOR object:nil];
    // Do any additional setup after loading the view.
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
//    [_bgImageView setImage:[UIImage imageNamed:@"main_bg"]];
    [self.view addSubview:_bgImageView];
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 67.0f, 280.0f, self.view.frame.size.height - 67.0f*2)];
    _leftTableView.backgroundColor = [UIColor clearColor];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_leftTableView];
    
    self.settingButton = [[UIButton alloc] initWithFrame:CGRectMake(280.0f - 44.0f, _leftTableView.frame.origin.y + _leftTableView.frame.size.height + 11.0f, 44.0f, 44.0f)];
    _settingButton.backgroundColor = [UIColor whiteColor];
    [_settingButton addTarget:self action:@selector(setttingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_settingButton];
}

#pragma mark -- tableview delegate & datasource --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[BQData sharedInstance].BQShareArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ldentifier = @"leftCell";
    
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ldentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.headLabel.textColor = [UIColor whiteColor];
        cell.cellLabel.textColor = [UIColor whiteColor];
    }
    
    if (indexPath.row == 0) {
        cell.headLabel.text = @"";
    }
    else
    {
        cell.headLabel.text = [[[[BQData sharedInstance].BQShareArray objectAtIndex:indexPath.row] objectForKey:@"yan"] objectAtIndex:0];
    }
    
    cell.cellLabel.text = [[[BQData sharedInstance].BQShareArray objectAtIndex:indexPath.row] objectForKey:@"text"];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [APPDELEGATE.sideViewController hideSideViewController:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TO_SHOW_BQ_VIEW object:[NSNumber numberWithInteger:indexPath.row]];
}

-(void)changeBgColor:(NSNotification *)notif
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = notif.object;
    }];
}

-(void)setttingButtonClicked:(UIButton *)sender
{
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGE_BG_COLOR object:nil];
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
