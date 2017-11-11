//
//  STCRouterParser.m
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import "STCRouterParser.h"

@implementation STCRouterParser

+ (STCRouterParams *)routerParamsForUrl:(NSString *)url
                        withExtraParams:(NSDictionary *)extraParams
                         registerRoutes:(NSDictionary *)routes {
    if (!url) {
        return nil;
    }

    // url parse
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    NSString *path = components.path;
    NSString *scheme = components.scheme;
    
    NSArray *queryItems = components.queryItems;
    NSMutableDictionary *queryParams= [NSMutableDictionary dictionary];
    for (NSURLQueryItem *item in queryItems) {
        if (item.name && item.value) {
            [queryParams addEntriesFromDictionary:@{item.name: item.value}];
        }
    }
    
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    NSArray *givenParts = path.pathComponents;
    NSArray *legacyParts = [path componentsSeparatedByString:@"/"];
    if ([legacyParts count] != [givenParts count]) {
        NSLog(@"STCRouter Warning - your URL %@ has empty path components", url);
        givenParts = legacyParts;
    }
    
    __block STCRouterParams *routerParams = nil;
    if (givenParts.count == 1) {
        [routes enumerateKeysAndObjectsUsingBlock:^(NSString *routerUrl, STCRouterOption *routerOptions, BOOL *stop) {
            NSURLComponents *components = [NSURLComponents componentsWithString:routerUrl];
            NSString *path = components.path;
            if ([path hasPrefix:@"/"]) {
                path = [path substringFromIndex:1];
            }
            NSArray *routerParts = [path pathComponents];
            if ([[routerParts firstObject] isEqualToString:[givenParts firstObject]]) {
                routerParams = [[STCRouterParams alloc] initWithRouterOptions:routerOptions
                                                                  extraParams:extraParams
                                                                  queryParams:queryParams];
                routerParams.scheme = scheme;
                *stop = YES;
            }
        }];
    } else {
        NSMutableDictionary *stackClassesDict = [NSMutableDictionary dictionaryWithCapacity:givenParts.count - 1];
        NSMutableDictionary *stackRoutesDict = [NSMutableDictionary dictionaryWithCapacity:givenParts.count - 1];
        [routes enumerateKeysAndObjectsUsingBlock:^(NSString *routerUrl, STCRouterOption *routerOptions, BOOL *stop) {
            NSURLComponents *components = [NSURLComponents componentsWithString:routerUrl];
            NSString *path = components.path;
            if ([path hasPrefix:@"/"]) {
                path = [path substringFromIndex:1];
            }
            NSArray *routerParts = [path pathComponents];
            if ([[routerParts firstObject] isEqualToString:[givenParts lastObject]]) {
                routerParams = [[STCRouterParams alloc] initWithRouterOptions:[routerOptions copy]
                                                                  extraParams:extraParams
                                                                  queryParams:queryParams];
                routerParams.scheme = scheme;
            } else {
                [givenParts enumerateObjectsUsingBlock:^(NSString *givenPath, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == givenParts.count - 1) {
                        *stop = YES;
                    }
                    if ([[routerParts firstObject] isEqualToString:givenPath]) {
                        if (routerOptions.openClass) {
                            [stackClassesDict addEntriesFromDictionary:@{@(idx): routerOptions.openClass}];
                            [stackRoutesDict addEntriesFromDictionary:@{@(idx): routerUrl}];
                        }
                    }
                }];
            }
            
            if ([stackClassesDict count] == givenParts.count - 1 && routerParams) {
                NSMutableArray *stackClasses = [NSMutableArray arrayWithCapacity:givenParts.count - 1];
                NSMutableArray *stackRoutes = [NSMutableArray arrayWithCapacity:givenParts.count - 1];

                for (NSInteger index = 0; index < givenParts.count - 1; index ++) {
                    if ([stackClassesDict objectForKey:@(index)]) {
                        [stackClasses addObject:[stackClassesDict objectForKey:@(index)]];
                        [stackRoutes addObject:[stackRoutesDict objectForKey:@(index)]];
                    }
                }
                routerParams.routerOptions.stackClasses = [NSArray arrayWithArray:stackClasses];
                routerParams.routerOptions.stackRoutes = [NSArray arrayWithArray:stackRoutes];
                *stop = YES;
            }
        }];
    }
    return routerParams;
}

@end
