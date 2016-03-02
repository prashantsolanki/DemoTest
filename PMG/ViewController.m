//
//  ViewController.m
//  Created by Prashant.
//  Copyright © 2016 Prashant. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"
#import "Place.h"
#import "LocationCell.h"
#import <RestKit/RestKit.h>


#define fsClientID "AVNXSCIFMPTYVEEWMMTMCA5PYBSIG53204WAWWJVSDDKTF1J"
#define fsClientkey "G012Q05SQ4XWW3WQI25IUB5DYJOKEQ5HQEP4XR4AR1HRWE03"

@interface ViewController (){
    RKObjectManager *objectManager;
}

@end

@implementation ViewController
@synthesize txtSearch,tblNearbylist,arrFetchdata,locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    arrFetchdata = [[NSMutableArray alloc]init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 5;
    return arrFetchdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
//    Location *loc = arrFetchdata[indexPath.row];
    Place *place = arrFetchdata[indexPath.row];
    
    cell.lblName.text = place.name;
    cell.lblAddress.text = place.location.address;
    cell.lblDistance.text = place.location.distance.description;
    
    return cell;
}

-(IBAction)searchButtonClick:(id)sender
{
    [self searchNearMe:txtSearch.text];
}
-(void)searchNearMe:(NSString *)strSearch
{
    NSLog(@"SearchValue is %@",txtSearch.text);
   
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Place class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    // define location object mapping
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    // define relationship mapping
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:venueMapping method:RKRequestMethodGET pathPattern:@"/v2/venues/search" keyPath:@"response.venues" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [self LoadnearbyPlacesData];
    
}

-(void)LoadnearbyPlacesData
{
    [locationManager requestAlwaysAuthorization];
    float Lat = locationManager.location.coordinate.latitude;
    float Long = locationManager.location.coordinate.longitude;
    NSLog(@"Lat : %f  Long : %f",Lat,Long);
    
//    NSString *latLon = @"55.63,12.65"; // approximate latLon of The Mothership
    NSString *latLon = [NSString stringWithFormat:@"%.02f,%.02f",Lat,Long];
    NSString *clientID = [NSString stringWithUTF8String:fsClientID];
    NSString *clientSecret = [NSString stringWithUTF8String:fsClientkey];
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"client_id", clientSecret, @"client_secret", @"4d4b7104d754a06370d81259", @"categoryId", @"20160301", @"v", txtSearch.text, @"query", nil];
    
    [objectManager getObjectsAtPath:@"/v2/venues/search" parameters:queryParams success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"MappingArray = %@",mappingResult.array);
        arrFetchdata = mappingResult.array;
        [self.tblNearbylist reloadData];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"What do you mean by 'there is no coffee?': %@", error);
    }];
}
#pragma mark -
#pragma mark Touches methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch= [touches anyObject];
    if ([touch view] == self.view || [touch view] == tblNearbylist)
    {
        [txtSearch resignFirstResponder];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [txtSearch.text stringByReplacingCharactersInRange:range withString:string];
    
    
    NSLog(@"Update String = %@",newString);
    [self searchNearMe:txtSearch.text];
    return YES;
}
@end
