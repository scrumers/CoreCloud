//
//  NSMutableArray+CloudKitAdditions.m
//  CloudKit
//
//  Created by Ludovic Galabru on 5/20/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import "NSMutableArray+CloudKitAdditions.h"


@implementation NSMutableArray (CloudKit)

- (void)removeEmptyStrings {
	[self removeObjectsInArray:[NSArray arrayWithObject:@""]];
}

@end
