//
//  DailyForecast.m
//  Weather
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import "DailyForecast.h"

@implementation DailyForecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // 1
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    // 2
    paths[@"tempHigh"] = @"temp.max";
    paths[@"tempLow"] = @"temp.min";
    // 3
    return paths;
}

@end
