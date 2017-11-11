//
//  STCRouterFilter.m
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "STCRouterFilter.h"

@interface STCRouterFilter ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *whiteList;
@property (nonatomic, strong) NSMutableArray<NSString *> *blackList;

@end

@implementation STCRouterFilter

- (BOOL)filterRouterWithUrl:(NSString *)url BID:(NSString *)BID
{
    if (!url || !BID) {
        return YES;
    }
    __block BOOL isFilter = NO;
    
    // filter blackList
    [self.blackList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:BID]) {
            isFilter = YES;
            *stop = YES;
        }
    }];
    
    if (isFilter) {
        return isFilter;
    }
    
    // filter whiteList
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    NSString *path = components.path;
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    NSArray *paths = [path componentsSeparatedByString:@"/"];
    for (path in paths) {
        NSMutableArray *BIDs = [self.whiteList objectForKey:path];
        if (BIDs.count > 0) {
            isFilter = YES;
            [BIDs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:BID]) {
                    isFilter = NO;
                    *stop = YES;
                }
            }];
        }
        if (isFilter == YES) {
            break;
        }
    }
    
    return isFilter;
}

- (void)addBlackListWithObjects:(NSArray<NSString *> *)objects
{
    if (!_blackList) {
        _blackList = [[NSMutableArray alloc] init];
    }
    [self.blackList addObjectsFromArray:objects];
}

- (void)removeBlackListWithObjects:(NSArray<NSString *> *)objects
{
    NSMutableArray *removeObjects = [NSMutableArray arrayWithCapacity:objects.count];
    for (NSString *object in objects) {
        [self.blackList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:object]) {
                [removeObjects addObject:obj];
                *stop = YES;
            }
        }];
    }
    [self.blackList removeObjectsInArray:removeObjects];
}

- (void)addWhiteListWithPath:(NSString *)path BIDs:(NSArray *)BIDs
{
    if (!_whiteList) {
        _whiteList = [[NSMutableDictionary alloc] init];
    }
    if (path && BIDs) {
        NSMutableArray *exitBIDs = [self.whiteList objectForKey:path];
        if (!exitBIDs) {
            exitBIDs = [NSMutableArray array];
            [exitBIDs addObjectsFromArray:[BIDs mutableCopy]];
            [self.whiteList addEntriesFromDictionary:@{path: exitBIDs}];
        } else {
            [exitBIDs addObjectsFromArray:[BIDs mutableCopy]];
        }
    }
}

- (void)removeWhiteListWithPath:(NSString *)path BID:(NSString *)BID
{
    if (path && BID) {
        NSMutableArray *BIDs = [self.whiteList objectForKey:path];
        if (BIDs) {
            for (NSString *bid in BIDs) {
                if ([bid isEqualToString:BID]) {
                    [BIDs removeObject:bid];
                }
            }
        }
    }
}

@end
