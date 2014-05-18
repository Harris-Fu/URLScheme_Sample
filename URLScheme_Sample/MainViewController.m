//
//  MainViewController.m
//  URLScheme_Sample
//
//  Created by 傅小柳 on 2014/5/18.
//  Copyright (c) 2014年 Harris. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - URL Scheme
// open website use safari
- (IBAction)openSafari:(id)sender {
    
    NSString *urlString = @"http://tw.yahoo.com";
    // open it use Safari
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

// send email use application
- (IBAction)sendEmail:(id)sender {
    // recipient
    NSString *mailTo = @"ertt001@hotmail.com";
    // subject
    NSString *mailSubject = @"HelloWorld";
    // carbon
    NSString *mailCc = @"myBOSS@hotmail.com";
    // blind carbon
    NSString *mailBcc = @"myQueen@gmail.com";
    
    NSString *urlString = [NSString stringWithFormat:@"mailto:%@?subject=%@&cc=%@&bcc=%@",
                           mailTo, mailSubject, mailCc, mailBcc];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

// send eMail use MFMailComposeViewController
- (IBAction)sendEMailuseMFMailComposeViewController:(id)sender {
    
    // Email Subject
    NSString *emailTitle = @"Test Email";
    // Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"ertt001@hotmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    [mc setCcRecipients:[NSArray arrayWithObject:@"ertt001@gmail.com"]];
    [mc setBccRecipients:[NSArray arrayWithObject:@"snow33528@hotmail.com"]];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

// MFMailComposeViewControllerDelegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// open dial, it only supports in iPhone.
- (IBAction)openDial:(id)sender {
    
    UIDevice *device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPhone"]) {
        // set the phone number
        NSString *phoneNumber = @"tel:0911XXXYYY";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"Your Device *%@* Can`t Support To Dial", device.model];
        [self errorAlert:errorMessage];
    }
}

// send message, it`s only supports in iPhone.
- (IBAction)sendMessage:(id)sender {
    
    UIDevice *device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPhone"]) {
        NSString *sms = @"sms:0911XXXYYY";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sms]];
    } else {
        NSString *errorMessage = [NSString stringWithFormat:@"Your Device *%@* Can`t Support To Message", device.model];
        [self errorAlert:errorMessage];
    }
}

// error Alert
- (void) errorAlert:(NSString *)errorMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorMessage
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
