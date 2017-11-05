//
//  FriendsModel.m
//  Nub
//
//  Created by Yangzong Guo on 12/6/15.
//  Copyright © 2015 Yangzong Guo. All rights reserved.
//

#import "FriendsModel.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <Bolts/Bolts.h>
@interface FriendsModel()
@property (strong, nonatomic) NSMutableArray *friends;
@end

@implementation FriendsModel
- (id) init {
    self = [super init];
    if (self) {
        _friends =[[NSMutableArray alloc] init];
    }
    return self;
}

- (void) insertFriend: (NSString *) userId
              name: (NSString *) name
             status: (NSString *) status
          lastUpdated: (NSString *) lastUpdated
              picture: (UIImage *) picture {
    NSDictionary *friend = [[NSDictionary alloc] initWithObjectsAndKeys:userId, @"userId", name, @"name", status, @"status", lastUpdated, @"lastUpdated", picture, @"picture", nil];
    [self.friends addObject:friend];
}

+ (instancetype) sharedModel {
    static FriendsModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (NSUInteger) numberOfFriends {
    NSUInteger keyCount = [self.friends count];
    return keyCount;
}

- (NSDictionary *) friendAtIndex: (NSUInteger) index {
    return _friends[index];
}

- (void) sort {
    [_friends sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], nil]];
}

- (void) deleteArray {
    [self.friends removeAllObjects];
}
@end
