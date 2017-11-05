//
//  FriendsModel.h
//  Nub
//
//  Created by Yangzong Guo on 12/6/15.
//  Copyright © 2015 Yangzong Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
@interface FriendsModel : NSObject

+(instancetype) sharedModel;

- (void) insertFriend: (NSString *) userId
                 name: (NSString *) name
               status: (NSString *) status
          lastUpdated: (NSString *) lastUpdated
              picture: (UIImage *) picture;

- (NSUInteger) numberOfFriends;

- (NSDictionary *) friendAtIndex: (NSUInteger) index;

- (void) sort;

- (void) deleteArray;
@end
