//
//  AppDelegate.m
//  ronchi
//
//  Created by Pratik Tambe on 3/14/19.
//  Copyright © 2019 Pratik Tambe. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //grab storyboard depending on the screen height
    UIStoryboard *storyboard = [self grabStoryBoard];
    
    // display storyboard
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIStoryboard *) grabStoryBoard {
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIStoryboard * storyboard;
    switch (screenHeight) {
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main_480" bundle:nil];
            break;
            
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main_568" bundle:nil];
            break;
            
        case 667:
            storyboard = [UIStoryboard storyboardWithName:@"Main_667" bundle:nil];
            break;
            
        case 736:
            storyboard = [UIStoryboard storyboardWithName:@"Main_736" bundle:nil];
            break;
            
        case 812:
            storyboard = [UIStoryboard storyboardWithName:@"Main_812" bundle:nil];
            break;
            
        case 896:
            storyboard = [UIStoryboard storyboardWithName:@"Main_896" bundle:nil];
            break;
            
        default:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
    }
    
    return storyboard;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
