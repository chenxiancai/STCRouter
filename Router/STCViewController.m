//
//  STCViewController.m
//  STCRouter
//
//  Created by chenxiancai on 24/10/2017.
//  Copyright © 2017 stevchen All rights reserved.
//

#import "STCViewController.h"

@interface STCViewController ()

@property (nonatomic, strong) NSDictionary *params;

@end

@implementation STCViewController

- (id)initWithRouterParams:(NSDictionary *)params
{
    if ((self = [self initWithNibName:nil bundle:nil])) {
        self.params = params;
    }
    return self;
}

+ (id)allocWithRouterParams:(NSDictionary *)params
{
    return [[[self class] alloc] initWithRouterParams:params];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [self.params objectForKey:@"title"];
}

@end
