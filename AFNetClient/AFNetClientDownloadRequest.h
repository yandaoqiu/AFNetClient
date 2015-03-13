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
    //起始点 (废弃)
    NSProgress *progress;
    
    //是否支持断点下载 (默认打开的)
    BOOL contiuDownlaod;
    
    //文件下载路径
    NSString *downLoadFilePath;//默认是tmp
    
    
}
@property (nonatomic,strong)NSProgress *progress;
@property (nonatomic,assign)BOOL contiuDownlaod;
@property (nonatomic,strong)NSString *downLoadFilePath;

@end
