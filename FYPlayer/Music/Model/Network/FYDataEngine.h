//
//  FYDataEngine.h
//  Music
//
//  Created by Fred on 16/2/4.
//  Copyright (c) 2016年 Fred. All rights reserved.
//

#import "FYNetworkEngine.h"

@class FYSong, FYMySongList;
@interface FYDataEngine : FYNetworkEngine

typedef void (^SalesResponseBlock) (NSArray *array);
typedef void (^FYSongListModelResponseBlock) (FYMySongList *songList);
typedef void (^FYSongModelResponseBlock) (FYSong *songModel);
typedef void (^FYSongLrcResponseBlock)(BOOL sucess,NSString * path);
typedef void (^FYSongLinkDownLoadResponseBlock)(BOOL sucess,NSString * path);

- (MKNetworkOperation *)getSingerInformationWith:(long long)tinguid
                          WithCompletionHandler:(SalesResponseBlock)completion
                                   errorHandler:(MKNKErrorBlock)errorHandler;

- (MKNetworkOperation *)getSingerSongListWith:(long long)tinguid :(int) number
                       WithCompletionHandler:(FYSongListModelResponseBlock)completion
                                errorHandler:(MKNKErrorBlock)errorHandler;

- (MKNetworkOperation *)getSongInformationWith:(long long)songID
                        WithCompletionHandler:(FYSongModelResponseBlock)completion
                                 errorHandler:(MKNKErrorBlock)errorHandler;

- (MKNetworkOperation *)getSongLrcWith:(long long)tingUid :(long long)songID :(NSString *)lrclink
                WithCompletionHandler:(FYSongLrcResponseBlock)completion
                         errorHandler:(MKNKErrorBlock)errorHandler;

- (MKNetworkOperation *)downLoadSongWith:(long long)tingUid :(long long)songID :(NSString *)songLink
                  WithCompletionHandler:(FYSongLinkDownLoadResponseBlock)completion
                           errorHandler:(MKNKErrorBlock)errorHandler;

@end
