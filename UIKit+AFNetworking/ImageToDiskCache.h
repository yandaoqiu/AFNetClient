//
//  ImageToDiskCache.h
//  AFNetworking iOS Example
//
//  Created by 严道秋 on 15-1-9.
//  Copyright (c) 2015年 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
static NSString * const kImageCachePath = @"AFNetWorkingImageCache";
@interface ImageToDiskCache : NSObject

/*!
 *  @author 严道秋, 15-01-09 16:01:39
 *
 *  @brief 保存图片到物理缓存
 *
 *  @param directoryPath 文件夹目录
 *  @param image         图片
 *  @param imageName     图片名称
 *
 *  @return YES/NO 保存成功、失败
 *
 *  @since 1.0
 */
- (BOOL)saveImageToDisk:(NSString*)directoryPath image:(UIImage*)image imageName:(NSString*)imageName;

/*!
 *  @author 严道秋, 15-01-09 16:01:27
 *
 *  @brief  获取物理缓存中的图片
 *
 *  @param dirName   文件夹目录
 *  @param imageName 图片名称
 *
 *  @return data byte字节
 *
 *  @since 1.0
 */
- (NSData*)loadImageData:(NSString*)dirName withImageName:(NSString*)imageName;

/*!
 *  @author 严道秋, 15-01-09 16:01:48
 *
 *  @brief  删除整个缓存文件夹
 *
 *  @param dirName 文件夹名称
 *
 *  @return YES/NO 是否删除成功
 *
 *  @since 1.0
 */
- (BOOL) deleteDirInCache:(NSString *)dirName;

/*!
 *  @author 严道秋, 15-01-09 17:01:51
 *
 *  @brief  md5
 *
 *  @param str string
 *
 *  @return md5后的string
 *
 *  @since 1.0
 */
- (NSString *)stringTomd5:(NSString*)str;
@end
