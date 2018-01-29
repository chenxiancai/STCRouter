//
//  AppDelegate.m
//  STCRouter
//
//  Created by chenxiancai on 6/7/11.
//  Copyright (c) 2015 stevchen All rights reserved.
//

#import "AppDelegate.h"
#import "STCRouterCenter.h"
#import "STCViewController.h"
#import "STCNavigationController.h"
#import "STCTabBarController.h"
#import "STCWebViewController.h"

@interface UserController : STCViewController

@end

@implementation UserController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIButton *modal = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [modal setTitle:@"Modal" forState:UIControlStateNormal];
  [modal addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
  [modal sizeToFit];
  [modal setFrame:CGRectMake((self.view.bounds.size.width - modal.frame.size.width)/2, self.view.bounds.size.height/2, modal.frame.size.width, modal.frame.size.height)];

  [self.view addSubview:modal];
}

- (void)tapped:(id)sender {
    //测试内部路径带参数跳转
    [[STCRouterCenter defaultCenter].router openURL:@"router:///modal?&title=justModal"];
}

@end

@interface ChildController : STCViewController

@end

@implementation ChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *modal = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [modal setTitle:@"Root" forState:UIControlStateNormal];
    [modal addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [modal sizeToFit];
    [modal setFrame:CGRectMake((self.view.bounds.size.width - modal.frame.size.width)/2, self.view.bounds.size.height/2, modal.frame.size.width, modal.frame.size.height)];
    
    [self.view addSubview:modal];
}

- (void)tapped:(id)sender {
    //测试内部路径多级跳转
    [[STCRouterCenter defaultCenter].router openURL:@"router:///user/child/root"];
}

@end

@interface ModalController : STCViewController

@end

@implementation ModalController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *external1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [external1 setTitle:@"in white list" forState:UIControlStateNormal];
    [external1 addTarget:self action:@selector(external1:) forControlEvents:UIControlEventTouchUpInside];
    [external1 sizeToFit];
    [external1 setFrame:CGRectMake(0, self.view.bounds.size.height/2 - 50, external1.frame.size.width, external1.frame.size.height)];
    [self.view addSubview:external1];
    
    UIButton *external2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [external2 setTitle:@"not in white list" forState:UIControlStateNormal];
    [external2 addTarget:self action:@selector(external2:) forControlEvents:UIControlEventTouchUpInside];
    [external2 sizeToFit];
    [external2 setFrame:CGRectMake(0, self.view.bounds.size.height/2 + 50, external2.frame.size.width, external2.frame.size.height)];
    [self.view addSubview:external2];

    UIButton *user = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [user setTitle:@"User" forState:UIControlStateNormal];
    [user addTarget:self action:@selector(tappedUser:) forControlEvents:UIControlEventTouchUpInside];
    [user sizeToFit];
    [user setFrame:CGRectMake(self.view.bounds.size.width - user.frame.size.width, self.view.bounds.size.height/2, user.frame.size.width, user.frame.size.height)];

    [self.view addSubview:user];

    UIButton *child = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [child setTitle:@"Child" forState:UIControlStateNormal];
    [child addTarget:self action:@selector(tappedChild:) forControlEvents:UIControlEventTouchUpInside];
    [child sizeToFit];
    [child setFrame:CGRectMake((self.view.bounds.size.width - child.frame.size.width)/2, self.view.bounds.size.height/2, child.frame.size.width, child.frame.size.height)];

    [self.view addSubview:child];
    
    
    UIButton *hybri = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [hybri setTitle:@"hybri" forState:UIControlStateNormal];
    [hybri addTarget:self action:@selector(tappedHybri:) forControlEvents:UIControlEventTouchUpInside];
    [hybri sizeToFit];
    [hybri setFrame:CGRectMake((self.view.bounds.size.width - hybri.frame.size.width)/2, self.view.bounds.size.height/2 + hybri.frame.size.height, hybri.frame.size.width, hybri.frame.size.height)];
    
    [self.view addSubview:hybri];
    
    
    UIButton *native = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [native setTitle:@"native" forState:UIControlStateNormal];
    [native addTarget:self action:@selector(tappedNative:) forControlEvents:UIControlEventTouchUpInside];
    [native sizeToFit];
    [native setFrame:CGRectMake((self.view.bounds.size.width - native.frame.size.width)/2, self.view.bounds.size.height/2 + native.frame.size.height + hybri.frame.size.height, native.frame.size.width, native.frame.size.height)];
    
    [self.view addSubview:native];
}

- (void)external1:(id)sender {
    // 测试白名单
    [[STCRouterCenter defaultCenter].router openExternalURL:@"router:///child"];
}

- (void)external2:(id)sender {
    // 测试白名单
    [[STCRouterCenter defaultCenter].router openExternalURL:@"router:///root"];
}

- (void)tappedChild:(id)sender {
    //测试内部路径带参数跳转
    [[STCRouterCenter defaultCenter].router openURL:@"router:///child?title=newChild"];
}

- (void)tappedUser:(id)sender {
    //测试内部路径带参数跳转
    [[STCRouterCenter defaultCenter].router openURL:@"router:///root?title=stackRoot"];
}

- (void)tappedHybri:(id)sender {
    // native 降级到 hybrid
    [[STCRouterCenter defaultCenter].router changeURLFormat:@"router:///child" toHybridUrl:@"http://www.baidu.com"];
}

- (void)tappedNative:(id)sender {
    // hybrid 还原到 native
    [[STCRouterCenter defaultCenter].router revertFromHybridWithURLFormat:@"router:///child"];
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    STCTabBarController *tabbar = [[STCTabBarController alloc] init];
    UITabBarItem *item1 =[[UITabBarItem alloc] initWithTitle:@"1" image:nil selectedImage:nil];
    UserController *vc1 = [[UserController alloc] initWithRouterParams:@{@"title": @"tab1"}];
    STCNavigationController *navi1= [[STCNavigationController alloc] initWithRootViewController:vc1];
    navi1.tabBarItem = item1;
    [tabbar addChildViewController:navi1];
    
    UITabBarItem *item2 =[[UITabBarItem alloc] initWithTitle:@"2" image:nil selectedImage:nil];
    STCNavigationController *navi2= [[STCNavigationController alloc] initWithRootViewController:[[UserController alloc] initWithRouterParams:@{@"title": @"tab2"}]];
    navi2.tabBarItem = item2;
    [tabbar addChildViewController:navi2];

    UITabBarItem *item3 =[[UITabBarItem alloc] initWithTitle:@"3" image:nil selectedImage:nil];
    STCNavigationController *navi3= [[STCNavigationController alloc] initWithRootViewController:[[UserController alloc] initWithRouterParams:@{@"title": @"tab3"}]];
    navi3.tabBarItem = item3;
    [tabbar addChildViewController:navi3];
    
    // 路由注册
    [[STCRouterCenter defaultCenter].router  registerURLFormat:@"router:///root" toController:[ModalController class] withOptions:[[[STCRouterOption routerOptions] rootIndex:0] forDefaultParams:@{@"title": @"root"}]];
    [[STCRouterCenter defaultCenter].router registerURLFormat:@"router:///user" toController:[UserController class] withOptions:[[[STCRouterOption routerOptions] rootIndex:2] forDefaultParams:@{@"title": @"user"}]];
    [[STCRouterCenter defaultCenter].router registerURLFormat:@"router:///child" toController:[ChildController class] withOptions:[[[STCRouterOption routerOptions] rootIndex:2] forDefaultParams:@{@"title": @"child"}]];
    [[STCRouterCenter defaultCenter].router  registerURLFormat:@"router:///modal" toController:[ModalController class] withOptions:[[[STCRouterOption modal] withPresentationStyle:UIModalPresentationFormSheet] forDefaultParams:@{@"title":@"modal"}]];
    
    // 路由配置
    [[STCRouterCenter defaultCenter].router setAppScheme:@"router"];
    [[STCRouterCenter defaultCenter].router setWebControllerClassName:NSStringFromClass([STCWebViewController class])];
    [[STCRouterCenter defaultCenter].router setNavigationControllers:@[navi1, navi2, navi3]];
    [[STCRouterCenter defaultCenter].router setTabBarController:tabbar];
#if DEBUG
    [[STCRouterCenter defaultCenter].router setIgnoresExceptions:NO];
#else
    [[STCRouterCenter defaultCenter].router setIgnoresExceptions:YES];
#endif
    
    // 设置路由黑名单
    [[STCRouterCenter defaultCenter] addBlackListWithObjects:@[@"com.apple.mobilesafari"]];
    // 设置路由白名单
    [[STCRouterCenter defaultCenter] addWhiteListInPathWithBIDs:@{@"root": @[@""]}];
    [[STCRouterCenter defaultCenter] addWhiteListInPathWithBIDs:@{@"child": @[@"com.stevchen.STCRouter"]}];
    
    [[STCRouterCenter defaultCenter].router setRouterForward:^(STCRouterParams *routerParams, STCRouterError *error) {
        NSLog(@"STCRouterError: %@", error);
    }];

    [self.window setRootViewController:tabbar];
    [self.window makeKeyAndVisible];

    // 测试内部路径跳转
    [[STCRouterCenter defaultCenter].router openURL:@"/child/user" withAnimated:YES extraParams:nil];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return NO;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(id)annotation
{
    NSLog(@"sourceApplication: %@", sourceApplication);
    BOOL isFilter = [[STCRouterCenter defaultCenter] filterRouterWithUrl:url.absoluteString BID:sourceApplication];
    if (!isFilter) {
        [[STCRouterCenter defaultCenter].router openURL:url.absoluteString withAnimated:YES extraParams:nil];
    }
    return isFilter;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    NSLog(@"options: %@", options);
    NSString *sourceApplication = [options valueForKey:UIApplicationOpenURLOptionsSourceApplicationKey];
    BOOL isFilter = [[STCRouterCenter defaultCenter] filterRouterWithUrl:url.absoluteString BID:sourceApplication];
    if (!isFilter) {
        [[STCRouterCenter defaultCenter].router openURL:url.absoluteString withAnimated:YES extraParams:nil];
    }
    return isFilter;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
