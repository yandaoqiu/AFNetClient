//
//  ImageToDiskCache.m
//  AFNetworking iOS Example
//
//  Created by 严道秋 on 15-1-9.
//  Copyright (c) 2015年 Gowalla. All rights reserved.
//

#import "ImageToDiskCache.h"
#import<CommonCrypto/CommonDigest.h>
@implementation ImageToDiskCache

/*!
 *  @author 严道秋, 15-01-09 16:01:46
 *
 *  @brief  创建缓存文件夹
 *
 *  @param dirName 文件夹名称
 *
 *  @return YES/NO 创建成功还是失败
 *
 *  @since 1.0
 */
- (BOOL) createDirInCache:(NSString *)dirName
{
    NSString *imageDir = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    BOOL isCreated = NO;
    if (!(isDir == YES && existed == YES))
    {
        isCreated = [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed)
    {
        isCreated = YES;
    }
    return isCreated;
}

- (NSString* )pathInCacheDirectory:(NSString *)fileName
{
     NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
     NSString *cachePath = [cachePaths objectAtIndex:0];
     return [cachePath stringByAppendingPathComponent:fileName];
}


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
- (BOOL) deleteDirInCache:(NSString *)dirName
{
     NSString *imageDir = [self pathInCacheDirectory:dirName];
     BOOL isDir = NO;
     NSFileManager *fileManager = [NSFileManager defaultManager];
     BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
     bool isDeleted = false;
     if (isDir == YES && existed == YES)
     {
        isDeleted = [fileManager removeItemAtPath:imageDir error:nil];
     }
    return isDeleted;
}

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
- (BOOL)saveImageToDisk:(NSString*)directoryPath image:(UIImage*)image imageName:(NSString*)imageName
{
    if ([self createDirInCache:directoryPath])
    {
        //创建文件夹成功
        BOOL isDir = NO;
        BOOL isSaved = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:[self pathInCacheDirectory:directoryPath] isDirectory:&isDir];
        
        if(isDir == YES && existed == YES)
        {
            NSData *imageData = UIImagePNGRepresentation(image);
            NSError *erro;
            if (imageData)
            {
                isSaved = [imageData writeToFile:[[self pathInCacheDirectory:directoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]] options:NSAtomicWrite error:&erro];
            }
            else if ((imageData = UIImageJPEGRepresentation(image,1.0)))
            {
                isSaved = [imageData writeToFile:[[self pathInCacheDirectory:directoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]] options:NSAtomicWrite error:&erro];
            }
        }
        
        return isSaved;
    }
    return NO;
}


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
- (NSData*)loadImageData:(NSString*)dirName withImageName:(NSString*)imageName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:[self pathInCacheDirectory:dirName] isDirectory:&isDir];
    if (dirExisted == YES && isDir == YES)
    {
        NSString *imagePath = [[self pathInCacheDirectory:dirName] stringByAppendingPathComponent:imageName];
        BOOL fileExisted = [fileManager fileExistsAtPath:imagePath];
        if (fileExisted)
        {
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            return imageData;
        }
    }
    
    return nil;
}

- (NSString *)stringTomd5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (uint32_t)strlen(cStr),result );
    NSMutableString *hash =[NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

@end
