//
//  AppDelegate.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/14/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "AppDelegate.h"
#import "ProductsTableViewController.h"

#import "PAYTPV/PAYTPV.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // TODO: - Replace with your test credentials
    PTPVConfiguration *config = [[PTPVConfiguration alloc] initWithMerchantCode:@""
                                                                       terminal:@""
                                                                       password:@""
                                                                          jetId:@""];
    [[PTPVAPIClient sharedClient] setConfiguration:config];

    ProductsTableViewController *root = [ProductsTableViewController new];
    UINavigationController *navigationController;
    navigationController = [[UINavigationController alloc] initWithRootViewController:root];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
