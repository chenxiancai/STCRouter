//
//  STCViewController.h
//  STCRouter
//
//  Created by chenxiancai on 24/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCRouterProtocol.h"

@interface STCViewController : UIViewController<STCRouterProtocol>

- (instancetype)init NS_UNAVAILABLE;
- (id)initWithRouterParams:(NSDictionary *)params;
+ (id)allocWithRouterParams:(NSDictionary *)params;

@end
