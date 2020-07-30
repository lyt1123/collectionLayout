//
//  AppDelegate.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/27.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController alloc]];
    
    self.window.rootViewController = nav;
    
    return YES;
}

@end
