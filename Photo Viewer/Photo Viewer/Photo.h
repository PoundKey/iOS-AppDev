//
//  Photo.h
//  Photo Viewer
//
//  Created by Chang Tong Xue on 2015-12-16.
//  Copyright © 2015 DX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* fileName;
@property (nonatomic) NSString* note;

- (instancetype)initWithDetail: (NSString*) name fileName: (NSString*) fileName detail: (NSString*) note;
@end
