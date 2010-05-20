//
//  NSDictionary+CloudKitAdditions.h
//  CloudKit
//
//  Created by Ludovic Galabru on 19/05/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (CloudKit)

+ (NSDictionary *)dictionaryWithDictionary:(NSDictionary *)dict1 andDictionary:(NSDictionary *)dict2;

@end
