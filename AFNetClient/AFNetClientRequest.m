//
//  AFNetClientRequest.m
//  AFNetworking
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 handsmap. All rights reserved.
//

#import "AFNetClientRequest.h"

@implementation AFNetClientRequest
@synthesize url;
@synthesize requestType;
@synthesize parameters;
@synthesize level;
@synthesize entity;
@synthesize formKeyValue;
@synthesize formMimeType;
@synthesize formName;
@synthesize formFileName;
@synthesize formFilePath;
@synthesize cmdcode;
- (instancetype)initWithParamenters:(NSDictionary*)p
{
    if (self = [super init])
    {
        parameters = [NSDictionary dictionaryWithDictionary:p];
    }
    return self;
}
@end
