//
//  CCEngine.h
//  CoreCloud
//
//  Created by Ludovic Galabru on 05/05/10.
//  Copyright 2010 r. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CCEngine

@required
- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSMutableDictionary **)params;
- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error;

@end
