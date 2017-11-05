//
//  UpdateViewController.h
//  Nub
//
//  Created by Yangzong Guo on 12/5/15.
//  Copyright © 2015 Yangzong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^UpdateCompletionHandler)(NSString *status);
@interface UpdateViewController : UIViewController <UITextFieldDelegate>
@property (copy, nonatomic) UpdateCompletionHandler completionHandler;
@end
