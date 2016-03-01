//
//  ViewController.h
//  PMG
//
//  Created by Prashant on 23/09/15.
//  Copyright © 2015 Prashant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

{
    CLLocationManager *locationManager;
}
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) IBOutlet UITextField *txtSearch;
@property (nonatomic,strong) IBOutlet UITableView *tblNearbylist;
@property (nonatomic,strong) NSMutableArray *arrFetchdata;
@end

