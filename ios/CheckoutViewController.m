//
//  CheckoutViewController.m
//  StripeRN
//
//  Created by abilican on 11.03.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Stripe/Stripe.h>
#import "CheckoutViewController.h"
#import "AppDelegate.h"

@interface  CheckoutViewController ()
@end

@implementation CheckoutViewController

#pragma mark - STPAuthenticationContext
- (UIViewController *)authenticationPresentingViewController {
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  return delegate.rootViewController;
}
@end
