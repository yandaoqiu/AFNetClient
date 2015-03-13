//
//  AFNetClient.m
//  AFNetworking
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 handsmap. All rights reserved.
//

#import "AFNetClient.h"
#import "AFHTTPSessionManager.h"

@interface AFNetClient ()
{
    
    
}
//请求数组
@property (nonatomic,strong)NSMutableDictionary *requestTasks;
//下载数组
@property (nonatomic,strong)NSMutableDictionary *requestDownLoadTasks;

@end


@implementation AFNetClient


#if __has_feature(objc_arc)



#else

- (instancetype)retain
{
    return self;
}

- (instancetype)autorelease
{
    return self;
}

- (oneway void)release
{
    [super release];
}

#endif


+ (AFNetClient *)sharedClient
{
    static AFNetClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!client)
        {
            client = [[AFNetClient alloc] init];
        }
    });
    
    return client;
}


- (instancetype)init
{
    if (self = [super init])
    {
        //初始化请求对象
        _httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
//        self.httpSessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.httpSessionManager.operationQueue.maxConcurrentOperationCount = kMaxConcurrentOperationCount;
        
        _requestTasks = [NSMutableDictionary dictionary];
        _requestDownLoadTasks = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)request:(AFNetClientRequest *)afnetClientRequest withBlock:(void (^)(NSURLSessionDataTask *, id, NSError *))block
{
    //判断网络
//    AFNetworkReachabilityStatus netSattus = [PublicUtils getNetState];
//    if (netSattus == AFNetworkReachabilityStatusUnknown || netSattus == AFNetworkReachabilityStatusNotReachable)
//    {
//        if (block)
//        {
//            block(nil,nil,[NSError errorWithDomain:@"网络连接失败" code:-2000 userInfo:nil]);
//        }
//        return;
//    }
    NSURLSessionDataTask *dataTask;
    switch (afnetClientRequest.requestType)
    {
        default:
        case Type_post:
        {
            if (afnetClientRequest.formKeyValue && afnetClientRequest.formFileName && afnetClientRequest.formMimeType && afnetClientRequest.formName && afnetClientRequest.formFilePath)
            {
                dataTask = [self.httpSessionManager POST:afnetClientRequest.url
                                          parameters:afnetClientRequest.parameters
                           constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                        {
                            NSString *key = [afnetClientRequest.formKeyValue.allKeys lastObject];
                            [formData appendPartWithFormData:[[afnetClientRequest.formKeyValue objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding]
                                                        name:key];
                            [formData appendPartWithFileData:[NSData dataWithContentsOfFile:afnetClientRequest.formFilePath]
                                                        name:afnetClientRequest.formName
                                                    fileName:afnetClientRequest.formFileName mimeType:afnetClientRequest.formMimeType];
                        }
                        success:^(NSURLSessionDataTask *task, id responseObject)
                        {
                            if (block)
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    block(task,responseObject,nil);
                                });

                            }
                            [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
                        } failure:^(NSURLSessionDataTask *task, NSError *error)
                        {
                            if (block)
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    block(task,nil,error);
                                });
                            }
                            [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
                        }];
            }
            else
            {
                dataTask = [self.httpSessionManager POST:afnetClientRequest.url
                                             contentType:afnetClientRequest.contentType
                                          parameters:afnetClientRequest.parameters
                                             success:^(NSURLSessionDataTask *task, id responseObject)
                        {
                            if (block)
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    block(task,responseObject,nil);
                                });
                            }
                            [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
                            
                        } failure:^(NSURLSessionDataTask *task, NSError *error)
                        {
                            if (block)
                            {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    block(task,nil,error);
                                });
                            }
                            [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
                        }];
                
            }
            break;
        }
        case Type_get:
        {
          dataTask = [self.httpSessionManager GET:afnetClientRequest.url parameters:afnetClientRequest.parameters success:^(NSURLSessionDataTask *task, id responseObject)
            {
                if (block)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(task,responseObject,nil);
                    });
                }
                [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            } failure:^(NSURLSessionDataTask *task, NSError *error)
             {
                 if (block)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         block(task,nil,error);
                     });
                 }
                 [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            }];
            break;
        }
        case Type_put:
        {
            
           dataTask = [self.httpSessionManager PUT:afnetClientRequest.url parameters:afnetClientRequest.parameters success:^(NSURLSessionDataTask *task, id responseObject)
            {
                if (block)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(task,responseObject,nil);
                    });
                }
                [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            } failure:^(NSURLSessionDataTask *task, NSError *error)
             {
                 if (block)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         block(task,nil,error);
                     });
                 }
                 [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            }];
            break;
        }
        case Type_delete:
        {
           dataTask = [self.httpSessionManager DELETE:afnetClientRequest.url parameters:afnetClientRequest.parameters success:^(NSURLSessionDataTask *task, id responseObject)
            {
                if (block)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(task,responseObject,nil);
                    });
                }
                [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                if (block)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(task,nil,error);
                    });
                }
                [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            }];
            break;
        }
        case Type_head:
        {
           dataTask = [self.httpSessionManager HEAD:afnetClientRequest.url parameters:afnetClientRequest.parameters success:^(NSURLSessionDataTask *task)
            {
                if (block)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(task,nil,nil);
                    });
                }
                [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            } failure:^(NSURLSessionDataTask *task, NSError *error)
             {
                 if (block)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         block(task,nil,error);
                     });
                 }
                 [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            }];
            break;
        }
        case Type_patch:
        {
            dataTask = [self.httpSessionManager PATCH:afnetClientRequest.url parameters:afnetClientRequest.parameters success:^(NSURLSessionDataTask *task, id responseObject)
            {
                if (block)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(task,responseObject,nil);
                    });
                }
                [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            } failure:^(NSURLSessionDataTask *task, NSError *error)
            {
                if (block)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(task,nil,error);
                    });
                }
                [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
            }];
            break;
        }
    }
    [self.requestTasks setObject:dataTask forKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
}


#pragma mark - 文件下载
- (void)download:(AFNetClientDownloadRequest *)afnetClientRequest withBlock:(void (^)(NSURLResponse *res, NSURL *fp ,NSError *))block
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:afnetClientRequest.url]];
    NSProgress *progress = afnetClientRequest.progress;
    __strong __typeof(progress)strongProgress = progress;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:afnetClientRequest.downLoadFilePath isDirectory:nil];
    if (!existed)
    {
        [fileManager createDirectoryAtPath:afnetClientRequest.downLoadFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSURLSessionDownloadTask *task = [self.httpSessionManager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
      {
          if (targetPath)
          {
          }
          
          NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:afnetClientRequest.downLoadFilePath];
          return [documentsDirectoryPath URLByAppendingPathComponent:[response.URL lastPathComponent]];
          
      } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
      {
          //下载成功
          //移除监听
          [strongProgress removeObserver:self
                              forKeyPath:kDownLoadProgress_KVO
                                 context:NULL];
          if (block)
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  block(response,filePath,error);
              });
          }
          [self.requestTasks removeObjectForKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
      }];
    
    // 下载进度监听
    // 设置这个progress的唯一标示符（文件存储目录）
    [strongProgress setUserInfoObject:[NSNumber numberWithInt:afnetClientRequest.cmdcode] forKey:kDownLoadProgress_KVO_KEY];
    [strongProgress addObserver:self forKeyPath:kDownLoadProgress_KVO options:NSKeyValueObservingOptionNew context:nil];
    
    [task resume];
    
    [self.requestTasks setObject:task forKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
}


- (void)downloadFile:(AFNetClientDownloadRequest*)request
   withProgressBlock:(void (^)(float progress))progressBlock
    withCompletBlock:(void (^)())completeBlock
             failure:(void (^)(NSError *error))failureBlock
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:request.downLoadFilePath isDirectory:nil];
    if (!existed)
    {
        [fileManager createDirectoryAtPath:request.downLoadFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //已经有下载了的部分
    unsigned long long downloadedBytes = 0;
    NSString *filePath =  [request.downLoadFilePath stringByAppendingPathComponent:[request.url lastPathComponent]];
    if (request.contiuDownlaod)
    {
        //检查之前下载过的文件字节
        if ([fileManager fileExistsAtPath:filePath])
        {
            NSError *error = nil;
            NSDictionary *fileDict = [fileManager attributesOfItemAtPath:filePath error:&error];
            if (!error && fileDict)
            {
                downloadedBytes = [fileDict fileSize];
            }
        }
    }
    else
    {
        //清空之前的缓存
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:request.url]]];
    }
    
    NSURLRequest *urlrequest = [NSURLRequest requestWithURL:[NSURL URLWithString:request.url]];
    
    if (downloadedBytes > 0)
    {
        NSMutableURLRequest *mutableURLRequest = [urlrequest mutableCopy];
        NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
        [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
        urlrequest = mutableURLRequest;
    }
//    不使用缓存
//    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:urlrequest];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlrequest];
    operation.downSize = downloadedBytes;
    operation.downLoadFilepath = filePath;
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];

    __weak AFHTTPRequestOperation *weakOperation = operation;

    //进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
    if (progressBlock)
    {
        
       
        long long allSize = (totalBytesExpectedToRead + weakOperation.downSize);

        float v = (float)(totalBytesRead + downloadedBytes) / allSize;
        
//        HTLog(@"%lld %lld",totalBytesRead,allSize);
        dispatch_async(dispatch_get_main_queue(), ^{
            progressBlock(v);
        });
    }
    }];
    //完成回调
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if(completeBlock)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock();
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failureBlock)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
        
    }];
    [_requestDownLoadTasks setObject:operation forKey:[NSNumber numberWithInt:request.cmdcode]];
    [operation start];
}


- (void)pauseDownloadFile:(AFREQUEST_CMD_CODE)cmdCode
{
    AFHTTPRequestOperation *opertaion = (AFHTTPRequestOperation*)[self.requestDownLoadTasks objectForKey:[NSNumber numberWithInt:cmdCode]];
    if (opertaion)
    {
        [opertaion pause];
    }

}

- (void)contiuDownloadFile:(AFREQUEST_CMD_CODE)cmdCode
{
    AFHTTPRequestOperation *opertaion = (AFHTTPRequestOperation*)[self.requestDownLoadTasks objectForKey:[NSNumber numberWithInt:cmdCode]];
    if (opertaion)
    {
        //检查之前下载过的文件字节
        unsigned long long downloadedBytes = 0;
        NSString *filePath =  opertaion.downLoadFilepath;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            NSError *error = nil;
            NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
            if (!error && fileDict)
            {
                downloadedBytes = [fileDict fileSize];
            }
        }
        opertaion.downSize = downloadedBytes;

        [opertaion resume];
    }
}

- (void)cancelAllRequest
{
    for (NSNumber *key in self.requestTasks.allKeys)
    {
        NSURLSessionTask *task = (NSURLSessionTask*)[self.requestTasks objectForKey:key];
        [task cancel];
    }
    for (NSNumber *key in self.requestDownLoadTasks.allKeys)
    {
        AFHTTPRequestOperation *opertaion = (AFHTTPRequestOperation*)[self.requestDownLoadTasks objectForKey:key];
        [opertaion cancel];
    }
}

- (void)cancelRequest:(AFREQUEST_CMD_CODE)cmdcode
{
    NSURLSessionTask *task = (NSURLSessionTask*)[self.requestTasks objectForKey:[NSNumber numberWithInt:cmdcode]];
    if (task)
    {
        [task cancel];
    }
    
    AFHTTPRequestOperation *opertaion = (AFHTTPRequestOperation*)[self.requestDownLoadTasks objectForKey:[NSNumber numberWithInt:cmdcode]];
    if (opertaion)
    {
        [opertaion cancel];
    }
}

//需要在下载管理类中实现
//#pragma mark 更新进度回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]])
    {
        NSProgress *progress = (NSProgress *)object;
        NSLog(@"Progress is %f", progress.fractionCompleted);
        
        // 打印这个唯一标示符
        NSLog(@"%@", progress.userInfo);
    }
}




@end
