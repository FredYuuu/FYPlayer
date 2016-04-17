//
//  FYGlobal.h
//  Music
//
//  Created by Fred on 16/1/3.
//  Copyright (c) 2016年 Fred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYGlobal : NSObject

@property (nonatomic, assign) BOOL isApplicationEnterBackground;
@property (nonatomic, assign) BOOL isPlaying;

+ (FYGlobal *)sharedGlobal;
- (void)copySqlitePath;

@end
