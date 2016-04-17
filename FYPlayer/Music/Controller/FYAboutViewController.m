//
//  FYAboutViewController.m
//  Music
//
//  Created by Fred on 16/1/2.
//  Copyright (c) 2016年 Fred. All rights reserved.
//

#import "FYAboutViewController.h"

@interface FYAboutViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation FYAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self fillContent];
}

- (void)setupUI
{
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.backgroundColor = [UIColor whiteColor];
    self.title = @"About";
    textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aboutBackground"]];
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.userInteractionEnabled = NO;
}

- (void)fillContent
{
    self.textView.text = @"\t音乐播放器\n\t实现本地音乐播放，具有后台操作功能。";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
