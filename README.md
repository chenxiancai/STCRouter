# STCRouter

### how to use
```
pod 'STCRouter'
```

### stander URL format
```
http:\\host[:port][abs_path][:parameters][?query]#fragment
```

### example 
```
1.Use STCRouterCenter to register URL format for controller with params, like this:

[[STCRouterCenter defaultCenter].router  registerURLFormat:@"router:///root" 
toController:[ModalController class] withOptions:[[[STCRouterOption routerOptions] rootIndex:0] 
forDefaultParams:@{@"title": @"root"}]];

2.Setup blackList or whiteList, like this:

// 设置路由黑名单
[[STCRouterCenter defaultCenter] addBlackListWithObjects:@[@"com.apple.mobilesafari"]];

// 设置路由白名单
[[STCRouterCenter defaultCenter] addWhiteListInPathWithBIDs:@{@"root": @[@""]}];
[[STCRouterCenter defaultCenter] addWhiteListInPathWithBIDs:@{@"child": @[@"com.stevchen.STCRouter"]}];

Attention:
so, if you add a bundleId into blackList, app with this bundleId cann't open any path in router.
If you add route path with bundleId into whiteList, only app with bundleId in whiteList can open the route.

3.handle undefinded route, like this: 

[[STCRouterCenter defaultCenter].router setRouterForward:^(STCRouterParams *routerParams, STCRouterError *error) {
      //handle undefinded route
}];
 
4.open route, like this:

inside app without scheme

[[STCRouterCenter defaultCenter].router openURL:@"/child/user/child/user" withAnimated:YES extraParams:nil];

or outside app with scheme

[[STCRouterCenter defaultCenter].router openExternalURL:@"router:///root"];

or with stack controllers

[[STCRouterCenter defaultCenter].router openURL:@"router:///user/child/root"];

5.intercept route, like this:

 NSString *sourceApplication = [options valueForKey:UIApplicationOpenURLOptionsSourceApplicationKey];
 BOOL isFilter = [[STCRouterCenter defaultCenter] filterRouterWithUrl:url.absoluteString BID:sourceApplication];
 if (!isFilter) {
        [[STCRouterCenter defaultCenter].router openURL:url.absoluteString withAnimated:YES extraParams:nil];
 }
 
 6.set route from native to hybird, like this:
 [[STCRouterCenter defaultCenter].router changeURLFormat:@"router:///child" toHybridUrl:@"http://www.baidu.com"];
  
 you can revert it to native route:
 
 [[STCRouterCenter defaultCenter].router revertFromHybridWithURLFormat:@"router:///child"];

```
