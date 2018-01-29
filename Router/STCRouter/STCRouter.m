//
//  STCRouter.m
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import "STCRouter.h"
#import "STCRouterParams.h"
#import "STCRouterParser.h"

@interface STCRouter ()

@property (readwrite, nonatomic, strong) NSMutableDictionary<NSString *, STCRouterOption *> *routes;
@property (readwrite, nonatomic, strong) NSMutableDictionary<NSString *, STCRouterParams *> *cachedRoutes;

@end

@implementation STCRouter

- (id)init {
    if ((self = [super init])) {
        self.routes = [NSMutableDictionary dictionary];
        self.cachedRoutes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)popViewControllerFromRouterAnimated:(BOOL)animated {
    if (![self.navigationControllers firstObject]) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNaviControllerNotProvidedDomain code:STCRouterNaviControllerNotProvided userInfo:nil];
                self.routerForward(nil, error);
            }
            return;
        }
        @throw [NSException exceptionWithName:@"NavigationController Not Provided"
                                       reason:@"navigationController has not been set to a UINavigationController instance"
                                     userInfo:nil];
    }
    
    if (!self.tabBarController) {
        if (self.navigationControllers.firstObject.presentedViewController) {
            [self.navigationControllers.firstObject dismissViewControllerAnimated:animated completion:nil];
        }
        else {
            [self.navigationControllers.firstObject popViewControllerAnimated:animated];
        }
    } else {
        NSUInteger currentIndex = self.tabBarController.selectedIndex;
        UINavigationController *currentNavigationController = [self.navigationControllers objectAtIndex:currentIndex];
        if (currentNavigationController.presentedViewController) {
            [currentNavigationController dismissViewControllerAnimated:animated completion:nil];
        }
        else {
            [currentNavigationController popViewControllerAnimated:animated];
        }
    }
}

- (void)pop {
    [self popViewControllerFromRouterAnimated:YES];
}

- (void)popWithAnimated:(BOOL)animated {
    [self popViewControllerFromRouterAnimated:animated];
}

- (void)registerURLFormat:(NSString *)format
               toCallback:(STCRouterCallback)callback {
    [self registerURLFormat:format toCallback:callback withOptions:nil];
}

- (void)registerURLFormat:(NSString *)format
               toCallback:(STCRouterCallback)callback
              withOptions:(STCRouterOption *)options {
    if (!format) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNotProvidedInInitializedDomain code:STCRouterNotProvidedInInitialized userInfo:nil];
                self.routerForward(nil, error);
            }
            return;
        }
    
        @throw [NSException exceptionWithName:@"Route Not Provided"
                                       reason:@"Route format is not initialized"
                                     userInfo:nil];
        return;
    }
    if (!options) {
        options = [STCRouterOption routerOptions];
    }
    options.callback = callback;
    [self.routes setObject:options forKey:format];
}

- (void)registerURLFormat:(NSString *)format
             toController:(Class)controllerClass {
    [self registerURLFormat:format toController:controllerClass withOptions:nil];
}

- (void)registerURLFormat:(NSString *)format
             toController:(Class)controllerClass
              withOptions:(STCRouterOption *)options {
    if (!format) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNotProvidedInInitializedDomain code:STCRouterNotProvidedInInitialized userInfo:nil];
                self.routerForward(nil, error);
            }
            return;
        }
        @throw [NSException exceptionWithName:@"Route Not Provided"
                                       reason:@"Route format is not initialized"
                                     userInfo:nil];
        return;
    }
    if (!options) {
        options = [STCRouterOption routerOptions];
    }
    options.openClass = controllerClass;
    [self.routes setObject:options forKey:format];
}

- (BOOL)changeURLFormat:(NSString *)format
            toHybridUrl:(NSString *)hybridUrl
{
    if (!format) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNotProvidedInInitializedDomain code:STCRouterNotProvidedInInitialized userInfo:nil];
                self.routerForward(nil, error);
            }
            return NO;
        }
        @throw [NSException exceptionWithName:@"Route Not Provided"
                                       reason:@"Route format is not initialized"
                                     userInfo:nil];
        return NO;
    }
    
    STCRouterOption *options = [self.routes objectForKey:format];
    if (!options) {
        return NO;
    } else {
        options.hybridUrl = hybridUrl;
        return YES;
    }
}

- (BOOL)revertFromHybridWithURLFormat:(NSString *)format
{
    if (!format) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNotProvidedInInitializedDomain code:STCRouterNotProvidedInInitialized userInfo:nil];
                self.routerForward(nil, error);
            }
            return NO;
        }
        @throw [NSException exceptionWithName:@"Route Not Provided"
                                       reason:@"Route format is not initialized"
                                     userInfo:nil];
        return NO;
    }
    
    STCRouterOption *options = [self.routes objectForKey:format];
    if (!options) {
        return NO;
    } else {
        options.hybridUrl = nil;
        return YES;
    }
}

- (void)openExternalURL:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)openURL:(NSString *)url {
    [self openURL:url
     withAnimated:YES];
}

- (void)openURL:(NSString *)url
   withAnimated:(BOOL)animated {
    [self openURL:url
     withAnimated:animated
      extraParams:nil];
}

- (void)openURL:(NSString *)url
   withAnimated:(BOOL)animated
    extraParams:(NSDictionary *)extraParams {
    
    if (!self.appScheme) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterAppSchemeNotSetDomain code:STCRouterAppSchemeNotSet userInfo:nil];
                self.routerForward(nil, error);
            }
            return;
        }
        @throw [NSException exceptionWithName:@"App Scheme Not Set!"
                                       reason:@"Router app scheme has not been set"
                                     userInfo:nil];
    }
    
    STCRouterParams *params = [self routerParamsForUrl:url extraParams:extraParams];
    STCRouterOption *options = params.routerOptions;
    
    // 如果拦截，退出解析
    BOOL stop = self.routerHook(params, url);
    if (stop) {
        return;
    }

    // block回调
    if (options.callback) {
        STCRouterCallback callback = options.callback;
        callback([params controllerParams]);
        return;
    }
    
    if (![self.navigationControllers firstObject]) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNaviControllerNotProvidedDomain code:STCRouterNaviControllerNotProvided userInfo:nil];
                self.routerForward(params, error);
            }
            return;
        }
        @throw [NSException exceptionWithName:@"NavigationController Not Provided"
                                       reason:@"Router navigationController has not been set to a UINavigationController instance"
                                     userInfo:nil];
    }
    
    if ([params.scheme isEqualToString:self.appScheme] ||
        [params.scheme length] == 0) {
        
        UIViewController *controller = [self controllerForRouterParams:params];
        STCRouterParams *stackParams = [[STCRouterParams alloc] init];
        stackParams.routerOptions = [params.routerOptions copy];
        stackParams.routerOptions.defaultParams = nil;
        stackParams.extraParams = params.extraParams;
        stackParams.queryParams = params.queryParams;
        stackParams.scheme = params.scheme;
        
        NSArray *stackControllers = [self stackControllersForRouterParams:stackParams];
        UINavigationController *currentNavigationController = self.navigationControllers.firstObject;
        
        if (self.tabBarController) {
            NSUInteger currentIndex = options.rootIndex;
            if (currentIndex > self.navigationControllers.count - 1 && currentIndex != STC_CURRENT_INDEX) {
                if (_ignoresExceptions) {
                    if (self.routerForward) {
                        STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNaviControllerWithRootIndexNotProvidedDomain code:STCRouterNaviControllerWithRootIndexNotProvided userInfo:nil];
                        self.routerForward(params, error);
                    }
                    return;
                }
                @throw [NSException exceptionWithName:@"NavigationController with rootIndex NotProvided"
                                               reason:@"Router rootIndex has not been set to a UINavigationController instance"
                                             userInfo:nil];
            }
            
            if (currentIndex == STC_CURRENT_INDEX) {
                currentIndex = self.tabBarController.selectedIndex;
            }
            
            if (self.tabBarController.selectedIndex != currentIndex) {
                self.tabBarController.selectedIndex = currentIndex;
            }
            currentNavigationController = [self.navigationControllers objectAtIndex:currentIndex];
        }
        
        if (currentNavigationController.presentedViewController) {
            [currentNavigationController dismissViewControllerAnimated:animated completion:nil];
        }
        
        if ([options isModal]) {
            if (stackControllers.count > 0) {
                NSMutableArray *viewControllers = [NSMutableArray arrayWithArray: currentNavigationController.viewControllers];
                [viewControllers addObjectsFromArray:stackControllers];
                [currentNavigationController setViewControllers:viewControllers animated:animated];
            }
            if ([controller.class isSubclassOfClass:UINavigationController.class]) {
                [currentNavigationController presentViewController:controller
                                                          animated:animated
                                                        completion:nil];
            } else {
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
                navigationController.modalPresentationStyle = controller.modalPresentationStyle;
                navigationController.modalTransitionStyle = controller.modalTransitionStyle;
                [currentNavigationController presentViewController:navigationController
                                                          animated:animated
                                                        completion:nil];
            }
        } else if (options.shouldOpenAsRootViewController) {
            NSMutableArray *viewControllers = [NSMutableArray array];
            if (stackControllers.count > 0) {
                [viewControllers addObjectsFromArray:stackControllers];
            }
            [viewControllers addObject:controller];
            [currentNavigationController setViewControllers:viewControllers animated:animated];
        } else {
            if (stackControllers.count > 0) {
                NSMutableArray *viewControllers = [NSMutableArray arrayWithArray: currentNavigationController.viewControllers];
                [viewControllers addObjectsFromArray:stackControllers];
                [viewControllers addObject:controller];
                [currentNavigationController setViewControllers:viewControllers animated:animated];
            } else {
                [currentNavigationController pushViewController:controller animated:animated];
            }
        }
    } else {
        //其他类型的路由转发
        if (self.routerForward) {
            self.routerForward(params, nil);
        }
    }
}

- (NSDictionary*)paramsOfURL:(NSString*)url {
    return [[self routerParamsForUrl:url] controllerParams];
}

- (STCRouterParams *)routerParamsForUrl:(NSString *)url {
    return [self routerParamsForUrl:url
                        extraParams:nil];
}

- (STCRouterParams *)routerParamsForUrl:(NSString *)url
                            extraParams:(NSDictionary *)extraParams {
    
    void (^errorBlock)(void) = ^(){
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterNotFoundDomain code:STCRouterNotFound userInfo:nil];
                self.routerForward(nil, error);
            }
        }
        @throw [NSException exceptionWithName:@"Route Not Found Exception"
                                       reason:[NSString stringWithFormat:@"No route found for URL %@", url]
                                     userInfo:nil];
    };

    if (!url) {
        errorBlock();
        return nil;
    }
    
    if ([self.cachedRoutes objectForKey:url] && !extraParams) {
        return [self.cachedRoutes objectForKey:url];
    }
    STCRouterParams *openParams = [STCRouterParser routerParamsForUrl:url
                                                      withExtraParams:extraParams
                                                       registerRoutes:self.routes];
    if (!openParams) {
        errorBlock();
        return nil;
    }
    [self.cachedRoutes setObject:openParams forKey:url];
    return openParams;
}

- (UIViewController *)controllerForRouterParams:(STCRouterParams *)params {
    return [self controllerForRouterParams:params
                       withControllerClass:params.routerOptions.openClass];
}

- (NSArray *)stackControllersForRouterParams:(STCRouterParams *)params {
    NSMutableArray *stackControllers = [NSMutableArray array];
    NSInteger index = 0;
    for (Class controllerClass in params.routerOptions.stackClasses) {
        NSString *stackRoute = [params.routerOptions.stackRoutes objectAtIndex:index];
        STCRouterOption *option = [self.routes objectForKey:stackRoute];
        params.routerOptions.defaultParams = option.defaultParams;
        UIViewController *controller = [self controllerForRouterParams:params
                                                   withControllerClass:controllerClass];
        if (controller) {
            [stackControllers addObject:controller];
        }
        index ++;
    }
    return [NSArray arrayWithArray:stackControllers];
}

- (UIViewController *)controllerForRouterParams:(STCRouterParams *)params
                            withControllerClass:(Class)controllerClass {
    
    STCRouterOption *options = params.routerOptions;
    
    if ([options.hybridUrl length] > 0) {
        controllerClass = NSClassFromString(self.webControllerClassName);
        if (!controllerClass) {
            if (_ignoresExceptions) {
                if (self.routerForward) {
                    STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterWebControllerClassInitializerNotSetDomain code:STCRouterWebControllerClassInitializerNotSet userInfo:nil];
                    self.routerForward(params, error);
                }
                return nil;
            }
            @throw [NSException exceptionWithName:@"STCRouter webController Not set"
                                           reason:@"Your web controller have not set!"
                                         userInfo:nil];
        }
    }
    
    SEL class_SEL = sel_registerName("allocWithRouterParams:");
    SEL instance_SEL = sel_registerName("initWithRouterParams:");
    UIViewController *controller = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([controllerClass respondsToSelector:class_SEL]) {
        controller = [controllerClass performSelector:class_SEL withObject:[params controllerParams]];
    }else if ([controllerClass instancesRespondToSelector:instance_SEL]) {
        controller = [[controllerClass alloc] performSelector:instance_SEL withObject:[params controllerParams]];
    }
    
    if (controller && [options.hybridUrl length] > 0) {
        SEL setUrl_SEL = sel_registerName("setUrl:");
        if ([controller respondsToSelector:setUrl_SEL]) {
            [controller performSelector:setUrl_SEL withObject:options.hybridUrl];
        }
    }
#pragma clang diagnostic pop
    if (!controller) {
        if (_ignoresExceptions) {
            if (self.routerForward) {
                STCRouterError *error = [[STCRouterError alloc] initWithDomain:STCRouterControllerClassInitializerNotFoundDomain code:STCRouterControllerClassInitializerNotFound userInfo:nil];
                self.routerForward(params, error);
            }
            return controller;
        }
        @throw [NSException exceptionWithName:@"STCRouter Initializer Not Found"
                                       reason:[NSString stringWithFormat:@"Your controller class %@ needs to implement either the static method %@ or the instance method %@", NSStringFromClass(controllerClass), NSStringFromSelector(class_SEL),  NSStringFromSelector(instance_SEL)]
                                     userInfo:nil];
    }
    
    controller.modalTransitionStyle = params.routerOptions.transitionStyle;
    controller.modalPresentationStyle = params.routerOptions.presentationStyle;
    return controller;
    
}
@end
