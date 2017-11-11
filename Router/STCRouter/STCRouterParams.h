//
//  STCRouterParams.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCRouterOption.h"

@interface STCRouterParams : NSObject

@property (readwrite, nonatomic, strong) STCRouterOption *routerOptions;
@property (readwrite, nonatomic, strong) NSDictionary *extraParams;
@property (readwrite, nonatomic, strong) NSDictionary *queryParams;
@property (readwrite, nonatomic, strong) NSDictionary *controllerParams;
@property (readwrite, nonatomic, strong) NSString *scheme;

- (instancetype)initWithRouterOptions:(STCRouterOption *)routerOptions
                          extraParams:(NSDictionary *)extraParams
                          queryParams:(NSDictionary *)queryParams;
@end
