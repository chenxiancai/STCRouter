//
//  STCRouterError.m
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "STCRouterError.h"

NSErrorDomain const STCRouterNaviControllerNotProvidedDomain = @"NavigationController not provided in STCRouter";
NSErrorDomain const STCRouterNaviControllerWithRootIndexNotProvidedDomain = @"NavigationController with rootIndex not provided in STCRouter";
NSErrorDomain const STCRouterNotProvidedInInitializedDomain = @"Route not provided in initialized when register URL format";
NSErrorDomain const STCRouterAppSchemeNotSetDomain = @"App scheme not set in STCRouter";
NSErrorDomain const STCRouterNotFoundDomain = @"Route not found";
NSErrorDomain const STCRouterControllerClassInitializerNotFoundDomain = @"Controller class Initializer not found for STCRouter";
NSErrorDomain const STCRouterWebControllerClassInitializerNotSetDomain = @"Web Controller class not set for STCRouter";

@implementation STCRouterError

@end
