//
//  STCRouterParams.m
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import "STCRouterParams.h"

@implementation STCRouterParams

- (instancetype)initWithRouterOptions:(STCRouterOption *)routerOptions
                          extraParams:(NSDictionary *)extraParams
                          queryParams:(NSDictionary *)queryParams {
    [self setRouterOptions:routerOptions];
    [self setExtraParams:extraParams];
    [self setQueryParams:queryParams];
    return self;
}

- (NSDictionary *)controllerParams {
    NSMutableDictionary *controllerParams = [NSMutableDictionary dictionaryWithDictionary:self.routerOptions.defaultParams];
    [controllerParams addEntriesFromDictionary:self.extraParams];
    [controllerParams addEntriesFromDictionary:self.queryParams];
    return controllerParams;
}

@end
