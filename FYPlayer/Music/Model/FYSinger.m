//
//  FYSinger.m
//  Music
//
//  Created by Fred on 16/1/3.
//  Copyright (c) 2016年 Fred. All rights reserved.
//

#import "FYSinger.h"
#import "NSObject+LKDBHelper.h"

@implementation FYSinger

/**表名*/
+ (NSString *)getTableName
{
    return @"SingerInfo";
}

/**表版本*/
+ (int)getTableVersion
{
    return 1;
}

/**主键*/
+ (NSString *)getPrimaryKey
{
    return @"ting_uid";
}

- (NSMutableArray *)itemWith:(NSString *)name
{
    NSMutableArray * array = [FYSinger searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",name] orderBy:nil offset:0 count:0];
    NSMutableArray * temp = [NSMutableArray new];
    NSMutableArray * temp1 = [NSMutableArray new];
    for (FYSinger * sub in array) {
        if ([sub.name length]!=0) {
            if ([sub.company length]!=0) {
                [temp addObject:sub];
            }else{
                [temp1 addObject:sub];
            }
        }
    }
    [temp addObjectsFromArray:temp1];
    return temp;
}

- (NSMutableArray *)itemTop100
{
    NSMutableArray * array = [FYSinger searchWithWhere:[NSString stringWithFormat:@"'songs_total' >1000"] orderBy:nil offset:0 count:50];
    //NSMutableArray *array = [self itemWith:@"李"];
    
    return array;
}

@end
