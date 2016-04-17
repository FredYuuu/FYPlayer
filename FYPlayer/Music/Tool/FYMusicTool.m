//
//  FYMusicTool.m
//  Music
//
//  Created by Fred on 15/9/27.
//  Copyright (c) 2015年 Fred. All rights reserved.
//

#import "FYMusicTool.h"
#import "FYMusic.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation FYMusicTool

singleton_implementation(FYMusicTool)

- (void)prepareToPlayWithMusic:(FYMusic *)music{
    //创建播放器
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
    if (error) {
        NSLog(@"%s %@", __func__, error);
    }
    
    //准备
    [self.player prepareToPlay];
    
    //建议:锁屏信息最好在程序退出到后台的时候再设置
    //设置锁屏音乐信息
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    //设置专辑名称
    info[MPMediaItemPropertyAlbumTitle] = @"网络热曲";
    //设置歌曲名
    info[MPMediaItemPropertyTitle] = music.name;
    //设置歌手
    info[MPMediaItemPropertyArtist] = music.singer;
    //设置专辑图片
    UIImage *image = [UIImage imageNamed:music.icon];
    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
    info[MPMediaItemPropertyArtwork] = artwork;
    //设置歌曲时间
    info[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;
}

- (void)play{
    [self.player play];
}

- (void)pause{
    [self.player pause];
}

@end
