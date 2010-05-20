//
//  CKRequestResponderDelegate.h
//  CloudKit
//
//  Created by Ludovic Galabru on 5/20/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CKRequestDelegate

- (void)request:(NSMutableURLRequest *)request didFailWithError:(NSError *)error;
-	(void)request:(NSMutableURLRequest *)request didSucceedWithData:(id)data;

@end