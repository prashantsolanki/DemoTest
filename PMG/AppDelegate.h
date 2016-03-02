//
//  AppDelegate.h
//  Created by Prashant.
//  Copyright © 2016 Prashant. All rights reserved.
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

