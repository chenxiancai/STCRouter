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
Use STCRouterCenter to register URL format for controller with params, like this:

 [[STCRouterCenter defaultCenter].router  registerURLFormat:@"router:///root" toController:[ModalController class] withOptions:[[[STCRouterOption routerOptions] rootIndex:0] forDefaultParams:@{@"title": @"root"}]];
 
`
