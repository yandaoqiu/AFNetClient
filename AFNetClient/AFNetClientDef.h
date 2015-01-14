//
//  AFNetClientDef.h
//  AFNetworking
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 handsmap. All rights reserved.
//

#ifndef AFNetClientDef_
    #define AFNetClientDef_

//UIKit+UIImage 图片请求超时时间 设置为0则为默认60s
#define kUIKit_UIImage_TimeOut       20
//UIKit+UIButton 图片请求超时时间 设置为0则为默认60s
#define kUIKit_UIButton_Timout       20
//http请求超时时间，设置为0则默认为60s
#define kHttp_Timout                 20
//最大并发量
#define kMaxConcurrentOperationCount 2





//版本
#define kAFNetClient_version         1.0


#define kDownLoadProgress_KVO       @"DownLoadProgress"
#define kDownLoadProgress_KVO_KEY   @"DownloadKey"






//请求优先级
typedef enum
{
    Level_default = 0,
    Level_high,
    Level_low,
}Priority_level;

//请求方式
typedef enum
{
    Type_post = 0,
    Type_get,
    Type_delete,
    Type_put,
    Type_head,
    Type_patch,
}Request_type;


//下载 上传 类型
typedef enum
{
    
    
    
    CC_DOWN_UN_KNOW = -1,
    CC_UOLOAD_UN_KNOW = -2,
}REQUEST_CMD_CODE;

//所有网络的请求实体类必须实现该接口
@protocol AFNetClientEntityInterface <NSObject,NSSecureCoding>

@required
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end


//下载文件进度
@protocol AFNetClientDownloadProgressDelegate <NSObject>
@optional
/*!
 *  @author 严道秋, 15-01-12 17:01:42
 *
 *  @brief  下载文件回调
 *
 *  @param comdCode 下载的请求码，区别类型
 *
 *  @since 1.0
 */
- (void)afnetClientDownlaodProgress:(REQUEST_CMD_CODE)comdCode;

@end


#endif
