//
//  AFNetClientDownloadRequest.m
//  AFNetworking iOS Example
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 Gowalla. All rights reserved.
//

#import "AFNetClientDownloadRequest.h"

@implementation AFNetClientDownloadRequest

@synthesize downLoadFilePath;
@synthesize progress;
- (instancetype)initWithUnitCount:(int64_t)unitCount
{
    if (self = [super init])
    {
        progress = [NSProgress progressWithTotalUnitCount:unitCount];
    }
    return self;
}
@end
