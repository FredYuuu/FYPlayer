//
//  FYMusicPlayerViewController.m
//  Music
//
//  Created by Fred on 15/9/27.
//  Copyright (c) 2015年 Fred. All rights reserved.
//

#import "FYMusicPlayerViewController.h"
#import "FYPlayerToolBar.h"
#import "MJExtension.h"
#import "FYMusic.h"
#import "FYMusicCell.h"
#import "FYMusicTool.h"
#import "AppDelegate.h"
#import "FYLeftViewController.h"
#import "UIView+Frame.h"
#import "FYAboutViewController.h"
#import "FYOnlineMusicViewController.h"

@interface FYMusicPlayerViewController ()<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate, FYPlayerToolBarDelegate, AVAudioPlayerDelegate, FYLeftViewDelegate>
{
    CGRect leftViewLeftFrame;//左视图在左边时位置
    CGRect leftViewRightFrame;//左视图在右边时位置
}
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FYLeftViewController *leftViewController;
/**
 *  当前播放音乐的索引
 */
@property (nonatomic, assign) NSInteger musicIndex;

/**
 *  音乐数据
 */
@property (nonatomic, strong) NSArray *musics;

/**
 *  播放工具条
 */
@property (nonatomic, weak) FYPlayerToolBar *playerToolBar;

@end

@implementation FYMusicPlayerViewController

#pragma mark - 懒加载
- (NSArray *)musics{
    if (_musics == nil) {
        _musics = [FYMusic objectArrayWithFilename:@"songs.plist"];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self setupTableView];
    [self playMusic];
    
    //设置appdelegate的block
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.myRemoteEventBlock = ^(UIEvent *event){
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [[FYMusicTool sharedFYMusicTool] play];
                break;
            case UIEventSubtypeRemoteControlPause:
                [[FYMusicTool sharedFYMusicTool] pause];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self previous];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [self next];
                break;
                
            default:
                break;
        }
    };
}

- (void)setupUI{
    leftViewLeftFrame = CGRectMake(-kMainWidth, 0, kViewWidth, kViewHeight);
    leftViewRightFrame = CGRectMake(self.view.x,self.view.y, self.view.width, self.view.height);
    
    //添加播放的工具条
    FYPlayerToolBar *toolBar = [FYPlayerToolBar playerToolBar];
    toolBar.delegate = self;
    //设置toolBar的尺寸
    toolBar.bounds = self.bottomView.bounds;
    [self.bottomView addSubview:toolBar];
    self.playerToolBar = toolBar;
    
    self.title = @"Music";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Home_Icon_Highlight"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
    
    self.leftViewController = [[FYLeftViewController alloc] init];
    self.leftViewController.delegate = self;
    self.leftViewController.view.frame = leftViewLeftFrame;
    [self.view addSubview:self.leftViewController.view];
    
    //添加左划手势操作
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.delegate = self;
    [self.view addGestureRecognizer:swipe];
}

- (void)setupTableView{
    //设置表格的透明度
    //self.tableView.alpha = 0.3;
    //设置表格的背景为透明
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    //关闭弹簧效果
    [self.tableView setBounces:NO];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}

#pragma mark - 视图切换
- (void)swipe:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self showLeftView];
    }
}

- (void)showLeftView{
    self.tableView.userInteractionEnabled = NO;
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewRightFrame;
        self.tableView.alpha = 0.6;
        self.bottomView.alpha = 0.6;
    }];
    NSLog(@"showLeftView");
}

#pragma mark - FYLeftViewDelegate methods
- (void)showHomeView{
    self.tableView.userInteractionEnabled = YES;
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        self.tableView.alpha = 1;
        self.bottomView.alpha = 1;
    }];
    NSLog(@"showHomeView");
}

- (void)showOnlineMusicView{
    self.tableView.userInteractionEnabled = YES;
    FYOnlineMusicViewController *onlineMusic = [[FYOnlineMusicViewController alloc] init];
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        self.tableView.alpha = 1;
        self.bottomView.alpha = 1;
        [self.navigationController pushViewController:onlineMusic animated:YES];
    }];
    NSLog(@"showOnlineMusicView");
}

- (void)showAboutView{
    FYAboutViewController *about = [[FYAboutViewController alloc] init];
    self.tableView.userInteractionEnabled = YES;
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        self.tableView.alpha = 1;
        self.bottomView.alpha = 1;
        [self.navigationController pushViewController:about animated:YES];
    }];
    NSLog(@"showAboutView");
}

#pragma mark - FYPlayerToolBarDelegate methods
- (void)playerToolBar:(FYPlayerToolBar *)toolBar btnClickWithType:(BtnType)btnType{
    //实现播放,把播放功能操作放在一个工具类中
    switch (btnType) {
        case BtnTypePlay:
            [[FYMusicTool sharedFYMusicTool] play];
            NSLog(@"play");
            break;
        case BtnTypePause:
            [[FYMusicTool sharedFYMusicTool] pause];
            NSLog(@"pause");
            break;
        case BtnTypePrevious:
            [self previous];
            NSLog(@"pre");
            break;
        case BtnTypeNext:
            [self next];
            NSLog(@"next");
            break;
        default:
            break;
    }
}

#pragma mark 播放上一首
- (void)previous{
    //1.更改播放音乐的索引
    if (self.musicIndex == 0) {
        self.musicIndex = self.musics.count - 1;
    }else{
        self.musicIndex--;
    }
    [self playMusic];
}

#pragma mark 播放下一首
- (void)next{
    //1.更改播放音乐的索引
    if (self.musicIndex == self.musics.count - 1) {
        self.musicIndex = 0;
    }else{
        self.musicIndex++;
    }
    [self playMusic];
}

#pragma mark 播放
- (void)playMusic{
    //2.重新初始化一个"播放器"
    [[FYMusicTool sharedFYMusicTool] prepareToPlayWithMusic:self.musics[self.musicIndex]];
    //设置player的代理
    [FYMusicTool sharedFYMusicTool].player.delegate = self;
    //3.更改"播放器工具条"的数据
    self.playerToolBar.playingMusic = self.musics[self.musicIndex];
    
    //4.播放
    if (self.playerToolBar.isPlaying) {
        [[FYMusicTool sharedFYMusicTool] play];
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.musics.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //自定义的cell
    FYMusicCell *cell = [FYMusicCell musicCellWithTableView:tableView];
    
    //设置数据
    FYMusic *music = self.musics[indexPath.row];
    cell.music = music;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //更改索引
    self.musicIndex = indexPath.row;
//    if (self.playerToolBar.isPlaying == NO) {
//        self.playerToolBar.playing = YES;
//    }
    //播放音乐
    [self playMusic];
}

#pragma mark - AVAudioPlayerDelegate methods
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //自动播放下一首
    [self next];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
