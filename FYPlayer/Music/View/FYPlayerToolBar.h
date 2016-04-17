//
//  FYPlayerToolBar.h
//  Music
//
//  Created by Fred on 15/9/27.
//  Copyright (c) 2015年 Fred. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    BtnTypePlay, //播放
    BtnTypePause, //暂停
    BtnTypePrevious, //上一首
    BtnTypeNext //下一首
}BtnType;

@class FYMusic,FYPlayerToolBar;

@protocol FYPlayerToolBarDelegate <NSObject>

- (void)playerToolBar:(FYPlayerToolBar *)toolBar btnClickWithType:(BtnType) btnType;

@end

@interface FYPlayerToolBar : UIView

/**
 *  播放状态,默认是暂停状态
 */
@property (nonatomic, assign,getter=isPlaying) BOOL playing;

/**
 *  当前播放的音乐
 */
@property (nonatomic, strong) FYMusic *playingMusic;

@property (nonatomic, weak) id<FYPlayerToolBarDelegate> delegate;

+ (instancetype)playerToolBar;

@end
