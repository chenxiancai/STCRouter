//
//  STCRouter.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCRouterOption.h"
#import "STCRouterParams.h"
#import "STCRouterError.h"

typedef void (^STCRouterForward)(STCRouterParams *routerParams, STCRouterError * error);

@interface STCRouter : NSObject

/**
 tabBar控制器，可为空
 */
@property (readwrite, nonatomic, strong) __kindof UITabBarController *tabBarController;

/**
 根导航控制器，如果tabBarController为空，则navigationControllers只有第一个导航控制器有效，
 若tabBarController为不为空，则导航控制器为tabBarController所有根导航控制器
 */
@property (readwrite, nonatomic, strong) NSArray<__kindof UINavigationController *> *navigationControllers;

/**
 是否抛异常
 */
@property (readwrite, nonatomic, assign) BOOL ignoresExceptions;

/**
 App的scheme
 */
@property (readwrite, nonatomic, copy) NSString *appScheme;

/**
 其他情况下路由转发
 */
@property (readwrite, nonatomic, copy) STCRouterForward routerForward;

/**
 注册URL的给匿名回调

 @param format 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param callback 调用"openURL"后的匿名回调
 */
- (void)registerURLFormat:(NSString *)format
               toCallback:(STCRouterCallback)callback;

/**
 注册URL给匿名回调，同时设置路由属性

 @param format 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param callback 调用"openURL"后的匿名回调
 @param options 可配置的路由属性
 */
- (void)registerURLFormat:(NSString *)format
               toCallback:(STCRouterCallback)callback
              withOptions:(STCRouterOption *)options;

/**
 注册URL的给控制器类

 @param format 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param controllerClass 控制器类名
 */
- (void)registerURLFormat:(NSString *)format
             toController:(Class)controllerClass;

/**
 注册URL的给控制器类，同时设置路由属性
 
 @param format 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param controllerClass 控制器类名
 @param options 可配置的路由属性
 */
- (void)registerURLFormat:(NSString *)format
             toController:(Class)controllerClass
              withOptions:(STCRouterOption *)options;

/**
 封装UIApplication的openURL:方法

 @param url 系统支持的URL链接
 */
- (void)openExternalURL:(NSString *)url;

/**
 打开注册的路由对应的匿名回调或者控制器，路由不存在、导航栏没配置或者控制器没有实现STCRouterProtocol时会抛异常

 @param url 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 */
- (void)openURL:(NSString *)url;

/**
 打开注册的路由对应的匿名回调或者控制器，路由不存在、导航栏没配置或者控制器没有实现STCRouterProtocol时会抛异常

 @param url 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param animated 是否有动画
 */
- (void)openURL:(NSString *)url
   withAnimated:(BOOL)animated;

/**
 打开注册的路由对应的匿名回调或者控制器，路由不存在、导航栏没配置或者控制器没有实现STCRouterProtocol时会抛异常
 
 @param url 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 @param animated 是否有动画
 @param extraParams 外部参数
 */
- (void)openURL:(NSString *)url
withAnimated:(BOOL)animated
    extraParams:(NSDictionary *)extraParams;

/**
 pop当前路由中最上层的控制器，如果是modal控制器，则会dismiss掉，该动作是有动画的。
 */
- (void)pop;

/**
 pop当前路由中最上层的控制器，如果是modal控制器，则会dismiss掉。

 @param animated 设置该pop动作是否带动画;
 */
- (void)popWithAnimated:(BOOL)animated;

/**
 获取链接中的参数
 
 @param url 标准URL格式 http:\\host[:port][abs_path][:parameters][?query]#fragment
 */
- (NSDictionary*)paramsOfURL:(NSString*)url;

@end
