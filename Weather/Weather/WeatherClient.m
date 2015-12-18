//
//  WeatherClient.m
//  Weather
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import "WeatherClient.h"
#import "DailyForecast.h"

@interface WeatherClient()

@property (nonatomic) NSURLSession *session;

@end

@implementation WeatherClient
// Create API Requests and Parse them.
- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

@end
