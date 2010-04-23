//
//  CKCloudKitManager.h
//  Scrumers
//
//  Created by Ludovic Galabru on 25/07/09.
//  Copyright 2009 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CKAuthenticationEngine.h"
#import "CKSerializationEngine.h"
#import "CKInstanciationEngine.h"

@interface CKCloudKitManager : NSObject {
	NSString *_domain, *_subdomain, *_protocol, *_api_path;
	NSObject<CKAuthenticationEngine> *_authenticationEngine;
	NSObject<CKSerializationEngine> *_serializationEngine;
	NSObject<CKInstanciationEngine> *_instanciationEngine;

}

+ (CKCloudKitManager *)defaultConfiguration;
- (NSMutableURLRequest *)signRequest:(NSMutableURLRequest *)request;

@property(nonatomic, copy) NSString *domain, *subdomain, *protocol, *api_path;
@property(nonatomic, retain) NSObject<CKAuthenticationEngine> *authenticationEngine;
@property(nonatomic, retain) NSObject<CKSerializationEngine> *serializationEngine;
@property(nonatomic, retain) NSObject<CKInstanciationEngine> *instanciationEngine;

@end
