//
//  NSMutableArray+CoreCloudAdditions.m
//  CoreCloud
//
//  Created by Ludovic Galabru on 5/20/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import "NSMutableArray+CoreCloudAdditions.h"


@implementation NSMutableArray (CoreCloud)

- (void)removeEmptyStrings {
	[self removeObjectsInArray:[NSArray arrayWithObject:@""]];
}

@end
