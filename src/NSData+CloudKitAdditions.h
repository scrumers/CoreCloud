//
//  NSData+ScrumersAdditions.h
//  CloudKit
//
//  Created by Ludovic Galabru on 07/04/10.
//  Copyright 2010 Scrumers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (CloudKit)

+ (NSString*)base64forData:(NSData*)theData;

@end
