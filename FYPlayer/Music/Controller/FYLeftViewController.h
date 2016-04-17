//
//  FYLeftViewController.h
//  Music
//
//  Created by Fred on 16/1/2.
//  Copyright (c) 2016年 Fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYLeftViewDelegate <NSObject>
@required
/**
 *  选择HomeView
 */
- (void)showHomeView;

/**
 *  选择OnlineMusicView
 */
- (void)showOnlineMusicView;

/**
 *  选择AboutView
 */
- (void)showAboutView;
@end

@interface FYLeftViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign)id <FYLeftViewDelegate>  delegate;

@end
