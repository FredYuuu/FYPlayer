//
//  FYMusicTool.h
//  Music
//
//  Created by Fred on 15/9/27.
//  Copyright (c) 2015年 Fred. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Singleton.h"

@class FYMusic;
@interface FYMusicTool : NSObject

singleton_interface(FYMusicTool)

/**
 *  播放器
 */
@property (nonatomic, strong) AVAudioPlayer *player;

/**
 *  音乐播放前的准备工作
 *
 */
- (void)prepareToPlayWithMusic:(FYMusic *)music;

/**
 *  播放音乐
 *
 */
- (void)play;

/**
 *  暂停音乐
 *
 */
- (void)pause;

@end
