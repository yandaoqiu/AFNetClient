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
#define kHttp_Timout                 5
//最大并发量
#define kMaxConcurrentOperationCount 1

#define kContentTypeJson            @"application/json"

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
    
    CC_GET_MUSIC_LIST = 0x0001,               //请求音乐列表
    CC_GET_TIP_LIST = 0x0002,                 //请求贴士列表
    
    
    
    CC_GET_INFO_HOT_LIST    = 0x0008,       //获取资讯－热点信息
    CC_GET_INFO_ACTICITY_LIST    = 0x0009,  //获取资讯－佛事活动
    CC_GET_INFO_ANNOUNCEMENT_LIST= 0x0100,  //获取资讯－公告管理
    CC_GET_INFO_HOT_LIST_MORE    = 0x0101,       //获取资讯－热点信息-更多
    CC_GET_INFO_ACTICITY_LIST_MORE    = 0x0102,  //获取资讯－佛事活动-更多
    CC_GET_INFO_ANNOUNCEMENT_LIST_MORE= 0x0103,  //获取资讯－公告管理-更多
    CC_GET_INFO_HOT_LIST_NEW    = 0x0104,       //获取资讯－热点信息-最新
    CC_GET_INFO_ACTICITY_LIST_NEW    = 0x0105,  //获取资讯－佛事活动-最新
    CC_GET_INFO_ANNOUNCEMENT_LIST_NEW= 0x0106,  //获取资讯－公告管理-最新
    CC_GET_PUSH_INFO_HOT         = 0x0107,
    CC_GET_PUSH_INFO_ACTIVIES    = 0x0108,
    CC_GET_PUSH_INFO_ANN         = 0x0109,
    
    CC_GET_GUEST_VOLUME          = 0x0110,      //请求客流量
    CC_GET_CAR_COUNT             = 0x0111,      //请求车位数
    
    CC_GET_CXFW_LIST             = 0x0112,      //请求禅修服务列表
    CC_GET_LFBF_LIST             = 0x0113,      //请求礼佛拜佛列表
    CC_GET_DZJZ_LIST             = 0x0114,      //请求电子捐赠列表
    CC_GET_FYYQ_LIST             = 0x0115,      //请求佛缘迎请列表
    
    CC_CHECK_LANGUAGE            = 0x1000,  //请求多语言更新
    CC_CHECK_VERSION             = 0x1001,  //app版本检查
    CC_CHECK_WELCOMEPAGE         = 0x1002,  //检查欢迎页面
    CC_CHECK_GUIDEPAGE           = 0x1003,  //检查引导页
    CC_CHECK_TABVERSION          = 0x1004,  //请求数据表更新
    CC_CHECK_MAP                 = 0x1005,  //地图版本检查
    
    CC_DOWN_WELCOMEPAGE          = 0x1005,  //下载欢迎页面zip
    CC_DOWN_GUIDEPAGE            = 0x1006,   //引导页下载
    CC_DOWN_IMAGE_HOME_PAGE      = 0x1007,  //下载欢迎页面文件
    CC_DOWN_LANGUAGE             = 0x1008,  //下载多语言配置文件
//  0x1020之前的不要使用
    CC_DOWN_MAP                  = 0x1050,  //下载地图文件
    
    CC_DOWN_UN_KNOW = -1,
    CC_UOLOAD_UN_KNOW = -2,
}AFREQUEST_CMD_CODE;

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
- (void)afnetClientDownlaodProgress:(AFREQUEST_CMD_CODE)comdCode;

@end


#endif
