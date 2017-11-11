//
//  STCRouterCenter.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCRouter.h"

@interface STCRouterCenter : NSObject

+ (instancetype)defaultCenter;

@property (nonatomic, strong, readonly) STCRouter *router;

/**
 添加黑名单

 @param objects App bundleID 黑名单列表
 */
- (void)addBlackListWithObjects:(NSArray<NSString *> *)objects;

/**
 添加路径对应的白名单，如果路径加入白名单，则只有白名单中已加入的bundleID的App可以访问该路径

 @param dict 路径对应的App bundleID白名单
 */
- (void)addWhiteListInPathWithBIDs:(NSDictionary<NSString *, NSArray *> *)dict;

/**
 路由过滤拦截

 @param url 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param BID App bundleID
 @return 是否过滤，YES过滤，NO不过滤
 */
- (BOOL)filterRouterWithUrl:(NSString *)url BID:(NSString *)BID;

@end

