//
//  PopOverViewController.m
//  Nub
//
//  Created by Yangzong Guo on 12/9/15.
//  Copyright © 2015 Yangzong Guo. All rights reserved.
//

#import "PopOverViewController.h"

@interface PopOverViewController ()


@end

@implementation PopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.statusLabel.text = self.statusText;
    self.timeLabel.text = self.timeText;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
