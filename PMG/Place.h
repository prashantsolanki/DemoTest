//
//  Place.h
//  NordeaDemo
//
//  Created by Prashant on 29/02/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Place : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic, strong) Location *location;

-(id) initWithJson:(NSDictionary *)json;

@end
