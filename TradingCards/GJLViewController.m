//
//  ViewController.m
//  TradingCards
//
//  Created by Aidan Lavery on 2015-06-24.
//  Copyright (c) 2015 Gregory Lavery. All rights reserved.
//

#import "GJLViewController.h"
#import "CreatedCardViewController.h"

@interface GJLViewController ()
{
    
}


@end

@implementation GJLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstNameField.delegate = self;
    _lastNameField.delegate = self;
    _titleField.delegate = self;
    self.position = [_playerPosition titleForSegmentAtIndex:self.playerPosition.selectedSegmentIndex];

}


-(void) fillUpData{

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreatedCardViewController *vc = [segue destinationViewController];
    
    if (!self.useThisBackground){
        UIImage *standardImage;
        NSString *filename;
        filename= @"outline.jpg";
        standardImage = [UIImage imageNamed:filename];
        [vc setPlayerBackground: standardImage];
    }
    else{
        [vc setPlayerBackground: self.useThisBackground];
    }
    [vc setFirstName: _firstNameField.text];
    [vc setLastName: _lastNameField.text];
    [vc setTitleInfo: _titleField.text];
    [vc setPosition:self.position];
    [vc setSpeed: self.speedSlider.value];
    [vc setTackle: self.tackleSlider.value];
    [vc setPower: self.powerSlider.value];
    [vc setShoot: self.shootSlider.value];
    [vc setSkill: self.skillSlider.value];
    [vc setPass: self.passSlider.value];
    [vc setPrice: 5.0];
    [vc setDefence:50.0];
    [vc setAttack:50.0];
}
- (IBAction)createCard:(id)sender {

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)UnwindtoThisView:(UIStoryboardSegue *)segue
{
    //Placeholder for unwinding of segue, no need to do anything with it in this version
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)choosePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.useThisBackground = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)positionChanged:(id)sender {
    UISegmentedControl* positionControl = (UISegmentedControl *)sender;
    self.position = [positionControl titleForSegmentAtIndex:positionControl.selectedSegmentIndex];
    
}
@end
