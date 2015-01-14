//
//  AFNetClientDownloadRequest.h
//  AFNetworking iOS Example
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 Gowalla. All rights reserved.
//

#import "AFNetClientRequest.h"

@interface AFNetClientDownloadRequest : AFNetClientRequest
{
    //起始点
    NSProgress *progress;
    
    //文件下载路径
    NSString *downLoadFilePath;
    
    
}
@property (nonatomic,strong)NSProgress *progress;
@property (nonatomic,strong)NSString *downLoadFilePath;

@end
