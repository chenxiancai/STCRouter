//
//  STCRouterProtocol.h
//  STCRouter
//
//  Created by chenxiancai on 25/10/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//


@protocol STCRouterProtocol<NSObject>

- (id)initWithRouterParams:(NSDictionary *)params;
+ (id)allocWithRouterParams:(NSDictionary *)params;

@optional
- (void)setUrl:(NSString *)url;

@end
