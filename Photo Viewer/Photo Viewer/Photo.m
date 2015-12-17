//
//  Photo.m
//  Photo Viewer
//
//  Created by Chang Tong Xue on 2015-12-16.
//  Copyright © 2015 DX. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithDetail: (NSString*) name fileName: (NSString*) fileName detail: (NSString*) note
{
    self = [super init];
    if (self) {
        self.name     = name;
        self.fileName = fileName;
        self.note     = note;
    }
    return self;
}
@end
