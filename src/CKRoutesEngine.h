//
//  CKRoutesEngine.h
//  CloudKit
//
//  Created by Ludovic Galabru on 08/04/10.
//  Copyright 2010 Software Engineering Task Force. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKEngine.h"

@interface CKRoutesEngine : NSObject<CKEngine> {
	NSDictionary *routes, *constants;
}

- (id)initWithRoutesURL:(NSURL *)URL;

- (void)processRequest:(NSMutableURLRequest **)request withParams:(NSDictionary *)params;
- (void)processResponse:(NSHTTPURLResponse **)response withParams:(NSDictionary *)params data:(id *)data andError:(NSError **)error;

@end
