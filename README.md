# STCRouter

### how to use
`
pod 'STCRouter'
`

### stander URL format
`
http:\\host[:port][abs_path][:parameters][?query]#fragment
`

### example 
`

1、Use STCRouterCenter to register URL format for controller with params, like this:

[[STCRouterCenter defaultCenter].router  registerURLFormat:@"router:///root" toController:[ModalController class] withOptions:[[[STCRouterOption routerOptions] rootIndex:0] forDefaultParams:@{@"title": @"root"}]];

2、Setup blackList or whiteList, like this:

// 设置路由黑名单
[[STCRouterCenter defaultCenter] addBlackListWithObjects:@[@"com.apple.mobilesafari"]];
// 设置路由白名单
[[STCRouterCenter defaultCenter] addWhiteListInPathWithBIDs:@{@"root": @[@""]}];
[[STCRouterCenter defaultCenter] addWhiteListInPathWithBIDs:@{@"child": @[@"com.stevchen.STCRouter"]}];

3、handle undefinded route, like this: 

[[STCRouterCenter defaultCenter].router setRouterForward:^(STCRouterParams *routerParams, STCRouterError *error) {
      //handle undefinded route
}];
 
4、open route, like this:

[[STCRouterCenter defaultCenter].router openURL:@"/child/user/child/user" withAnimated:YES extraParams:nil];

or 

[[STCRouterCenter defaultCenter].router openURL:@"router:///child?title=newChild"];

5、intercept route, like this:

 NSString *sourceApplication = [options valueForKey:UIApplicationOpenURLOptionsSourceApplicationKey];
 BOOL isFilter = [[STCRouterCenter defaultCenter] filterRouterWithUrl:url.absoluteString BID:sourceApplication];
 if (!isFilter) {
        [[STCRouterCenter defaultCenter].router openURL:url.absoluteString withAnimated:YES extraParams:nil];
 }
 
`
