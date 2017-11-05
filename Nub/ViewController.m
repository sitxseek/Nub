//
//  ViewController.m
//  Nub
//
//  Created by Yangzong Guo on 12/2/15.
//  Copyright (c) 2015 Yangzong Guo. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <Bolts/Bolts.h>
#import "MainViewController.h"
@interface ViewController ()
- (IBAction)signInButtonTapped:(id)sender;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"DisplayMain"])
    {
        // Get reference to the destination view controller
        MainViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
    }
}*/
- (IBAction)signInButtonTapped:(id)sender {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[@"public_profile", @"email", @"user_friends", @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"user_friends"];

    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
            [self performSegueWithIdentifier:@"DisplayMain" sender:self];
        }
    }];
}
@end
