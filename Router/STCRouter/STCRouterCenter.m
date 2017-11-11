//
//  STCRouterCenter.m
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import "STCRouterCenter.h"
#import "STCRouterFilter.h"

@interface STCRouterCenter ()

@property (nonatomic, strong, readwrite) STCRouter *router;
@property (nonatomic, strong) STCRouterFilter *routerFilter;

@end

@implementation STCRouterCenter

+ (instancetype)defaultCenter
{
    static STCRouterCenter *_defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultCenter = [[STCRouterCenter alloc] init];
    });
    return _defaultCenter;
}

- (STCRouter *)router
{
    if (!_router) {
        _router = [[STCRouter alloc] init];
    }
    return _router;
}

- (STCRouterFilter *)routerFilter
{
    if (!_routerFilter) {
        _routerFilter = [[STCRouterFilter alloc] init];
    }
    return _routerFilter;
}

- (void)addBlackListWithObjects:(NSArray<NSString *> *)objects
{
    [self.routerFilter addBlackListWithObjects:objects];
}

- (void)addWhiteListInPathWithBIDs:(NSDictionary<NSString *, NSArray *> *)dict
{
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray * _Nonnull obj, BOOL * _Nonnull stop) {
        [self.routerFilter addWhiteListWithPath:key BIDs:obj];
    }];
}

- (BOOL)filterRouterWithUrl:(NSString *)url BID:(NSString *)BID
{
    return [self.routerFilter filterRouterWithUrl:url BID:BID];
}

@end
