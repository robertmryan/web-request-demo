//
//  ViewController.m
//  Web Request Demo
//
//  Created by Robert Ryan on 7/30/13.
//  Copyright (c) 2013 Robert Ryan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchUpInsideButton:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://sunnyside-demo.herokuapp.com/?location=32825&query=run"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"%s: sendAsynchronousRequest error: %@", __FUNCTION__, error);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            NSLog(@"%s: JSONObjectWithData error: %@", __FUNCTION__, jsonError);
            return;
        }

        NSString *result = resultDictionary[@"result"];

        // now do whatever you want with `result`, dispatching the UI updates to the main queue

        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:result
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        });
    }];
}
@end
