//
//  ActusViewController.m
//  HeticRSS
//
//  Created by evan peuvergne on 03/01/2014.
//  Copyright (c) 2014 evan peuvergne. All rights reserved.
//

#import "ActusViewController.h"
#import "XMLDictionary.h"
#import "ActuDetailViewController.h"

@interface ActusViewController ()

@end

@implementation ActusViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Mise en place d'un loader
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake((self.view.frame.size.width/2) - (spinner.frame.size.width/2), (self.view.frame.size.height/2) - (spinner.frame.size.height/2));
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    //Requete de récupération du flux RSS
    NSString* url = @"http://feeds.feedburner.com/hetic?format=xml";
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    //Gestion de la réponse
    NSURLResponse* reponse = nil;
    NSError* erreur = nil;
    NSData* donnees = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&erreur];
    
    self.flux = (NSArray*)[[[NSDictionary dictionaryWithXMLData:donnees] valueForKey:@"channel"] valueForKey:@"item"];
    
    [spinner stopAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.flux count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* elem = (NSDictionary*) [self.flux objectAtIndex:[indexPath item]];
    cell.textLabel.text = [elem valueForKey:@"title"];
    cell.detailTextLabel.text = [[[elem valueForKey:@"pubDate"] substringFromIndex:5] substringToIndex:12];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (CGFloat)100;
}

//Gestion du transfert du contenu

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ActuDetailViewController* controller = (ActuDetailViewController*)segue.destinationViewController;
    controller.flux = self.flux;
    controller.index = self.tableView.indexPathForSelectedRow.item;
    
}


@end
