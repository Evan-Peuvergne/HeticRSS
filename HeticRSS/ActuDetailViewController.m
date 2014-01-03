//
//  ActuDetailViewController.m
//  HeticRSS
//
//  Created by evan peuvergne on 03/01/2014.
//  Copyright (c) 2014 evan peuvergne. All rights reserved.
//

#import "ActuDetailViewController.h"

@interface ActuDetailViewController ()

@end

@implementation ActuDetailViewController

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
    
    NSDictionary* elem = (NSDictionary*)[self.flux objectAtIndex:self.index];
    
    self.actuTitre.text = [elem valueForKey:@"title"];
    
    [self.actuContent loadHTMLString:[elem valueForKey:@"description"] baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actuSuivante:(id)sender {
    
    if(self.index == [self.flux count] - 1){
        self.index = 0;
    }else{
        self.index++;
    }
    [self viewDidLoad];
    
}

@end
