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
- (void)download:(AFNetClientDownloadRequest*)afnetClientRequest withBlock:(void (^)(NSURLResponse *res, NSURL *fp ,NSError *error))block;



/*!
 *  @author 严道秋, 15-01-23 14:01:01
 *
 *  @brief  断点下载
 *
 *  @param request       下载请求
 *  @param progressBlock 进度回调
 *  @param completeBlock 完成回调
 *  @param failureBlock  失败回调
 *
 *  @since 2.0
 */
- (void)downloadFile:(AFNetClientDownloadRequest*)request
    withProgressBlock:(void (^)(float progress))progressBlock
    withCompletBlock:(void (^)())completeBlock
             failure:(void (^)(NSError *error))failureBlock;


/*!
 *  @author 严道秋, 15-01-23 14:01:17
 *
 *  @brief  暂停下载
 *
 *  @param cmdeCode 请求码
 *
 *  @since 1.0
 */
- (void)pauseDownloadFile:(AFREQUEST_CMD_CODE)cmdCode;


/*!
 *  @author 严道秋, 15-01-23 14:01:14
 *
 *  @brief  继续下载
 *
 *  @param cmdCode 请求码
 *
 *  @since 1.0
 */
- (void)contiuDownloadFile:(AFREQUEST_CMD_CODE)cmdCode;


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
- (void)cancelRequest:(AFREQUEST_CMD_CODE)cmdcode;



@end
