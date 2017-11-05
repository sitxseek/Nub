//
//  MainViewController.m
//  
//
//  Created by Yangzong Guo on 12/4/15.
//
//

#import "MainViewController.h"
#import <Parse/Parse.h>
#import "UpdateViewController.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "FriendsModel.h"

@interface MainViewController ()
@property UIImage *friendPicture;
- (IBAction)updateTapped:(id)sender;

@property (strong, nonatomic) FriendsModel *model;
@property NSString *facebookID;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.model deleteArray];
    self.model = [FriendsModel sharedModel];
    //getting friendslist
    
    FBSDKGraphRequest *friendRequest = [[FBSDKGraphRequest alloc]
                                        initWithGraphPath:@"/me/friends"
                                        parameters:nil
                                        HTTPMethod:@"GET"];
    [friendRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                id result,
                                                NSError *error) {
        //NSArray *friendsList = (NSArray *)result;
        NSArray *friendsList = [result objectForKey:@"data"];
        for (int i = 0; i < [friendsList count]; i++) {
            NSDictionary *friend = friendsList[i];
            //get status of user
            PFQuery *query = [PFQuery queryWithClassName:@"Status"];
            [query whereKey:@"idee" equalTo:friend[@"id"]];
            
            PFObject *object = [query getFirstObject];
            //getting user profile picture
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small&return_ssl_resources=1", friend[@"id"]]];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
            [NSURLConnection sendAsynchronousRequest:urlRequest
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:
             ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                 if (connectionError == nil && data != nil) {
                     // Set the image in the imageView
                     _friendPicture = [[UIImage alloc] initWithData:data];
                     [self.model insertFriend:friend[@"id"] name:friend[@"name"] status:object[@"content"] lastUpdated: object[@"lastUpdated"] picture:_friendPicture];
                 }
             }];

            
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"toggle" object:nil];
        }
    }];
    [self someMethod];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            _facebookID = userData[@"id"];

            NSString *name = userData[@"name"];
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", _facebookID]];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
            
            // Run network request asynchronously
            [NSURLConnection sendAsynchronousRequest:urlRequest
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:
             ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                 if (connectionError == nil && data != nil) {
                     // Set the image in the imageView
                     UIImage *img = [[UIImage alloc] initWithData:data];
                     self.profilePicture.image = img;
                     self.profilePicture.layer.cornerRadius = 100;
                     self.profilePicture.layer.masksToBounds = YES;
                 }
             }];
            //setting name
            self.name.text = name;
            PFQuery *query = [PFQuery queryWithClassName:@"Status"];
            [query whereKey:@"idee" equalTo:_facebookID];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (object != nil) {
                    self.status.text = object[@"content"];
                } else {
                    //first initialization
                    NSDateFormatter *formatter;
                    NSString        *dateString;
                    formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
                    dateString = [formatter stringFromDate:[NSDate date]];
                    
                    
                    
                    NSLog(@"HOTHEREREREREEEEEEEEEEEEEEEEEEEE");
                    PFObject *status = [PFObject objectWithClassName:@"Status"];
                    status[@"content"] = self.status.text;
                    status[@"idee"] = _facebookID;
                    status[@"lastUpdated"] = dateString;
                    [status saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            // The object has been saved.
                        } else {
                            // There was a problem, check error.description
                        }
                    }];
                }
            }];
            

        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"UpdateStatus"]) {
        UpdateViewController *updateVC = segue.destinationViewController;
        updateVC.completionHandler = ^(NSString *status) {
            if (status != nil ) {
                self.status.text = status;
                NSDateFormatter *formatter;
                NSString        *dateString;
                
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
                
                dateString = [formatter stringFromDate:[NSDate date]];
                
                PFQuery *query = [PFQuery queryWithClassName:@"Status"];
                [query whereKey:@"idee" equalTo:_facebookID];
                PFObject *object = [query getFirstObject];
                object[@"content"] = self.status.text;
                object[@"lastUpdated"] = dateString;
                object[@"idee"] = _facebookID;
                [object saveInBackground];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
    if ([[segue identifier] isEqualToString:@"LogOut"]) {
        [self.model deleteArray];
        [PFUser logOut];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



- (void) someMethod
{
    
    // All instances of TestClass will be notified
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"received"
     object:self];
    
}

- (IBAction)updateTapped:(id)sender {
    [self performSegueWithIdentifier:@"UpdateStatus" sender:self];
}
@end
