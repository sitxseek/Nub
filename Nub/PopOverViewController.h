//
//  PopOverViewController.h
//  Nub
//
//  Created by Yangzong Guo on 12/9/15.
//  Copyright © 2015 Yangzong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) NSString *statusText;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) NSString *timeText;
@end
