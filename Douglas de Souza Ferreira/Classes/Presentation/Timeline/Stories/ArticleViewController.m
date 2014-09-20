//
//  ArticleViewController.m
//  Douglas de Souza Ferreira
//
//  Created by Douglas Ferreira on 14/04/14.
//  Copyright (c) 2014 Douglas Ferreira. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (IBAction)openArticlePage:(UIBarButtonItem *)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://submissoes.sbc.org.br/PaperShow.cgi?m=113074"]];
}

@end
