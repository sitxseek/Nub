//
//  UpdateViewController.m
//  Nub
//
//  Created by Yangzong Guo on 12/5/15.
//  Copyright © 2015 Yangzong Guo. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *status;

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status.delegate = self;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.status becomeFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(self.status.text);
    }
    _status = nil;
    return YES;
}

-(void) enableSaveButtonForQuote: (NSString *) statusText {
    self.saveButton.enabled = (statusText.length > 0 );
}

-(BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self enableSaveButtonForQuote:changedString];
    
    return YES;
}

-(void)dismissKeyboard {
    [_status resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(id)sender {
    [_status resignFirstResponder];
    if (self.completionHandler) {
        self.completionHandler(nil);
    }
    _status.text = nil;
}

- (IBAction)saveButtonPressed:(id)sender {
    [_status resignFirstResponder];
    if (self.completionHandler) {
        self.completionHandler(self.status.text);
    }
    _status.text = nil;
}
@end
