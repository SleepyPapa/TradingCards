//
//  CreatedCardViewController.m
//  TradingCards
//
//  Created by Aidan Lavery on 2015-06-26.
//  Copyright (c) 2015 Gregory Lavery. All rights reserved.
//

#import "CreatedCardViewController.h"

@interface CreatedCardViewController ()

@end

@implementation CreatedCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cardBackground.image=_playerBackground;
    [self fillInAllDetails];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) savePressed: (UIButton *)sender {
    
    CGSize snippedSize = self.view.bounds.size;
    snippedSize.height-=80;
    
    UIGraphicsBeginImageContext(snippedSize);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(imageView, nil, nil, nil);
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Score!"
                                                                   message:@"Saved to Photos"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(void) fillInAllDetails
{
    NSString *fullname = self.firstName;
    fullname= [fullname stringByAppendingString:@" "];
    fullname= [fullname stringByAppendingString:  self.lastName];
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,250,60)];
    newLabel.textColor = [UIColor blueColor];
    newLabel.backgroundColor = [UIColor grayColor];
    newLabel.alpha=0.8;
    newLabel.font = [UIFont italicSystemFontOfSize:32.0f];
    [newLabel setText: fullname];
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.transform=CGAffineTransformMakeRotation( ( 270 * M_PI ) / 180 );
    newLabel.center=CGPointMake(30,180);
    [self.view addSubview:newLabel];
    
    [self calculateTotals];
    
    UIView *mainPictureView = [self.view viewWithTag:15];
    if ([mainPictureView isKindOfClass:[UIImageView class]])
         {
             CAGradientLayer *gradientLayer = [CAGradientLayer layer];
             gradientLayer.frame = mainPictureView.bounds;
             gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
             gradientLayer.startPoint = CGPointMake(1.0f, 0.6f);
             gradientLayer.endPoint = CGPointMake(1.0f, 1.0f);
             mainPictureView.layer.mask = gradientLayer;
         }

    [self updateAllLabels:20 :[NSString stringWithFormat:NSLocalizedString(@"Speed", nil)] :self.speed :1];
    [self updateAllLabels:21 :[NSString stringWithFormat:NSLocalizedString(@"Tackle", nil)] :self.tackle :1];
    [self updateAllLabels:22 :[NSString stringWithFormat:NSLocalizedString(@"Power", nil)] :self.power :1];
    [self updateAllLabels:23 :[NSString stringWithFormat:NSLocalizedString(@"Shoot", nil)] :self.shoot :2];
    [self updateAllLabels:24 :[NSString stringWithFormat:NSLocalizedString(@"Skill", nil)] :self.skill :2];
    [self updateAllLabels:25 :[NSString stringWithFormat:NSLocalizedString(@"Pass", nil)] :self.pass :2];
    [self updateAllLabels:26 :@"$" :self.price :4];
    [self updateAllLabels:27 :self.position :0 :3];
    [self updateAllLabels:28 :[NSString stringWithFormat:NSLocalizedString(@"", nil)] :self.defence :5];
    [self updateAllLabels:29 :[NSString stringWithFormat:NSLocalizedString(@"", nil)] :self.attack :5];
}

-(void)updateAllLabels :(NSInteger)tag :(NSString*)labelName :(float)setting :(NSInteger) specialInfo
{
    UIView *numberOfMovesView = [self.view viewWithTag:(tag)];
    
    if ([numberOfMovesView isKindOfClass:[UILabel class]]) {
        CGFloat centreX = numberOfMovesView.center.x;
        CGFloat centreY = numberOfMovesView.center.y;
        [numberOfMovesView removeFromSuperview];
        NSString* labelToUpdate;
        UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,21)];
        newLabel.font = [UIFont italicSystemFontOfSize:18.0f];
        if (specialInfo==1){
            labelToUpdate = [NSString stringWithFormat:@"%ld %@",(long)setting,labelName];
            newLabel.textAlignment = NSTextAlignmentLeft;
        }
        if (specialInfo==2) {
            labelToUpdate = [NSString stringWithFormat:@"%@ %ld ", labelName,(long)setting];
            newLabel.textAlignment = NSTextAlignmentRight;
        }
        if (specialInfo==3) {
            labelToUpdate = [NSString stringWithFormat:@"%@", labelName];
            newLabel.font = [UIFont italicSystemFontOfSize:20.0f];
            newLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (specialInfo==4) {
            labelToUpdate = [NSString stringWithFormat:@"%@%ldM", labelName,(long)setting];
            newLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (specialInfo==5) {
            labelToUpdate = [NSString stringWithFormat:@"%ld",(long)setting];
            newLabel.textAlignment = NSTextAlignmentCenter;
        }

        newLabel.textColor = [UIColor redColor];
        newLabel.tag=tag;
        newLabel.text = labelToUpdate;
        newLabel.center=CGPointMake(centreX,centreY);
        [self.view addSubview:newLabel];
    }
    
}

-(void)calculateTotals
{
    NSInteger average = ((_speed+_tackle+_power)/3);
    self.defence=average;
    average = ((_shoot+_skill+_pass)/3);
    self.attack=average;
    
    average = self.defence+self.attack;
    self.price = (10*average)/200;
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
