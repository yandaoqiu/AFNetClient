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




- (instancetype)init
{
    return [self initWithUnitCount:0];
}


- (instancetype)initWithUnitCount:(int64_t)unitCount
{
    if (self = [self init])
    {
        NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [cachePaths objectAtIndex:0];
        downLoadFilePath = cachePath;
        progress = [NSProgress progressWithTotalUnitCount:unitCount];
    }
    return self;
}





@end
