//
//  NSError+Additions.m
//  Music
//
//  Created by Fred on 16/2/4.
//  Copyright (c) 2016年 Fred. All rights reserved.
//

#import "NSError+Additions.h"

@implementation NSError (Additions)

- (BOOL)isURLError{
    return [self.domain isEqualToString:NSURLErrorDomain];
}

@end
