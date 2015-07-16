//
//  CreatedCardViewController.h
//  TradingCards
//
//  Created by Aidan Lavery on 2015-06-26.
//  Copyright (c) 2015 Gregory Lavery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatedCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *savePressed;

@property (weak, nonatomic) IBOutlet UIImageView *cardBackground;
@property (weak, nonatomic) IBOutlet UIImage *playerBackground;
@property NSString* firstName;
@property NSString* lastName;
@property NSString* position;
@property NSString* titleInfo;
@property float speed;
@property float tackle;
@property float power;
@property float shoot;
@property float skill;
@property float pass;
@property float price;
@property float defence;
@property float attack;


- (IBAction)savePressed:(id)sender;
-(void)fillInAllDetails;
-(void)calculateTotals;
-(void)updateAllLabels:(NSInteger)tag :(NSString*)labelName :(float)setting :(NSInteger) specialInfo;
-(UIImage *)prepareImage;


@end
