//
//  STCRouterParser.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCRouterParams.h"

@interface STCRouterParser : NSObject

/**
 路由解析

 @param url 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param extraParams 外部参数
 @param routes 已注册的路由列表
 @return 解析后的路由参数
 */
+ (STCRouterParams *)routerParamsForUrl:(NSString *)url
                       withExtraParams:(NSDictionary<NSString *, NSObject *> *)extraParams
                        registerRoutes:(NSDictionary<NSString *, STCRouterOption *> *)routes;

@end
