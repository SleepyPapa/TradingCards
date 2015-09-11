//
//  ChooseTeamViewController.m
//  TradingCards
//
//  Created by Gregory Lavery on 28/08/2015.
//  Copyright (c) 2015 Gregory Lavery. All rights reserved.
//

#import "ChooseTeamViewController.h"
#import "GJLViewController.h"

@interface ChooseTeamViewController ()

@end

@implementation ChooseTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GJLViewController *vc = [segue destinationViewController];
    UIImage *standardImage;
    NSString *filename;
    filename= @"fusion.png"; //default

    if ([segue.identifier isEqualToString:@"bays"]) {
        filename= @"bays.png";
    }
    if ([segue.identifier isEqualToString:@"cowichan"]) {
        filename= @"cowichan.png";
    }
    if ([segue.identifier isEqualToString:@"fusion"]) {
        filename= @"fusion.png";
    }
    if ([segue.identifier isEqualToString:@"gorge"]) {
        filename= @"gorge.png";
    }
    if ([segue.identifier isEqualToString:@"jdf"]) {
        filename= @"jdf.png";
    }
    if ([segue.identifier isEqualToString:@"lakehill"]) {
        filename= @"lakehill.png";
    }
    if ([segue.identifier isEqualToString:@"pen"]) {
        filename= @"pen.png";
    }
    if ([segue.identifier isEqualToString:@"saltspring"]) {
        filename= @"saltspring.png";
    }
//    if ([segue.identifier isEqualToString:@"sooke"]) {
//        filename= @"sooke.png";
//    }
    standardImage = [UIImage imageNamed:filename];
    [vc setUseThisLogo:standardImage];
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
