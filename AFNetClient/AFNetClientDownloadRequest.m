//
//  AFNetClientDownloadRequest.m
//  AFNetworking
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 handsmap. All rights reserved.
//

#import "AFNetClientDownloadRequest.h"

@implementation AFNetClientDownloadRequest

@synthesize downLoadFilePath;
@synthesize progress;
@synthesize contiuDownlaod;



- (instancetype)init
{
    if (self = [super init])
    {
        NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [cachePaths objectAtIndex:0];
        downLoadFilePath = cachePath;
        NSProgress *tmpProgress = [NSProgress progressWithTotalUnitCount:0];
        self.progress = tmpProgress;
        contiuDownlaod = YES;
    }
    return self;
}


- (instancetype)initWithUnitCount:(int64_t)unitCount
{
    if (self = [super init])
    {
        NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [cachePaths objectAtIndex:0];
        downLoadFilePath = cachePath;
        NSProgress *tmpProgress = [NSProgress progressWithTotalUnitCount:unitCount];
        self.progress = tmpProgress;
        contiuDownlaod = YES;
    }
    return self;
}








@end
