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

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 67.0f, 280.0f, self.view.frame.size.height - 67.0f*2)];
    _leftTableView.backgroundColor = [UIColor greenColor];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    [self.view addSubview:_leftTableView];
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
    }
    
    if (indexPath.row == 0) {
        cell.headLabel.text = @"";
    }
    else
    {
        cell.headLabel.text = [[[[BQData sharedInstance].BQShareArray objectAtIndex:indexPath.row] objectForKey:@"yan"] objectAtIndex:0];
    }
    
    cell.cellLabel.text = [[[BQData sharedInstance].BQShareArray objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TO_SHOW_BQ_VIEW object:[NSNumber numberWithInteger:indexPath.row]];
    
    [APPDELEGATE.sideViewController hideSideViewController:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
