//
//  Location.h
//  NordeaDemo
//
//  Created by Prashant on 28/02/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
{
    
}
/*
@property (nonatomic,strong) NSString *strLocName;
@property (nonatomic,strong) NSString *strLocAddress;
@property (nonatomic,strong) NSString *strLocDistance;*/
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *crossStreet;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lng;
@end
