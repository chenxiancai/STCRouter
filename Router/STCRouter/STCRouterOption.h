//
//  STCRouterOption.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define STC_CURRENT_INDEX (-1)

typedef void (^STCRouterCallback)(NSDictionary *params);

@interface STCRouterOption : NSObject

/**
 native 降级为H5 后的 hybridUrl
 */
@property (readwrite, nonatomic, strong) NSString *hybridUrl;

/**
 当前开启的控制器类
 */
@property (readwrite, nonatomic, strong) Class openClass;

/**
 导航栏里面的控制器堆栈
 */
@property (readwrite, nonatomic, strong) NSArray <Class> *stackClasses;

/**
 控制器堆栈对应的路径
 */
@property (readwrite, nonatomic, strong) NSArray <NSString *> *stackRoutes;

/**
 路由回调
 */
@property (readwrite, nonatomic, copy) STCRouterCallback callback;

/**
 该属性控制UIViewController是以modal打开还是在导航控制器堆栈中push
 */
@property (readwrite, nonatomic, getter=isModal) BOOL modal;

/**
 控制器展示的UIModalPresentationStyle
 */
@property (readwrite, nonatomic) UIModalPresentationStyle presentationStyle;

/**
 控制器展示的UIModalTransitionStyle
 */
@property (readwrite, nonatomic) UIModalTransitionStyle transitionStyle;

/**
 传递给控制器的默认参数
 */
@property (readwrite, nonatomic, strong) NSDictionary *defaultParams;

/**
 是否通过把路由对应的控制器作为导航控制器的根控制器
 */
@property (readwrite, nonatomic, assign) BOOL shouldOpenAsRootViewController;

/**
 路由对应的控制器的导航控制所对应的根标签值
 */
@property (readwrite, nonatomic, assign) NSUInteger rootIndex;

/**
 创建STCRouterOption实例

 @param presentationStyle UIViewController对应的UIModalPresentationStyle
 @param transitionStyle UIViewController对应的UIModalTransitionStyle
 @param defaultParams 打开路由时默认传递的参数
 @param isRoot 是否为导航控制器的根控制器
 @param isModal 是否为Modal展示
 @param rootIndex 根标签
 @return STCRouterOption实例
 */
+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)presentationStyle
                                   transitionStyle:(UIModalTransitionStyle)transitionStyle
                                     defaultParams:(NSDictionary *)defaultParams
                                            isRoot:(BOOL)isRoot
                                           isModal:(BOOL)isModal
                                         rootIndex:(NSUInteger)rootIndex;

/**
 创建一个STCRouterOption实例

 @return STCRouterOption实例
 */
+ (instancetype)routerOptions;

/**
 创建一个STCRouterOption实例，该实例以modal展示

 @return STCRouterOption实例
 */
+ (instancetype)routerOptionsAsModal;

/**
 创建一个STCRouterOption实例，并设置该实例的UIModalPresentationStyle

 @param style UIModalPresentationStyle
 @return STCRouterOption实例
 */
+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style;

/**
 创建一个STCRouterOption实例，并设置该实例的UIModalTransitionStyle

 @param style UIModalTransitionStyle
 @return STCRouterOption实例
 */
+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style;

/**
 创建一个STCRouterOption实例，并设置默认参数

 @param defaultParams 传递给控制器的默认参数
 @return STCRouterOption实例
 */
+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams;

/**
 创建一个STCRouterOption实例，并设置rootIndex

 @param rootIndex 多个导航控制器时根标签值
 @return STCRouterOption实例
 */
+ (instancetype)routerOptionsAsRootWithIndex:(NSUInteger)rootIndex;

//previously supported
/**
 @remarks not idiomatic objective-c naming for allocation and initialization, see +routerOptionsAsModal
 @return A new instance of `UPRouterOptions`, setting a modal presentation format.
 */

/**
 创建一个modal展示的STCRouterOption实例

 @return STCRouterOption实例
 */
+ (instancetype)modal;

/**
 创建一个设置好UIModalPresentationStyle的STCRouterOption实例

 @param style UIModalPresentationStyle
 @return STCRouterOption实例
 */
+ (instancetype)withPresentationStyle:(UIModalPresentationStyle)style;

/**
 创建一个设置好UIModalTransitionStyle的STCRouterOption实例

 @param style UIModalTransitionStyle
 @return STCRouterOption实例
 */
+ (instancetype)withTransitionStyle:(UIModalTransitionStyle)style;

/**
 创建一个带默认参数的STCRouterOption实例

 @param defaultParams 传递给控制器的默认参数
 @return STCRouterOption实例
 */
+ (instancetype)forDefaultParams:(NSDictionary *)defaultParams;

/**
 创建一个带rootIndex的STCRouterOption实例

 @param rootIndex 多个导航控制器时根标签值
 @return STCRouterOption实例
 */
+ (instancetype)rootWithIndex:(NSUInteger)rootIndex;

/**
 设置modal属性

 @return STCRouterOption实例本身
 */
- (STCRouterOption *)modal;

/**
 设置UIModalPresentationStyle属性

 @param style UIModalPresentationStyle
 @return STCRouterOption实例本身
 */
- (STCRouterOption *)withPresentationStyle:(UIModalPresentationStyle)style;

/**
 设置UIModalTransitionStyle属性

 @param style UIModalTransitionStyle
 @return STCRouterOption实例本身
 */
- (STCRouterOption *)withTransitionStyle:(UIModalTransitionStyle)style;

/**
 设置defaultParams默认参数

 @param defaultParams 传递给控制器的默认参数
 @return STCRouterOption实例本身
 */
- (STCRouterOption *)forDefaultParams:(NSDictionary *)defaultParams;

/**
 设置是否以根控制打开路由对应的控制器

 @return STCRouterOption实例本身
 */
- (STCRouterOption *)root;

/**
 设置路由根控制器对应的导航控制器的标签值

 @param index 导航控制器的标签值
 @return STCRouterOption实例本身
 */
- (STCRouterOption *)rootIndex:(NSUInteger)index;

@end
