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

@end

static AFNetClient *client;
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
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (!client)
        {
            client = [super allocWithZone:zone];
            return client;
        }
    }
    return nil;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    if (zone)
    {
        
    }
    return self;
}

+ (AFNetClient *)sharedClient
{
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
        self.httpSessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.httpSessionManager.operationQueue.maxConcurrentOperationCount = kMaxConcurrentOperationCount;
        
        _requestTasks = [NSMutableDictionary dictionary];
    }
    return self;
}






- (void)request:(AFNetClientRequest *)afnetClientRequest withBlock:(void (^)(NSURLSessionDataTask *task,id, NSError *))block
{
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
    NSURLSessionDownloadTask *task = [self.httpSessionManager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
    {
        if (targetPath)
        {
            
        }
        
        NSURL *documentsDirectoryURL = [NSURL URLWithString:afnetClientRequest.downLoadFilePath];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response.URL lastPathComponent]];

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
    {
        //下载成功
        //移除监听
        [progress removeObserver:self
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
    [progress setUserInfoObject:[NSNumber numberWithInt:afnetClientRequest.cmdcode] forKey:kDownLoadProgress_KVO_KEY];
    [progress addObserver:self forKeyPath:kDownLoadProgress_KVO options:NSKeyValueObservingOptionNew context:nil];
    
    [task resume];
    
    [self.requestTasks setObject:task forKey:[NSNumber numberWithInt:afnetClientRequest.cmdcode]];
}

- (void)cancelAllRequest
{
    for (NSNumber *key in self.requestTasks.allKeys)
    {
        NSURLSessionTask *task = (NSURLSessionTask*)[self.requestTasks objectForKey:key];
        [task cancel];
    }
}

- (void)cancelRequest:(REQUEST_CMD_CODE)cmdcode
{
    NSURLSessionTask *task = (NSURLSessionTask*)[self.requestTasks objectForKey:[NSNumber numberWithInt:cmdcode]];
    if (task)
    {
        [task cancel];
    }
}

//需要在下载管理类中实现
//#pragma mark 更新进度回调
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]])
//    {
//        NSProgress *progress = (NSProgress *)object;
//        NSLog(@"Progress is %f", progress.fractionCompleted);
//        
//        // 打印这个唯一标示符
//        NSLog(@"%@", progress.userInfo);
//    }
//}




@end
