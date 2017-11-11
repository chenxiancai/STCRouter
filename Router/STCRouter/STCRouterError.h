//
//  STCRouterError.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, STCRouterErrorCode) {
    STCRouterNaviControllerNotProvided = 100,
    STCRouterNaviControllerWithRootIndexNotProvided = 200,
    STCRouterNotProvidedInInitialized = 300,
    STCRouterAppSchemeNotSet = 400,
    STCRouterNotFound = 500,
    STCRouterControllerClassInitializerNotFound = 600
};
// 路由的导航控制器没有设置
FOUNDATION_EXPORT NSErrorDomain const STCRouterNaviControllerNotProvidedDomain;
// 有根标签值的导航控制器没有设置
FOUNDATION_EXPORT NSErrorDomain const STCRouterNaviControllerWithRootIndexNotProvidedDomain;
// 注册URL格式没有提供路由路径
FOUNDATION_EXPORT NSErrorDomain const STCRouterNotProvidedInInitializedDomain;
// App的scheme没有设置
FOUNDATION_EXPORT NSErrorDomain const STCRouterAppSchemeNotSetDomain;
// 没有找到对应路径的路由目标
FOUNDATION_EXPORT NSErrorDomain const STCRouterNotFoundDomain;
// 控制器没有实现路由协议的初始化方法
FOUNDATION_EXPORT NSErrorDomain const STCRouterControllerClassInitializerNotFoundDomain;

@interface STCRouterError : NSError

@end
