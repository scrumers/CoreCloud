//
//  CKEngine.h
//  CloudKit
//
//  Created by Ludovic Galabru on 05/05/10.
//  Copyright 2010 r. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CKEngine

@required
- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSDictionary *)params;
- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params andData:(id *)data;

@end
