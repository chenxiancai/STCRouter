//
//  STCRouterOption.m
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import "STCRouterOption.h"

@implementation STCRouterOption

+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)presentationStyle
                                   transitionStyle:(UIModalTransitionStyle)transitionStyle
                                     defaultParams:(NSDictionary *)defaultParams
                                            isRoot:(BOOL)isRoot
                                           isModal:(BOOL)isModal
                                         rootIndex:(NSUInteger)rootIndex {
    STCRouterOption *options = [[STCRouterOption alloc] init];
    options.presentationStyle = presentationStyle;
    options.transitionStyle = transitionStyle;
    options.defaultParams = defaultParams;
    options.shouldOpenAsRootViewController = isRoot;
    options.modal = isModal;
    options.rootIndex = rootIndex;
    return options;
}

+ (instancetype)routerOptions {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO
                                          rootIndex:STC_CURRENT_INDEX];
}

+ (instancetype)routerOptionsAsModal {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:YES
                                          rootIndex:STC_CURRENT_INDEX];
}

+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style {
    return [self routerOptionsWithPresentationStyle:style
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO
                                          rootIndex:STC_CURRENT_INDEX];
}

+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:style
                                      defaultParams:nil
                                             isRoot:NO
                                            isModal:NO
                                          rootIndex:STC_CURRENT_INDEX];
}

+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:defaultParams
                                             isRoot:NO
                                            isModal:NO
                                          rootIndex:STC_CURRENT_INDEX];
}

+ (instancetype)routerOptionsAsRootWithIndex:(NSUInteger)rootIndex {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                             isRoot:YES
                                            isModal:NO
                                          rootIndex:rootIndex];
}

+ (instancetype)modal {
    return [self routerOptionsAsModal];
}

+ (instancetype)withPresentationStyle:(UIModalPresentationStyle)style {
    return [self routerOptionsWithPresentationStyle:style];
}

+ (instancetype)withTransitionStyle:(UIModalTransitionStyle)style {
    return [self routerOptionsWithTransitionStyle:style];
}

+ (instancetype)forDefaultParams:(NSDictionary *)defaultParams {
    return [self routerOptionsForDefaultParams:defaultParams];
}

+ (instancetype)rootWithIndex:(NSUInteger)rootIndex {
    return [self routerOptionsAsRootWithIndex:rootIndex];
}

- (STCRouterOption *)modal {
    [self setModal:YES];
    return self;
}

- (STCRouterOption *)withPresentationStyle:(UIModalPresentationStyle)style {
    [self setPresentationStyle:style];
    return self;
}

- (STCRouterOption *)withTransitionStyle:(UIModalTransitionStyle)style {
    [self setTransitionStyle:style];
    return self;
}

- (STCRouterOption *)forDefaultParams:(NSDictionary *)defaultParams {
    [self setDefaultParams:defaultParams];
    return self;
}

- (STCRouterOption *)root {
    [self setShouldOpenAsRootViewController:YES];
    return self;
}

- (STCRouterOption *)rootIndex:(NSUInteger)index {
    [self setRootIndex:index];
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    STCRouterOption *option = [[STCRouterOption allocWithZone:zone] init];
    option.openClass = _openClass;
    option.stackClasses = [NSArray arrayWithArray:_stackClasses];
    option.stackRoutes = [NSArray arrayWithArray:_stackRoutes];
    option.callback = [_callback copy];
    option.modal = _modal;
    option.presentationStyle = _presentationStyle;
    option.transitionStyle = _transitionStyle;
    option.defaultParams = [NSDictionary dictionaryWithDictionary:_defaultParams];
    option.shouldOpenAsRootViewController = _shouldOpenAsRootViewController;
    option.rootIndex = _rootIndex;
    return option;
}

@end
