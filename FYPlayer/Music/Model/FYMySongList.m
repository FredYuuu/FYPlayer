//
//  FYMySongList.m
//  Music
//
//  Created by Fred on 16/2/4.
//  Copyright (c) 2016年 Fred. All rights reserved.
//

#import "FYMySongList.h"

@implementation FYMySongList

- (instancetype)init {
    if (self = [super init]) {
        self.songLists = [NSMutableArray new];
    }
    return self;
}

@end
