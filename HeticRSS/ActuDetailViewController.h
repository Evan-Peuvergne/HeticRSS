//
//  ActuDetailViewController.h
//  HeticRSS
//
//  Created by evan peuvergne on 03/01/2014.
//  Copyright (c) 2014 evan peuvergne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActuDetailViewController : UIViewController

@property NSArray* flux;
@property int index;

@property (weak, nonatomic) IBOutlet UILabel *actuTitre;
@property (weak, nonatomic) IBOutlet UIWebView *actuContent;

- (IBAction)actuSuivante:(id)sender;

@end
