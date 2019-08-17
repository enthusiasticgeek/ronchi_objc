//
//  ViewController.h
//  ronchi
//
//  Created by Pratik Tambe on 3/14/19.
//  Copyright © 2019 Pratik Tambe. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>
#include <assert.h>

typedef double Vec[3] ;

#define RESOLUTION  (512) //(2048)

#define VecDot(a,b) ((a)[0]*(b)[0]+(a)[1]*(b)[1]+(a)[2]*(b)[2])
#define VecLen(a)   sqrtf(VecDot(a,a))

/*
double    diameter = 6.0 ;
double    flen = 48.0 ;
double    offset = -0.25 ;
double    grating = 100.0 ;
*/
double    K = -1.0 ;

/*
 * The formula for conics (with x/y swapped as per what I think are
 * the more natural configuration) is
 *
 * The bit of mathematics you need to know is that the surface is defined
 * by the following implicit surface:
 *
 * (x^2 + y^2) - 2 R z + (K + 1) z^2 == 0
 *
 * if K == -1, then
 *     z = (x^2 + y^2) / (2 * R)
 * else
 *     z = (R - sqrt((K + 1) (-x^2 - y^2) + R^2 )) / (K + 1)
 *
 * The normal vector is the 2 vector with components:
 *     -2 * x, -2 * y, 2 R - 2 * (K + 1) z
 *
 */


 //Based on code Written by Mark VandeWettering, https://github.com/brainwagon/ronchi/blob/master/ronchi.c

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//UIImageView
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *ronchiView;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UIImageView *infoView;

//Sliders
@property (strong, nonatomic) IBOutlet UISlider *offsetSlider;
@property (strong, nonatomic) IBOutlet UISlider *diameterSlider;
@property (strong, nonatomic) IBOutlet UISlider *focalLengthSlider;
@property (strong, nonatomic) IBOutlet UISlider *gratingSlider;

//Ronchi parameters
@property (nonatomic) float offset_fl;
@property (nonatomic) float diameter_fl;
@property (nonatomic) float focalLength_fl;
@property (nonatomic) int grating_fl;

//Buttons Callbacks
- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)savePhoto:(UIButton *)sender;
- (IBAction)saveRonchi:(UIButton *)sender;

//Buttons
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *savePhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *saveRonchiButton;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *offsetLabel;
@property (strong, nonatomic) IBOutlet UILabel *diameterLabel;
@property (strong, nonatomic) IBOutlet UILabel *focalLengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *gratingLabel;

//Text Boxes
@property (strong, nonatomic) IBOutlet UITextField *offsetTextBox;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextBox;
@property (strong, nonatomic) IBOutlet UITextField *focalLengthTextBox;
@property (strong, nonatomic) IBOutlet UITextField *gratingTextBox;

//Callback functions Text Boxes
-(void)offsetTextBoxDidChange :(UITextField *) textField;
-(void)diameterTextBoxDidChange :(UITextField *) textField;
-(void)focalLengthTextBoxDidChange :(UITextField *) textField;
-(void)gratingTextBoxDidChange :(UITextField *) textField;

//- (UIImage *)imageByDrawingCircleOnImage:(UIImage *)image size:(int)sliderValue;
- (UIImage*) scaleImage:(UIImage*)image toSize:(CGSize)newSize;
- (UIImage*) rawImage: (int)width : (int)height;
- (void)saveImage: (UIImage*)image;
- (void)saveImage1: (UIImage*)image;
-(void) saveImage2: (UIImage*) image;
- (UIViewController*) topMostController;

//Ronchi supporting functions
void VecNormalize(Vec a);
void VecSub(Vec r, Vec a, Vec b);
void Reflect(Vec R, Vec I, Vec N);

////Test Function
- (UIImage *)imageByDrawingCircleOnImage:(UIImage *)image size:(int)sliderValue;
- (UIImage*) rawImageRonchi:(UIImage *)image : (int)width : (int)height;
- (UIImage*) rawImageRonchiFullResolution:(UIImage *)image;

- (void)drawText:(CGFloat)xPosition yPosition:(CGFloat)yPosition canvasWidth:(CGFloat)canvasWidth canvasHeight:(CGFloat)canvasHeight textString: (NSString*) text;
- (void)drawRect:(CGRect)rect xPosition:(CGFloat)xPosition yPosition:(CGFloat)yPosition canvasWidth:(CGFloat)canvasWidth canvasHeight:(CGFloat)canvasHeight;
-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point;

@end

