//
//  CKAuthenticationEngine.h
//  Sprints
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CKAuthenticationEngine

- (void)setupWithDictionary:(NSDictionary *)dictionary; 
- (NSMutableURLRequest *)signRequest:(NSMutableURLRequest *)request;

@end