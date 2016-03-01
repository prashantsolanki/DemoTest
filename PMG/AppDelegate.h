//
//  AppDelegate.h
//  PMG
//
//  Created by Prashant on 23/09/15.
//  Copyright © 2015 Prashant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic,strong) IBOutlet ViewController *viewController;
@property (nonatomic, strong) UINavigationController *navController;

@end

