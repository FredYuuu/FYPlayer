//
//  FYMusicCell.h
//  Music
//
//  Created by Fred on 15/9/27.
//  Copyright (c) 2015年 Fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYMusic;
@interface FYMusicCell : UITableViewCell

+ (instancetype)musicCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) FYMusic *music;
@end
