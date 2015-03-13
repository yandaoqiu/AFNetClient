//
//  AFNetClientRequest.h
//  AFNetworking
//
//  Created by 严道秋 on 15-1-12.
//  Copyright (c) 2015年 handsmap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetClientDef.h"
@interface AFNetClientRequest : NSObject
{
    //请求地址 *必填 （如果是上传和下载的时候 url必须设置全路径,如何设置baseurl,请查看AFNetClient函数）
     NSString *url;
    //请求方式 *可选 (默认post)
    Request_type requestType;
    //参数    *post下必填
     NSDictionary *parameters;
    //请求优先级 *暂时未使用
     Priority_level level;
    //请求返回的实体类 *可选
     id<AFNetClientEntityInterface> entity;
    //表单发送 *可选
    NSDictionary *formKeyValue;
    //img/jpeg
    NSString *formMimeType;
    //imagefile
    NSString *formName;
    //img.jpg
    NSString *formFileName;
    //xxx/xxx/img.jpg
    NSString *formFilePath;
    //head contentType (默认是application/json)
    NSString *contentType;
    
    //请求码
    AFREQUEST_CMD_CODE cmdcode;
}
@property (nonatomic,strong)NSString *url;
@property (nonatomic)       Request_type requestType;
@property (nonatomic,strong)NSDictionary *parameters;
@property (nonatomic)       Priority_level level;
@property (nonatomic,strong)id<AFNetClientEntityInterface> entity;
@property (nonatomic,strong)NSDictionary *formKeyValue;
@property (nonatomic,strong)NSString *formMimeType;
@property (nonatomic,strong)NSString *formName;
@property (nonatomic,strong)NSString *formFileName;
@property (nonatomic,strong)NSString *formFilePath;
@property (nonatomic)       AFREQUEST_CMD_CODE cmdcode;
@property (nonatomic,strong)NSString *contentType;
@end
