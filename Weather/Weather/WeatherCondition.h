//
//  WeatherCondition.h
//  Weather
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface WeatherCondition : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSDate *date;
@property (nonatomic) NSNumber *humidity;
@property (nonatomic) NSNumber *temperature;
@property (nonatomic) NSNumber *tempHigh;
@property (nonatomic) NSNumber *tempLow;
@property (nonatomic) NSString *locationName;
@property (nonatomic) NSDate *sunrise;
@property (nonatomic) NSDate *sunset;
@property (nonatomic) NSString *conditionDescription;
@property (nonatomic) NSString *condition;
@property (nonatomic) NSNumber *windBearing;
@property (nonatomic) NSNumber *windSpeed;
@property (nonatomic) NSString *icon;

- (NSString *)imageName;
@end
