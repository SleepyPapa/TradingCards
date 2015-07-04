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
    [_cardBackground setContentMode:UIViewContentModeScaleAspectFill];
    [_cardBackground setClipsToBounds: YES];
    [self fillInAllDetails];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) savePressed: (UIButton *)sender {
    
    UIImage *toBeSaved = [self prepareImage];
    UIImageWriteToSavedPhotosAlbum(toBeSaved, nil, nil, nil);

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"Score!", nil)]
                                                                   message:[NSString stringWithFormat:NSLocalizedString(@"Saved to Photos", nil)]
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
    NSUInteger countOfLetters = fullname.length;
    float fontSizeToBeUsed;
    if (countOfLetters<15){
        fontSizeToBeUsed = 32.0f;
    } else if (countOfLetters>=15 && countOfLetters<25){
        fontSizeToBeUsed = 25.0f;
    } else{
        fontSizeToBeUsed = 20.0f;
    }
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,80)];
    newLabel.textColor = [UIColor blueColor];
    newLabel.backgroundColor = [UIColor grayColor];
    newLabel.alpha=0.8;
    newLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:fontSizeToBeUsed];
    [newLabel setText: fullname];
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.transform=CGAffineTransformMakeRotation( ( 270 * M_PI ) / 180 );
    newLabel.center=CGPointMake(30,180);
    [self.view addSubview:newLabel];
    
    [self calculateTotals];
    
    UIView *mainPictureView = [self.view viewWithTag:15];
    if ([mainPictureView isKindOfClass:[UIImageView class]])
         {
             mainPictureView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
        newLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:18.0f];
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

-(UIImage *) prepareImage
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size,self.view.opaque,0.0f);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *mainImage;
    mainImage=imageView;
    

    CGPoint cutOrigin = CGPointMake(0,30);
    CGPoint cutExtent = cutOrigin;
    cutExtent.x = imageView.size.width;
    cutExtent.y = imageView.size.height-80;
    
    double (^rad)(double) = ^(double deg) {
        return deg / 180.0 * M_PI;
    };
    
    CGAffineTransform rectTransform;
    switch (mainImage.imageOrientation) {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(90)), 0, -mainImage.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-90)), -mainImage.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-180)), -mainImage.size.width, -mainImage.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    rectTransform = CGAffineTransformScale(rectTransform, mainImage.scale, mainImage.scale);
    
    //get mainImage data resized
    CGImageRef temporaryImageReference = mainImage.CGImage;
    CGImageRef cutImageReference = CGImageCreateWithImageInRect(temporaryImageReference,CGRectApplyAffineTransform (CGRectMake(cutOrigin.x, cutOrigin.y, cutExtent.x, cutExtent.y),rectTransform));
    UIImage *cutImage = [UIImage imageWithCGImage:cutImageReference scale:mainImage.scale orientation:mainImage.imageOrientation];
    CGImageRelease(cutImageReference);
    return cutImage;
}

@end
