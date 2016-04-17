//
//  FYMusicCell.m
//  Music
//
//  Created by Fred on 15/9/27.
//  Copyright (c) 2015年 Fred. All rights reserved.
//

#import "FYMusicCell.h"
#import "FYMusic.h"
#import "UIImage+HY.h"

@implementation FYMusicCell

+ (instancetype)musicCellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"cell";
    //forIndexPath:indexPath 跟 storyboard 配套使用
    FYMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //Configure the cell ...
    if (cell == nil) {
        cell = [[FYMusicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

//显示cell的数据
- (void)setMusic:(FYMusic *)music
{
    _music = music;
    
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    UIImage *circleImage = [UIImage circleImageWithName:music.singerIcon borderWidth:1.0 borderColor:[UIColor whiteColor]];
    self.imageView.image = circleImage;
}

@end
