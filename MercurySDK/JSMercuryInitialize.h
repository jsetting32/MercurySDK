//
//  JSMercuryInitialize.h
//  MercurySDK
//
//  Created by John Setting on 4/22/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSMercuryTypeDef.h"
#import "HCMercuryHelper.h"

// CardInfo is used to obtain a token without charging the card. Used for Card-on-File and Recurring billing.
@interface JSMercuryInitialize : NSObject <HCMercuryHelperDelegate>

+ (nullable instancetype)js_init;

@property (strong, nonatomic, nullable) kJSMercuryInitializeBlock completionBlock;

// OneTime or Recurring
@property (assign, nonatomic) kJSMercuryTransactionFrequencyType frequency;

// Customer Card Holder Name as it appears on card. This will pre- populate the Card Holder name on the checkout page and will appear in VIP reporting.
// This can be pre-populated with the Billing Name if you don’t have the Cardholder’s Name off the card.
@property (strong, nonatomic, nullable) NSString *cardHolderName;

// The URL to return to after the VIP HostedCheckout page finishes processing the transaction.
// For an iFrame: This page will display within the iFrame window.
@property (strong, nonatomic, nonnull) NSString *processCompleteUrl;

// For a Redirect: The URL to return to in the event the user wants to cancel. Typically this URL is the page they just came from such as an Order Page.
// The ReturnUrl is also used during a session timeout or if VIP goes into maintenance mode.
// For an iFrame: The [Cancel] button is not displayed. However, the ReturnUrl is used for a session timeout.
// In that case, the ReturnUrl page will display in the iFrame. This URL must not be the same page that the iFrame
// exists on or it will cause the iFrame to display duplicate or nested pages. Use a separate URL such as the ProcessCompleteURL or some other page.
@property (strong, nonatomic, nonnull) NSString *returnUrl;

// Values are 0 to 15, and indicate minutes until the page times out. Defaults to 0. If PageTimeoutDuration is greater than 0,
// timeout is active. Upon timeout, user will be automatically redirected to the ReturnUrl.
@property (strong, nonatomic, nullable) NSNumber *pageTimeoutDuration;

// Valid values are Mercury or Custom. If DisplayStyle is not specified, the style of the page will default to Mercury.
// Mercury: Displays the Mercury banner with a white background, and black Arial text. On an iFrame, no Mercury banner is displayed.
// Custom: Displays the supplied logo from LogoURL, background color, and font information. If no LogoURL is passed or if it is an iFrame, then no logo is displayed.
@property (assign, nonatomic) kJSMercuryCheckoutPageStyle displayStyle;

// Specifies the background color of the page. Default is white. Format is hexadecimal or a standard named color.
// The color should be consistent with the background displayed on the Merchant’s web site to make the integration more seamless.
// ☞ Note If ‘Mercury’ is passed as DisplayStyle, the background color will be white regardless of the value passed.
@property (strong, nonatomic, nullable) NSString *backgroundColor;

// The color for the labels on the page. Default is black. Format is hexadecimal or html name (i.e., Cyan or #00ffff)
// ☞ Note If ‘Mercury’ is passed as DisplayStyle, font color will be black, regardless of the value passed.
@property (strong, nonatomic, nullable) NSString *fontColor;

// The font family to be used for the labels on the page. Default is Arial. There are 3 pre-defined font family values that may be used: FontFamily1, FontFamily2, FontFamily3.
// A custom font family may also be specified. This is a comma- delimited string of fonts. Example: ‘Comic Sans MS, Arial, sans- serif’
// ☞ Note If ‘Mercury’ is passed as DisplayStyle, font family will be Arial, regardless of the value passed. Not utilized in mobile integration.
@property (strong, nonatomic, nullable) NSString *fontFamily;

// The font size. Default is Medium. Options are Small, Medium, Large
// ☞ Note If ‘Mercury’ is passed as DisplayStyle, font size will be medium, regardless of the value passed. Not utilized in mobile integration.
@property (strong, nonatomic, nullable) NSString *fontSize;

// For a Redirect: Specifies the URL of the logo to display at the top of the page. Default is no logo.
// ☞ Note If ‘Mercury’ is passed as DisplayStyle, this will not be displayed.
// This URL must use the HTTPS protocol. If the LogoURL is HTTP, security warnings will be displayed to the end user.
// For an iFrame: The LogoURL is not used because the iFrame is already embedded on the developer’s web page.
@property (strong, nonatomic, nullable) NSString *logoUrl;

// For a Redirect: The html title of the page that the browser will display in the title bar.
// Typically this is the name of the merchant’s web site. Helps to brand the checkout page similar to the Merchant’s web site.
// If this is not specified, the default value is ‘Mercury Secure Checkout’.
// For an iFrame: Not applicable.
@property (strong, nonatomic, nullable) NSString *pageTitle;

// Custom text for the [Submit] button. Default value is Update on Ecomm and Add Card on POS solution.
// Note that on iFrame, some 32 character strings will not fit due to physical space constraints, and the text will be cut off.
@property (strong, nonatomic, nullable) NSString *submitButtonText;

// Custom text for the [Cancel] button. Default value is Cancel. This only applies to Redirect pages, since there is no [Cancel] button on iFrame pages.
@property (strong, nonatomic, nullable) NSString *cancelButtonText;

// Custom button text color. Can be a web color, such as “White”, or a color hex value such as “#ffffcc.
@property (strong, nonatomic, nullable) NSString *buttonTextColor;

// Custom button background color. Can be a web color, such as “Magenta”, or a color hex value such as “#567891.
@property (strong, nonatomic, nullable) NSString *buttonBackgroundColor;

// Displays a [Cancel] button on the iFrame. If selected it returns user to the ReturnUrl page. Values are on and off. Default is off.
// This only applies to iFrame pages. The [Cancel] button is always displayed on the redirect pages.
@property (assign, nonatomic) BOOL cancelButton;

// Display JCB radio button. Values are On and Off. Default is On.
@property (assign, nonatomic) BOOL JCB;

//Display Diners radio button. Values are On and Off. Default is On.
@property (assign, nonatomic) BOOL Diners;

- (nonnull NSMutableDictionary *)generateParameters;
@end
