//
//  StripeBridge.m
//  StripeRN
//
//  Created by abilican on 11.03.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StripeBridge.h"
#import <Stripe/Stripe.h>
#import "CheckoutViewController.h"

@implementation StripeBridge
RCT_EXPORT_MODULE();

// createPaymentIntent
RCT_EXPORT_METHOD(createPayment:(NSString*)clientSecret whitCc:(NSString*)cc withMo:(NSString*)month withYe:(NSString*)year withCvc:(NSString*)cvc callback:(RCTResponseSenderBlock)callback ){
  
  NSNumber *num1 = @([month intValue]);
  NSNumber *num2 = @([year intValue]);
  
  STPPaymentMethodCardParams *cardParams = [STPPaymentMethodCardParams new];
  cardParams.number = cc;
  cardParams.expMonth = num1;
  cardParams.expYear = num2;
  cardParams.cvc = cvc;
  
  STPPaymentMethodParams *paymentMethodParams = [STPPaymentMethodParams paramsWithCard:cardParams billingDetails:nil metadata:nil];
  STPPaymentIntentParams *paymentIntentParams = [[STPPaymentIntentParams alloc] initWithClientSecret:clientSecret ];
  paymentIntentParams.paymentMethodParams = paymentMethodParams;
  
  CheckoutViewController *authContext = [[CheckoutViewController alloc] init];
  [[STPPaymentHandler sharedHandler] confirmPayment:paymentIntentParams withAuthenticationContext:authContext completion:^(STPPaymentHandlerActionStatus status, STPPaymentIntent * paymentIntent, NSError * error) {
    switch (status) {
      case STPPaymentHandlerActionStatusSucceeded:
        NSLog(@"PAYMENTINTENT: %@", paymentIntent.stripeId);
        callback(@[[NSNull null], @"SUCCESS", paymentIntent.stripeId]);
        break;
        // Payment succeeded
      case STPPaymentHandlerActionStatusCanceled:
        callback(@[[NSNull null], @"CANCEL" ]);
        break;
        // Handle cancel
      case STPPaymentHandlerActionStatusFailed:
        NSLog(@"ERROR: %@", error);
        callback(@[[NSNull null], @"ERROR", @"NULL" ]);
        break;
        // Handle error
    }
  }];
}

@end
