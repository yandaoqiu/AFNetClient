//
//  AFNetClient.h
//  AFNetworking
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 handsmap. All rights reserved.
//




#import "AFHTTPSessionManager.h"
#import "AFNetClientRequest.h"
#import "AFNetClientDownloadRequest.h"
@interface AFNetClient : NSObject

@property (nonatomic,strong)AFHTTPSessionManager *httpSessionManager;
+ (AFNetClient*)sharedClient;



/*!
 *  @author 严道秋, 15-01-12 16:01:44
 *
 *  @brief  发送请求
 *
 *  @param afnetClientRequest 请求对象
 *  @param block 闭包
 *
 *  @since 1.0
 */
- (void)request:(AFNetClientRequest*)afnetClientRequest withBlock:(void (^)(NSURLSessionDataTask *task,id obj,NSError*error))block;

/*!
 *  @author 严道秋, 15-01-12 17:01:38
 *
 *  @brief  下载文件 支持进度回调 查看 NSProgress kvc(UserInfoObject kDownLoadProgress_KVO_KEY ,keyPath kDownLoadProgress_KVO)
 *
 *  @param afnetClientRequest 下载请求
 *  @param block    完成任务
 *
 *  @since 1.0
 */
- (void)download:(AFNetClientDownloadRequest*)afnetClientRequest withBlock:(void (^)(NSURLResponse *res, NSURL *fp ,NSError *))block;



/*!
 *  @author 严道秋, 15-01-12 21:01:48
 *
 *  @brief  取消所有请求
 *
 *  @since 1.0
 */
- (void)cancelAllRequest;


/*!
 *  @author 严道秋, 15-01-12 21:01:58
 *
 *  @brief  按照请求码取消请求
 *
 *  @param cmdcode 请求码
 *
 *  @since 1.0
 */
- (void)cancelRequest:(REQUEST_CMD_CODE)cmdcode;



@end
