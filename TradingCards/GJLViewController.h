//
//  ViewController.h
//  TradingCards
//
//  Created by Aidan Lavery on 2015-06-24.
//  Copyright (c) 2015 Gregory Lavery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJLViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UIButton *changePosition;
//@property (weak, nonatomic) IBOutlet UIImageView *imageToUse;
@property UIImage* useThisLogo;
@property UIImage* useThisBackground;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property NSString* position;

@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISlider *tackleSlider;
@property (weak, nonatomic) IBOutlet UISlider *powerSlider;
@property (weak, nonatomic) IBOutlet UISlider *shootSlider;
@property (weak, nonatomic) IBOutlet UISlider *skillSlider;
@property (weak, nonatomic) IBOutlet UISlider *passSlider;
- (IBAction)positionChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *playerPosition;

@end

