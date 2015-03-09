//
//  KeyboardViewController.m
//  BiaoQingKeyboard
//
//  Created by hp on 14-12-2.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import "KeyboardViewController.h"
#import "KeyBoardBQShowView.h"


#define CATEGORY_BUTTON_BASETAG  100
#define BQ_SHOWVIEW_BASETAG      200



@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Perform custom UI setup here
    
    self.groupDefaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.recentBQ"];
    
    if ([_groupDefaults objectForKey:RECENTDATA] == nil) {
        NSDictionary *baseRecentDic = [NSDictionary dictionaryWithObjectsAndKeys:@"Rencent", @"en",
                                       @"最近使用", @"one",
                                       @"最近使用", @"text",
                                       [NSArray array], @"yan",nil];
        
        [_groupDefaults setObject:baseRecentDic forKey:RECENTDATA];
    }
    
    NSLog(@"aaaaa = %@", [_groupDefaults objectForKey:RECENTDATA]);
    
    //数据源
    NSError *error;
    NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"] encoding:NSUTF8StringEncoding error: &error];
    
    NSDictionary *recentTempDic = [[NSDictionary alloc] initWithDictionary:[_groupDefaults objectForKey:RECENTDATA]];
    
    self.dataBqArray = [[NSMutableArray alloc] initWithArray:[textFileContents objectFromJSONString]];
    self.recentBQDic = [[NSMutableDictionary alloc] initWithDictionary:recentTempDic];
    
    [_dataBqArray insertObject:recentTempDic atIndex:0];
    
    self.hasLoadBQViewIndexArray = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    CGFloat _expandedHeight = 280.0f;
    NSLayoutConstraint *_heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual 	toItem:nil	attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:_expandedHeight];
    [self.view addConstraint: _heightConstraint];
    
    self.keyBoardMainView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [_keyBoardMainView sizeToFit];
    _keyBoardMainView.backgroundColor = [UIColor clearColor];
    self.keyBoardMainView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_keyBoardMainView];
    
    NSLayoutConstraint *keboardMainTopConstraint = [NSLayoutConstraint constraintWithItem:self.keyBoardMainView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *keboardMainLeftConstraint = [NSLayoutConstraint constraintWithItem:self.keyBoardMainView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *keboardMainRightConstraint = [NSLayoutConstraint constraintWithItem:self.keyBoardMainView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *keboardMainBottomConstraint = [NSLayoutConstraint constraintWithItem:self.keyBoardMainView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    [self.view addConstraints:@[keboardMainTopConstraint, keboardMainLeftConstraint, keboardMainRightConstraint,keboardMainBottomConstraint]];
    NSLog(@"keyboardview = %@", self.keyBoardMainView);
}

-(void)viewDidAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 280.0f);
    _keyBoardMainView.frame = CGRectMake(_keyBoardMainView.frame.origin.x, _keyBoardMainView.frame.origin.y, _keyBoardMainView.frame.size.width, 280.0f);
    
    [self loadKeyboardView];
}

-(void)loadKeyboardView
{
    NSLog(@"databqarray = %@", _dataBqArray);
    NSInteger dataCategoryCount = [_dataBqArray count];
    
    NSLog(@"self.view = %@",self.view);
    NSLog(@"keyBoardMainView = %@",self.keyBoardMainView);

    self.categoryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.keyBoardMainView.frame.size.width, 40.0f)];
    _categoryScrollView.contentSize = CGSizeMake((_categoryScrollView.frame.size.width/5) * dataCategoryCount, _categoryScrollView.frame.size.height);
    _categoryScrollView.showsHorizontalScrollIndicator = NO;
    _categoryScrollView.showsVerticalScrollIndicator = NO;
    [self.keyBoardMainView addSubview:_categoryScrollView];
    
    CGFloat categoryButtonWidth = _categoryScrollView.frame.size.width/5;
    
    for (int i = 0 ; i < _dataBqArray.count ; i ++) {
        UIButton *categoryButton = [[UIButton alloc] initWithFrame:CGRectMake(categoryButtonWidth * i, 0.0f, categoryButtonWidth, _categoryScrollView.frame.size.height)];
        categoryButton.tag = CATEGORY_BUTTON_BASETAG + i;
        [categoryButton setTitle:[[_dataBqArray objectAtIndex:i] objectForKey:@"text"] forState:UIControlStateNormal];
        [categoryButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [categoryButton addTarget:self action:@selector(categoryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        categoryButton.backgroundColor = [UIColor lightGrayColor];
        categoryButton.titleLabel.font = DEFAULT_FONT(13);
        [_categoryScrollView addSubview:categoryButton];
    }
    
    self.keyBoardFootView = [[[NSBundle mainBundle] loadNibNamed:@"KeyBoardFootView" owner:self options:nil] firstObject];
    _keyBoardFootView.frame = CGRectMake(0.0f, _keyBoardMainView.frame.size.height - 45.0f, _keyBoardMainView.frame.size.width, 45.0f);
    _keyBoardFootView.keyBoardFootDelegate = self;
    [self.keyBoardMainView addSubview:_keyBoardFootView];
    
    self.keyBoardBQScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, _categoryScrollView.frame.size.height, _keyBoardMainView.frame.size.width, _keyBoardMainView.frame.size.height - _categoryScrollView.frame.size.height - _keyBoardFootView.frame.size.height)];
    _keyBoardBQScrollView.contentSize = CGSizeMake(_keyBoardBQScrollView.frame.size.width * _dataBqArray.count, _keyBoardBQScrollView.frame.size.height);
    _keyBoardBQScrollView.delegate = self;
    _keyBoardBQScrollView.showsHorizontalScrollIndicator = NO;
    _keyBoardBQScrollView.showsVerticalScrollIndicator = NO;
    _keyBoardBQScrollView.pagingEnabled = YES;
    [self.keyBoardMainView addSubview:_keyBoardBQScrollView];
    
    [self loadBQViewAtIndex:0];
}

-(void)loadBQViewAtIndex:(NSInteger)index
{

    //防止重复加载
    for (id tempIndex in _hasLoadBQViewIndexArray ) {
        if (index == [tempIndex integerValue]) {
            
            if (index == 0 && _isNeedReloadRecentBQ == YES) {
                [_hasLoadBQViewIndexArray removeObject:[NSNumber numberWithInteger:index]];
                _isNeedReloadRecentBQ = NO;
                break;
            }
            
            return;
        }
    }
    
    [_hasLoadBQViewIndexArray addObject:[NSNumber numberWithInteger:index]];
    NSLog(@"databqarray = %@", _dataBqArray);
    KeyBoardBQShowView *view = [[KeyBoardBQShowView alloc] initWithFrame:CGRectMake(index * _keyBoardBQScrollView.frame.size.width, 0.0f , _keyBoardBQScrollView.frame.size.width, _keyBoardBQScrollView.frame.size.height) andLoadData:index == 0 ? _recentBQDic : [_dataBqArray objectAtIndex:index]];
    view.keyBoardBQDelegate = self;
    view.tag = BQ_SHOWVIEW_BASETAG + index;
    
    if ([_keyBoardBQScrollView viewWithTag:view.tag]) {
        [[_keyBoardBQScrollView viewWithTag:view.tag] removeFromSuperview];
    }
    
    [_keyBoardBQScrollView addSubview:view];

}

-(void)bqButtonClicked:(UIButton *)sender
{
    NSString *bqStr = sender.titleLabel.text;
    
    [self.textDocumentProxy insertText:bqStr];
    
    [self makeRecentBQData:bqStr];
    
    [_groupDefaults setObject:_recentBQDic forKey:RECENTDATA];
    
    _isNeedReloadRecentBQ = YES;
}

-(void)makeRecentBQData:(NSString *)bqStr
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[_recentBQDic objectForKey:@"yan"]];
    
    for (NSString *str in tempArray) {
        if ([str isEqualToString:bqStr]) {
            [tempArray removeObject:str];
            break;
        }
    }
    
    [tempArray insertObject:bqStr atIndex:0];
    [_recentBQDic setObject:tempArray forKey:@"yan"];
}

-(void)categoryButtonClicked:(UIButton *)sender
{
    NSLog(@"title = %@", sender.titleLabel.text);
    NSUInteger index = sender.tag - CATEGORY_BUTTON_BASETAG;
    
    [self loadBQViewAtIndex:index];
    
    _keyBoardBQScrollView.contentOffset = CGPointMake(index * _keyBoardBQScrollView.frame.size.width, 0.0f);
    
    
    CGFloat tempOffsetX = 0.0f;
    if (index < 3) {
        tempOffsetX = 0.0f;
    }
    else if (index > _dataBqArray.count - 4)
    {
        tempOffsetX = _categoryScrollView.contentSize.width - _categoryScrollView.frame.size.width;
    }
    else
    {
        tempOffsetX = _categoryScrollView.frame.size.width/5 * (index - 2);
    }
    
    [_categoryScrollView setContentOffset:CGPointMake(tempOffsetX, 0.0f) animated:YES];
}

#pragma mark -- keyBoardBQScrollView 代理 --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollview.contentoffset = %f", scrollView.contentOffset.x);
    
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    
    [self loadBQViewAtIndex:index];
    
    CGFloat tempOffsetX = 0.0f;
    if (index < 3) {
        tempOffsetX = 0.0f;
    }
    else if (index > _dataBqArray.count - 4)
    {
        tempOffsetX = _categoryScrollView.contentSize.width - _categoryScrollView.frame.size.width;
    }
    else
    {
        tempOffsetX = _categoryScrollView.frame.size.width/5 * (index - 2);
    }
    
    [_categoryScrollView setContentOffset:CGPointMake(tempOffsetX, 0.0f) animated:YES];
}

#pragma mark -- 键盘底部按钮点击事件 --
//删除光标前一个位置的字符
-(void)backSpace
{
    [self.textDocumentProxy adjustTextPositionByCharacterOffset:1]; //光标向后移动一定位置，由参数决定
    
    [self.textDocumentProxy deleteBackward];    //删除光标所在位置前一个字符
}

//空格键点击
-(void)spaceButtonClicked
{
    [self.textDocumentProxy insertText:@" "];
}

//发送按钮点击
-(void)send
{
    [self.textDocumentProxy insertText:@"\n"];
}

//设置按钮点击
-(void)setting
{

}

//调起数字键盘
-(void)gotoNumKeyBoard
{
    NumKeyBoardView *view = [[[NSBundle mainBundle] loadNibNamed:@"NumKeyBoardView" owner:self options:nil] firstObject];
    view.frame = CGRectMake(0.0f, 0.0f, _keyBoardMainView.frame.size.width, _keyBoardMainView.frame.size.height);
    view.numKeyBoardDelegate = self;
    [_keyBoardMainView addSubview:view];
}

-(void)numButtonClicked:(UIButton *)sender
{
    [self.textDocumentProxy insertText:sender.titleLabel.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
//    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
