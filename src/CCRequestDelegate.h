//
//  CCRequestResponderDelegate.h
//  CoreCloud
//
//  Created by Ludovic Galabru on 5/20/10.
//  Copyright 2010 scrumers. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CCRequestDelegate

- (void)request:(NSMutableURLRequest *)request didFailWithError:(NSError *)error;
-	(void)request:(NSMutableURLRequest *)request didSucceedWithData:(id)data;

@end