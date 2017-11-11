//
//  STCRouterFilter.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCRouterFilter : NSObject

/**
 路由过滤

 @param url 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param BID App bundleID
 @return 是否过滤，YES过滤，NO不过滤
 */
- (BOOL)filterRouterWithUrl:(NSString *)url BID:(NSString *)BID;

/**
 添加App bundleID到黑名单列表

 @param objects App bundleID列表
 */
- (void)addBlackListWithObjects:(NSArray<NSString *> *)objects;

/**
 从黑名单列表删除App bundleID列表

 @param objects App bundleID列表
 */
- (void)removeBlackListWithObjects:(NSArray<NSString *> *)objects;

/**
 添加App bundleID到路径白名单列表

 @param path 路由路径名
 @param BIDs App bundleID
 */
- (void)addWhiteListWithPath:(NSString *)path BIDs:(NSArray *)BIDs;

/**
 从路径白名单中删除App bundleID

 @param path 路由路径名称
 @param BID App bundleID
 */
- (void)removeWhiteListWithPath:(NSString *)path BID:(NSString *)BID;

@end
