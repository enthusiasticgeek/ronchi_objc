//
//  ViewController.m
//  ronchi
//
//  Created by Pratik Tambe on 3/14/19.
//  Copyright © 2019 Pratik Tambe. All rights reserved.
//

//Based on code Written by Mark VandeWettering, https://github.com/brainwagon/ronchi/blob/master/ronchi.c


#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
- (UIImage*) rawImage: (int)width : (int)height;
- (UIImage*) scaleImage:(UIImage*)image toSize:(CGSize)newSize;
- (UIViewController*) topMostController;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background_image.jpg"] drawInRect:self.view.bounds];
    UIImage *background_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:background_image];
    
    UIGraphicsBeginImageContext(self.offsetLabel.frame.size);
    [[UIImage imageNamed:@"saturn.png"] drawInRect:self.view.bounds];
    UIImage *saturn_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.offsetLabel.backgroundColor = [UIColor colorWithPatternImage:saturn_image];
    self.diameterLabel.backgroundColor = [UIColor colorWithPatternImage:saturn_image];
    self.focalLengthLabel.backgroundColor = [UIColor colorWithPatternImage:saturn_image];
    self.gratingLabel.backgroundColor = [UIColor colorWithPatternImage:saturn_image];
    
    self.takePhotoButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
    self.selectPhotoButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
    self.savePhotoButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
    self.saveRonchiButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
    
    UIImage *normalThumbImage = [[UIImage imageNamed: @"purple_scrubber_control_normal_holo.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    UIImage *focusedThumbImage = [[UIImage imageNamed: @"purple_scrubber_control_focused_holo.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    UIImage *disabledThumbImage = [[UIImage imageNamed: @"purple_scrubber_control_disabled_holo.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    UIImage *pressedThumbImage = [[UIImage imageNamed: @"purple_scrubber_control_pressed_holo.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    [self.offsetSlider setThumbImage: normalThumbImage forState: UIControlStateNormal];
    [self.offsetSlider setThumbImage: focusedThumbImage forState: UIControlStateFocused];
    [self.offsetSlider setThumbImage: pressedThumbImage forState: UIControlStateSelected];
    [self.offsetSlider setThumbImage: disabledThumbImage forState: UIControlStateDisabled];
    
    [self.diameterSlider setThumbImage: normalThumbImage forState: UIControlStateNormal];
    [self.diameterSlider setThumbImage: focusedThumbImage forState: UIControlStateFocused];
    [self.diameterSlider setThumbImage: pressedThumbImage forState: UIControlStateSelected];
    [self.diameterSlider setThumbImage: disabledThumbImage forState: UIControlStateDisabled];
    
    [self.focalLengthSlider setThumbImage: normalThumbImage forState: UIControlStateNormal];
    [self.focalLengthSlider setThumbImage: focusedThumbImage forState: UIControlStateFocused];
    [self.focalLengthSlider setThumbImage: pressedThumbImage forState: UIControlStateSelected];
    [self.focalLengthSlider setThumbImage: disabledThumbImage forState: UIControlStateDisabled];
    
    [self.gratingSlider setThumbImage: normalThumbImage forState: UIControlStateNormal];
    [self.gratingSlider setThumbImage: focusedThumbImage forState: UIControlStateFocused];
    [self.gratingSlider setThumbImage: pressedThumbImage forState: UIControlStateSelected];
    [self.gratingSlider setThumbImage: disabledThumbImage forState: UIControlStateDisabled];
    
    UIImage *iconImage = [[UIImage imageNamed: @"ic_launcher.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];
    [self.iconView setImage:iconImage];
    
    self.ronchiView.alpha = 0.9;
    self.ronchiView.layer.cornerRadius = 5;
    self.ronchiView.layer.backgroundColor = [UIColor grayColor].CGColor;
    
    
    //Offset Range -7.0 to 7.0 inches
    [self.offsetSlider setContinuous: NO];
    self.offsetSlider.minimumValue = -7.0;
    self.offsetSlider.maximumValue = 7.0;
    self.offsetSlider.value = 0.0;
    
    //Diameter Range 1.5 to 26.5 inches
    [self.diameterSlider setContinuous: NO];
    self.diameterSlider.minimumValue = 1.5;
    self.diameterSlider.maximumValue = 26.5;
    self.diameterSlider.value = 6.0;
    
    //Focal Length Range 1.0 to 101.0 inches
    [self.focalLengthSlider setContinuous: NO];
    self.focalLengthSlider.minimumValue = 1.0;
    self.focalLengthSlider.maximumValue = 101.0;
    self.focalLengthSlider.value = 48.0;
    
    //Grating Range 20.0 to 300.0 inches
    [self.gratingSlider setContinuous: NO];
    self.gratingSlider.minimumValue = 20.0;
    self.gratingSlider.maximumValue = 300.0;
    self.gratingSlider.value = 100.0;
    
    //Values
    self.offset_fl = self.offsetSlider.value;
    self.diameter_fl = self.diameterSlider.value;
    self.focalLength_fl = self.focalLengthSlider.value;
    self.grating_fl = self.gratingSlider.value;
    
    //init text
    NSString* offsetString = @"";
    NSString* offsetTextString = [offsetString stringByAppendingFormat:@"%.2f",self.offsetSlider.value];
    self.offsetTextBox.text = offsetTextString;
    
    NSString* diameterString = @"";
    NSString* diameterTextString = [diameterString stringByAppendingFormat:@"%.2f",self.diameterSlider.value];
    self.diameterTextBox.text = diameterTextString;
    
    NSString* focalLengthString = @"";
    NSString* focalLengthTextString = [focalLengthString stringByAppendingFormat:@"%.2f",self.focalLengthSlider.value];
    self.focalLengthTextBox.text = focalLengthTextString;
    
    NSString* gratingString = @"";
    NSString* gratingTextString = [gratingString stringByAppendingFormat:@"%d",(int)self.gratingSlider.value];
    self.gratingTextBox.text = gratingTextString;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.wantsFullScreenLayout = YES;
        UIViewController* top = [self topMostController];
        [top presentModalViewController:picker animated:YES];
        //[self presentModalViewController:picker animated:YES];
        NSLog(@"Camera present!");
    }else{
        UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Camera Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        altnot.tag=103;
        [altnot show];
        NSLog(@"Camera *not* present!");
    }
    
    // setup the auto scroll label
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3.0f];
    //[UIView setAnimationDelay:3];
    self.infoView.alpha = 1.0f;
    [UIView commitAnimations];
    
    //offset Text Field Changed callback
    [self.offsetTextBox addTarget:self action:@selector(offsetTextBoxDidChange:) forControlEvents:UIControlEventEditingChanged];
    //diameter Text Field Changed callback
    [self.diameterTextBox addTarget:self action:@selector(diameterTextBoxDidChange:) forControlEvents:UIControlEventEditingChanged];
    //focal Length Text Field Changed callback
    [self.focalLengthTextBox addTarget:self action:@selector(focalLengthTextBoxDidChange:) forControlEvents:UIControlEventEditingChanged];
    //grating Text Field Changed callback
    [self.gratingTextBox addTarget:self action:@selector(gratingTextBoxDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //Initial Image
    [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];
    
    //Decorate Buttons and other widgets
    self.saveRonchiButton.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    self.saveRonchiButton.layer.shadowOffset = CGSizeMake(0, 4.0f);
    self.saveRonchiButton.layer.shadowOpacity = 1.0f;
    self.saveRonchiButton.layer.shadowRadius = 0.0f;
    self.saveRonchiButton.layer.masksToBounds = NO;
    self.saveRonchiButton.layer.cornerRadius = 4.0f;
    
    //Custom buttons
    self.takePhotoButton.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    self.takePhotoButton.layer.shadowOffset = CGSizeMake(0, 4.0f);
    self.takePhotoButton.layer.shadowOpacity = 1.0f;
    self.takePhotoButton.layer.shadowRadius = 0.0f;
    self.takePhotoButton.layer.masksToBounds = NO;
    self.takePhotoButton.layer.cornerRadius = 4.0f;
    
    self.savePhotoButton.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    self.savePhotoButton.layer.shadowOffset = CGSizeMake(0, 4.0f);
    self.savePhotoButton.layer.shadowOpacity = 1.0f;
    self.savePhotoButton.layer.shadowRadius = 0.0f;
    self.savePhotoButton.layer.masksToBounds = NO;
    self.savePhotoButton.layer.cornerRadius = 4.0f;
    
    self.selectPhotoButton.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    self.selectPhotoButton.layer.shadowOffset = CGSizeMake(0, 4.0f);
    self.selectPhotoButton.layer.shadowOpacity = 1.0f;
    self.selectPhotoButton.layer.shadowRadius = 0.0f;
    self.selectPhotoButton.layer.masksToBounds = NO;
    self.selectPhotoButton.layer.cornerRadius = 4.0f;
    
    //refresh
    [self.imageView setNeedsDisplay];
    [self.ronchiView setNeedsDisplay];
    [self.iconView setNeedsDisplay];
}

- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIViewController* top = [self topMostController];
    [top presentViewController:picker animated:YES completion:NULL];
    //[self presentViewController:picker animated:NO completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIViewController* top = [self topMostController];
    [top presentViewController:picker animated:YES completion:NULL];
    //[self presentViewController:picker animated:NO completion:NULL];
}

- (IBAction)savePhoto:(UIButton *)sender{
    NSLog(@"Saving Photo...");
    [self saveImage2: self.imageView.image];
}

- (IBAction)saveRonchi:(UIButton *)sender{
    NSLog(@"Saving Ronchi...");
    [self saveImage2: self.ronchiView.image];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)offsetSliderMoved:(id)sender {
    float sliderValue =  self.offsetSlider.value;
    NSLog(@"offset slider: %.2f", sliderValue);
    self.offset_fl = sliderValue;
    /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
    self.ronchiView.image = ronchi;*/
    //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
    
    [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];
    
    NSString* labelString = @"";
    labelString = [labelString stringByAppendingFormat:@"Offset: %.2f ",sliderValue];
    self.offsetLabel.text = labelString;
    
    NSString* offsetString = @"";
    NSString* offsetTextString = [offsetString stringByAppendingFormat:@"%.2f",self.offsetSlider.value];
    self.offsetTextBox.text = offsetTextString;
}

- (IBAction)diameterSliderMoved:(id)sender {
    float sliderValue =  self.diameterSlider.value;
    self.diameter_fl = sliderValue;
    NSLog(@"diameter slider: %.2f", sliderValue);
    /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
    self.ronchiView.image = ronchi;*/
    //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
    
    [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];

    NSString* labelString = @"";
    labelString = [labelString stringByAppendingFormat:@"Diameter: %.2f ",sliderValue];
    self.diameterLabel.text = labelString;
    
    NSString* diameterString = @"";
    NSString* diameterTextString = [diameterString stringByAppendingFormat:@"%.2f",self.diameterSlider.value];
    self.diameterTextBox.text = diameterTextString;
}

- (IBAction)focalLengthSliderMoved:(id)sender {
    float sliderValue =  self.focalLengthSlider.value;
    self.focalLength_fl = sliderValue;
    NSLog(@"focal length slider: %.2f", sliderValue);
    /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
    self.ronchiView.image = ronchi;*/
    //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
    
    [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];

    NSString* labelString = @"";
    labelString = [labelString stringByAppendingFormat:@"Focal Length: %.2f ",sliderValue];
    self.focalLengthLabel.text = labelString;
    
    NSString* focalLengthString = @"";
    NSString* focalLengthTextString = [focalLengthString stringByAppendingFormat:@"%.2f",self.focalLengthSlider.value];
    self.focalLengthTextBox.text = focalLengthTextString;
}

- (IBAction)gratingSliderMoved:(id)sender {
    int sliderValue =  self.gratingSlider.value;
    self.grating_fl = sliderValue;
    NSLog(@"grating slider: %d", sliderValue);
    /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
    self.ronchiView.image = ronchi;*/
    //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
    
    [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];

    NSString* labelString = @"";
    labelString = [labelString stringByAppendingFormat:@"Grating: %d ",sliderValue];
    self.gratingLabel.text = labelString;
    
    NSString* gratingString = @"";
    NSString* gratingTextString = [gratingString stringByAppendingFormat:@"%d",(int)self.gratingSlider.value];
    self.gratingTextBox.text = gratingTextString;
}

void VecNormalize(Vec a)
{
    double l = VecLen(a) ;
    
    a[0] /= l ; a[1] /= l ; a[2] /= l ;
}

void VecSub(Vec r, Vec a, Vec b)
{
    r[0] = a[0] - b[0] ;
    r[1] = a[1] - b[1] ;
    r[2] = a[2] - b[2] ;
}

void Reflect(Vec R, Vec I, Vec N)
{
    double c = -2.0 * VecDot(I, N) ;
    R[0] = c * N[0] + I[0] ;
    R[1] = c * N[1] + I[1] ;
    R[2] = c * N[2] + I[2] ;
    VecNormalize(R);
}


- (UIImage*) rawImage: (int)width : (int)height
{
    //height and width are integers denoting the dimensions of the image
    NSMutableData* myData = [[NSMutableData alloc] initWithCapacity:height * width * 4];
    
    int x, y ;
    Vec I, N, R, P, O ;
    double r, fx, fy, gx, t ;
    
    r = self.diameter_fl / 2 ;
    
    O[0] = O[1] = 0.0 ;
    O[2] = 2.0 * self.focalLength_fl + self.offset_fl ;
    
    for (y=0; y<width; y++) {
        fy = y * self.diameter_fl / width - self.diameter_fl / 2.0 ;
        for (x=0; x<height; x++) {
            fx = x * self.diameter_fl / height - self.diameter_fl / 2.0 ;
            if (fx*fx+fy*fy>r*r) {
                //putchar(0) ;
                //[myData appendBytes:"\x0\x0\x0\x0" length:4];
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
                continue ;
            }
            // construct P
            P[0] = fx ;
            P[1] = fy ;
            
            if (fabs(K+1.0) < 1e-5){
                P[2] = (fx*fx+fy*fy)/(4.0 * self.focalLength_fl) ;
            }else{
                P[2] = (2*self.focalLength_fl - sqrt((K + 1)*(-fx*fx - fy*fy) + 4*self.focalLength_fl*self.focalLength_fl)) / (K + 1) ;
            }
            // I starts at O and ends at P
            VecSub(I, P, O) ;
            VecNormalize(I) ;
            
            N[0] = -2.0 * P[0] ;
            N[1] = -2.0 * P[1] ;
            N[2] = 4.0 * self.focalLength_fl - 2.0 * (K + 1) * P[2] ;
            VecNormalize(N) ;
            
            Reflect(R, I, N) ;
            
            // compute the intersection of R
            //with the plane z = R + offset
            //
            t = (2.0 * self.focalLength_fl + self.offset_fl - P[2]) / R[2] ;
            
            if(t <= 0.0){
                t = 0.1;
            }
            //assert(t > 0.0) ;
            
            gx = (P[0] + t * R[0]) * 2.0 * self.grating_fl - 0.5 ;
            
            if (((int)floorf(gx)) & 1){
                //putchar(255) ;
                [myData appendBytes:"\x00\xff\xff\xff" length:4];
            }else{
                //putchar(32) ;
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
            }
        }
    }
    unsigned char *rawData = myData.mutableBytes;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              rawData,
                                                              width*height*4,
                                                              NULL);
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4*width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little;   // BGRA. Must unpremultiply the image.
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width,
                                            height,
                                            bitsPerComponent,
                                            bitsPerPixel,
                                            bytesPerRow,colorSpaceRef,
                                            bitmapInfo,
                                            provider,NULL,NO,renderingIntent);
    
 /*
    CGBitmapInfo bitmapInfo = kCGImageAlphaNone;
    if (channels == 3) {
        bitmapInfo = kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little;        // BGRX. CV_BGRA2BGR will discard the uninitialized alpha channel data.
    } else if (channels == 4) {
        bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little;   // BGRA. Must unpremultiply the image.
    }
    
    CGColorSpaceRef colorSpace = (channels == 1) ? CGColorSpaceCreateDeviceGray() : CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(iplImage->imageData,
                                                       iplImage->width,
                                                       iplImage->height,
                                                       iplImage->depth,
                                                       iplImage->widthStep,
                                                       colorSpace,
                                                       bitmapInfo);
*/
    
    // Convert back to UIImage
    //UIImage* ronchi = [UIImage imageWithCGImage:imageRef];
    //[self.ronchiView setImage:ronchi];
    
    //I get the current dimensions displayed here
    NSLog(@"width=%zu, height: %zu", CGImageGetWidth(imageRef),
          CGImageGetHeight(imageRef) );
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    //[self.ronchiView setImage: newImage ];
    NSLog(@"resultImg width:%f, height:%f",
          newImage.size.width,newImage.size.height);
    // Release
    CGDataProviderRelease(provider);
    // Clean up reference pointers
    CGImageRelease(imageRef);
    
    return newImage;
}

- (UIImage*) scaleImage:(UIImage*)image toSize:(CGSize)newSize
{
    CGSize imageSize = image.size;
    CGFloat newWidth  = newSize.width  / image.size.width;
    CGFloat newHeight = newSize.height / image.size.height;
    CGSize newImgSize;
    if(newWidth > newHeight) {
        newImgSize = CGSizeMake(imageSize.width * newHeight, imageSize.height * newHeight);
    } else {
        newImgSize = CGSizeMake(imageSize.width * newWidth,  imageSize.height * newWidth);
    }
    CGRect rect = CGRectMake(0, 0, newImgSize.width, newImgSize.height);
    UIGraphicsBeginImageContextWithOptions(newImgSize, false, 0.0);
    [image drawInRect:rect];;
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          @"test.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}

-(void) saveImage2: (UIImage*) image
{
    //UIImage *image = [UIImage imageNamed:@"someImage.png"];
    if (image != nil){
        NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        // NSTimeInterval is defined as double
        NSString *RonchiImage = [NSString stringWithFormat:@"Ronchi%@.png", [NSNumber numberWithDouble: timeStamp], nil];
        // Write image to PNG
        [UIImagePNGRepresentation(image) writeToFile:RonchiImage atomically:YES];
        //[UIImagePNGRepresentation(image) writeToFile:@"someimage.png" atomically:YES];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
}

-(void)saveImage1: (UIImage*) image
{
    if(image != nil){
        // Create paths to output images
        NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.png"];
        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"];
        
        // Write a UIImage to JPEG with minimum compression (best quality)
        // The value 'image' must be a UIImage object
        // The value '1.0' represents image compression quality as value from 0.0 to 1.0
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:jpgPath atomically:YES];
        
        // Write image to PNG
        [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
        
        // Let's check to see if files were successfully written...
        
        // Create file manager
        NSError *error;
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        // Point to Document directory
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        // Write out the contents of home directory to console
        NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
    }
}


-(void)offsetTextBoxDidChange :(UITextField *) textField
{
    Boolean error=true;
    //your code
    NSLog(@"offsetTextFinished Event fired");
    NSString *str = self.offsetTextBox.text;
    float number = [str floatValue];
    if(number < self.offsetSlider.minimumValue){
        number = self.offsetSlider.minimumValue;
    } else if (number > self.offsetSlider.maximumValue) {
        number = self.offsetSlider.maximumValue;
    }
    if ((number >= self.offsetSlider.minimumValue)&&(number <= self.offsetSlider.maximumValue)){
        error = false;
    }
    if(error==false){
        NSString* labelString = @"";
        labelString = [labelString stringByAppendingFormat:@"Offset: %.2f",number];
        self.offsetLabel.text = labelString;
        NSLog(@"%@",self.offsetTextBox.text);
        self.offsetSlider.value = number;
        self.offset_fl = number;
        /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
        self.ronchiView.image = ronchi;*/
        //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
        
        [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];

    } else {
        NSString* labelString = @"";
        labelString = [labelString stringByAppendingFormat:@"Offset: [%.2f,%.2f]",self.offsetSlider.minimumValue, self.offsetSlider.maximumValue];
        self.offsetLabel.text = labelString;
    }
}

-(void)diameterTextBoxDidChange :(UITextField *) textField
{
    Boolean error=true;
    //your code
    NSLog(@"diameterTextFinished Event fired");
    NSString *str = self.diameterTextBox.text;
    float number = [str floatValue];
    if(number < self.diameterSlider.minimumValue){
        number = self.diameterSlider.minimumValue;
    } else if (number > self.diameterSlider.maximumValue) {
        number = self.diameterSlider.maximumValue;
    }
    if ((number >= self.diameterSlider.minimumValue)&&(number <= self.diameterSlider.maximumValue)){
        error = false;
    }
    if(error==false){
        NSString* labelString = @"";
        labelString = [labelString stringByAppendingFormat:@"Diameter: %.2f",number];
        self.diameterLabel.text = labelString;
        NSLog(@"%@",self.diameterTextBox.text);
        self.diameterSlider.value = number;
        self.diameter_fl = number;
        /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
        self.ronchiView.image = ronchi;*/
        //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
        
        [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];

    } else {
        NSString* labelString = @"";
        labelString = [labelString stringByAppendingFormat:@"Diameter: [%.2f,%.2f]",self.diameterSlider.minimumValue, self.diameterSlider.maximumValue];
        self.diameterLabel.text = labelString;
    }
}

-(void)focalLengthTextBoxDidChange :(UITextField *) textField
{
    Boolean error=true;
    //your code
    NSLog(@"focalLengthTextFinished Event fired");
    NSString *str = self.focalLengthTextBox.text;
    float number = [str floatValue];
    if(number < self.focalLengthSlider.minimumValue){
        number = self.focalLengthSlider.minimumValue;
    } else if (number > self.focalLengthSlider.maximumValue) {
        number = self.focalLengthSlider.maximumValue;
    }
    if ((number >= self.focalLengthSlider.minimumValue)&&(number <= self.focalLengthSlider.maximumValue)){
        error = false;
    }
    if(error==false){
        NSString* labelString = @"";
        labelString = [labelString stringByAppendingFormat:@"Focal Length: %.2f",number];
        self.focalLengthLabel.text = labelString;
        NSLog(@"%@",self.focalLengthTextBox.text);
        self.focalLengthSlider.value = number;
        self.focalLength_fl = number;
        /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
        self.ronchiView.image = ronchi;*/
        //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
        
        [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];

    } else {
        NSString* labelString = @"";
        labelString = [labelString stringByAppendingFormat:@"Focal Length: [%d,%d]",(int)self.focalLengthSlider.minimumValue, (int)self.focalLengthSlider.maximumValue];
        self.focalLengthLabel.text = labelString;
    }
}

-(void)gratingTextBoxDidChange :(UITextField *) textField
{
    Boolean error=true;
    //your code
    NSLog(@"gratingTextFinished Event fired");
    NSString *str = self.gratingTextBox.text;
    int number = [str intValue];
    if(number < self.gratingSlider.minimumValue){
        number = self.gratingSlider.minimumValue;
    } else if (number > self.gratingSlider.maximumValue) {
        number = self.gratingSlider.maximumValue;
    }
    if ((number >= self.gratingSlider.minimumValue)&&(number <= self.gratingSlider.maximumValue)){
        error = false;
    }
    if(error==false){
       NSString* labelString = @"";
       labelString = [labelString stringByAppendingFormat:@"Grating: %d",number];
       self.gratingLabel.text = labelString;
       NSLog(@"%@",self.gratingTextBox.text);
       self.gratingSlider.value = number;
       self.grating_fl = number;
       /*UIImage *ronchi = [self rawImage:RESOLUTION:RESOLUTION];
       self.ronchiView.image = ronchi;*/
        //[self.ronchiView setImage:[self rawImageRonchi:self.ronchiView.image : self.ronchiView.frame.size.width : self.ronchiView.frame.size.height]];
        
        [self.ronchiView setImage:[self rawImageRonchiFullResolution: self.ronchiView.image]];

    } else {
        NSString* labelString = @"";
        labelString = [labelString stringByAppendingFormat:@"Grating: [%d,%d]",(int)self.gratingSlider.minimumValue, (int)self.gratingSlider.maximumValue];
        self.gratingLabel.text = labelString;
    }
}

- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


////Test Function
- (UIImage *)imageByDrawingCircleOnImage:(UIImage *)image size:(int)sliderValue
{
    // begin a graphics context of sufficient size
    //UIGraphicsBeginImageContext(image.size);
    
    UIGraphicsBeginImageContext(CGSizeMake(self.ronchiView.frame.size.width, self.ronchiView.frame.size.height));
    //UIGraphicsBeginImageContext(CGSizeMake(RESOLUTION,RESOLUTION));
    
    // draw original image into the context
    [image drawAtPoint:CGPointZero];
    
    // get the context for CoreGraphics
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // set stroking color and draw circle
    [[UIColor redColor] setStroke];
    
    // make circle rect 5 px from border
    //CGRect circleRect = CGRectMake(0, 0,
    //                               image.size.width,
    //                               image.size.height);
    
    
    CGPoint point = CGPointMake(40,40);
    CGContextDrawLayerAtPoint(ctx, point, NULL);
    
    CGRect circleRect = CGRectMake(0, 0,
                                   sliderValue,
                                   sliderValue);
    circleRect = CGRectInset(circleRect, 5, 5);
    
    // draw circle
    CGContextStrokeEllipseInRect(ctx, circleRect);
    
   
    
    // make image out of bitmap context
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // free the context
    UIGraphicsEndImageContext();
    
    return retImage;
}

- (UIImage*) rawImageRonchiFullResolution:(UIImage *)image
{
    int width = RESOLUTION;
    int height = RESOLUTION;
    // begin a graphics context of sufficient size
    //UIGraphicsBeginImageContext(image.size);
    //Allocate heap context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    //UIGraphicsBeginImageContext(CGSizeMake(RESOLUTION,RESOLUTION));
    
    // draw original image into the context
    [image drawAtPoint:CGPointZero];
    
    // get the context for CoreGraphics
    //CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //height and width are integers denoting the dimensions of the image
    //ARC to release heap
    NSMutableData* myData = [[NSMutableData alloc] initWithCapacity:height * width * 4];
    
    int x, y ;
    Vec I, N, R, P, O ;
    double r, fx, fy, gx, t ;
    
    r = self.diameter_fl / 2 ;
    
    O[0] = O[1] = 0.0 ;
    O[2] = 2.0 * self.focalLength_fl + self.offset_fl ;
    
    for (y=0; y<width; y++) {
        fy = y * self.diameter_fl / width - self.diameter_fl / 2.0 ;
        for (x=0; x<height; x++) {
            fx = x * self.diameter_fl / height - self.diameter_fl / 2.0 ;
            if (fx*fx+fy*fy>r*r) {
                //putchar(0) ;
                //[myData appendBytes:"\x0\x0\x0\x0" length:4];
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
                continue ;
            }
            // construct P
            P[0] = fx ;
            P[1] = fy ;
            
            if (fabs(K+1.0) < 1e-5){
                P[2] = (fx*fx+fy*fy)/(4.0 * self.focalLength_fl) ;
            }else{
                P[2] = (2*self.focalLength_fl - sqrt((K + 1)*(-fx*fx - fy*fy) + 4*self.focalLength_fl*self.focalLength_fl)) / (K + 1) ;
            }
            // I starts at O and ends at P
            VecSub(I, P, O) ;
            VecNormalize(I) ;
            
            N[0] = -2.0 * P[0] ;
            N[1] = -2.0 * P[1] ;
            N[2] = 4.0 * self.focalLength_fl - 2.0 * (K + 1) * P[2] ;
            VecNormalize(N) ;
            
            Reflect(R, I, N) ;
            
            // compute the intersection of R
            //with the plane z = R + offset
            //
            t = (2.0 * self.focalLength_fl + self.offset_fl - P[2]) / R[2] ;
            
            if(t <= 0.0){
                t = 0.1;
            }
            //assert(t > 0.0) ;
            
            gx = (P[0] + t * R[0]) * 2.0 * self.grating_fl - 0.5 ;
            
            if (((int)floorf(gx)) & 1){
                //putchar(255) ;
                [myData appendBytes:"\x00\xff\xff\xff" length:4];
            }else{
                //putchar(32) ;
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
            }
        }
    }
    unsigned char *rawData = myData.mutableBytes;
    //Allocate heap for CGDataProviderRef
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              rawData,
                                                              width*height*4,
                                                              NULL);
    int bitsPerComponent = 8;
    //int bitsPerPixel = 32;
    int bytesPerRow = 4*width;
    
    //Allocate heap for CGColorSpaceRef
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little;   // BGRA. Must unpremultiply the image.
    //CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    //Allocate heap for CGContextRef
    CGContextRef bitmapContext = CGBitmapContextCreate(rawData,
                                                       width,
                                                       height,
                                                       bitsPerComponent,
                                                       bytesPerRow,
                                                       colorSpaceRef,
                                                       bitmapInfo);
    
    // Copy the source bitmap into the destination, ignoring any data in the uninitialized destination
    //CGContextSetBlendMode(bitmapContext, kCGBlendModeCopy);

    CGContextSetRGBFillColor(bitmapContext, 0.0, 0.0, 1.0, 1);
    NSString* parameters = [NSString stringWithFormat:@"[OFF: %.2f] [DIA: %.2f] [FOC: %.2f] [GRAT: %d]", self.offset_fl, self.diameter_fl, self.focalLength_fl, self.grating_fl];
    
    char* text    = (char *)[parameters cStringUsingEncoding:NSASCIIStringEncoding];// "05/05/09";
    CGContextSelectFont(bitmapContext, "Arial", 20, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(bitmapContext, kCGTextFill);
    CGContextSetRGBFillColor(bitmapContext, 0, 255, 0, 1);
    //rotate text
    //CGContextSetTextMatrix(bitmapContext, CGAffineTransformMakeRotation( -M_PI/4 ));
    CGContextShowTextAtPoint(bitmapContext, 4, 4, text, strlen(text));
    
    //Create an CGImageRef from bitmapContext
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // make image out of bitmap context
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGSize scale = CGSizeMake(self.ronchiView.frame.size.width, self.ronchiView.frame.size.height);
    UIImage * finalImage = [self  scaleImage: newImage toSize: scale];
    
    //[self drawText:@"hello" inImage:finalImage atPoint:CGPointMake(0, 0)];
    
    //UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //[self.ronchiView setImage: newImage ];
    NSLog(@"resultImg width:%f, height:%f",
          newImage.size.width,newImage.size.height);
    // Release heap
    CGDataProviderRelease(provider);
    // Clean up reference pointers (heap)
    CGImageRelease(imageRef);
    // Drawing CGImage to CGContext (heap)
    CGContextRelease(bitmapContext);
    // free the context (heap)
    UIGraphicsEndImageContext();
    
    return finalImage;
}


- (UIImage*) rawImageRonchi:(UIImage *)image : (int)width : (int)height
{
    
    // begin a graphics context of sufficient size
    //UIGraphicsBeginImageContext(image.size);
    //Allocate heap context
    UIGraphicsBeginImageContext(CGSizeMake(self.ronchiView.frame.size.width, self.ronchiView.frame.size.height));
    //UIGraphicsBeginImageContext(CGSizeMake(RESOLUTION,RESOLUTION));
    
    // draw original image into the context
    [image drawAtPoint:CGPointZero];
    
    // get the context for CoreGraphics
    //CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //height and width are integers denoting the dimensions of the image
    //ARC to release heap
    NSMutableData* myData = [[NSMutableData alloc] initWithCapacity:height * width * 4];
    
    int x, y ;
    Vec I, N, R, P, O ;
    double r, fx, fy, gx, t ;
    
    r = self.diameter_fl / 2 ;
    
    O[0] = O[1] = 0.0 ;
    O[2] = 2.0 * self.focalLength_fl + self.offset_fl ;
    
    for (y=0; y<width; y++) {
        fy = y * self.diameter_fl / width - self.diameter_fl / 2.0 ;
        for (x=0; x<height; x++) {
            fx = x * self.diameter_fl / height - self.diameter_fl / 2.0 ;
            if (fx*fx+fy*fy>r*r) {
                //putchar(0) ;
                //[myData appendBytes:"\x0\x0\x0\x0" length:4];
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
                continue ;
            }
            // construct P
            P[0] = fx ;
            P[1] = fy ;
            
            if (fabs(K+1.0) < 1e-5){
                P[2] = (fx*fx+fy*fy)/(4.0 * self.focalLength_fl) ;
            }else{
                P[2] = (2*self.focalLength_fl - sqrt((K + 1)*(-fx*fx - fy*fy) + 4*self.focalLength_fl*self.focalLength_fl)) / (K + 1) ;
            }
            // I starts at O and ends at P
            VecSub(I, P, O) ;
            VecNormalize(I) ;
            
            N[0] = -2.0 * P[0] ;
            N[1] = -2.0 * P[1] ;
            N[2] = 4.0 * self.focalLength_fl - 2.0 * (K + 1) * P[2] ;
            VecNormalize(N) ;
            
            Reflect(R, I, N) ;
            
            // compute the intersection of R
            //with the plane z = R + offset
            //
            t = (2.0 * self.focalLength_fl + self.offset_fl - P[2]) / R[2] ;
            
            if(t <= 0.0){
                t = 0.1;
            }
            //assert(t > 0.0) ;
            
            gx = (P[0] + t * R[0]) * 2.0 * self.grating_fl - 0.5 ;
            
            if (((int)floorf(gx)) & 1){
                //putchar(255) ;
                [myData appendBytes:"\x00\xff\xff\xff" length:4];
            }else{
                //putchar(32) ;
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
            }
        }
    }
    unsigned char *rawData = myData.mutableBytes;
    //Allocate heap for CGDataProviderRef
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              rawData,
                                                              width*height*4,
                                                              NULL);
    int bitsPerComponent = 8;
    //int bitsPerPixel = 32;
    int bytesPerRow = 4*width;
    
    //Allocate heap for CGColorSpaceRef
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little;   // BGRA. Must unpremultiply the image.
    //CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    //Allocate heap for CGContextRef
    CGContextRef bitmapContext = CGBitmapContextCreate(rawData,
                                                       width,
                                                       height,
                                                       bitsPerComponent,
                                                       bytesPerRow,
                                                       colorSpaceRef,
                                                       bitmapInfo);
    
    // Copy the source bitmap into the destination, ignoring any data in the uninitialized destination
    //CGContextSetBlendMode(bitmapContext, kCGBlendModeCopy);
    
    //Create an CGImageRef from bitmapContext
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // make image out of bitmap context
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    //UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //[self.ronchiView setImage: newImage ];
    NSLog(@"resultImg width:%f, height:%f",
          newImage.size.width,newImage.size.height);
    // Release heap
    CGDataProviderRelease(provider);
    // Clean up reference pointers (heap)
    CGImageRelease(imageRef);
    // Drawing CGImage to CGContext (heap)
    CGContextRelease(bitmapContext);
    // free the context (heap)
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*) rawImageRonchiOrig:(UIImage *)image : (int)width : (int)height
{
    
    // begin a graphics context of sufficient size
    //UIGraphicsBeginImageContext(image.size);
    //Allocate heap context
    UIGraphicsBeginImageContext(CGSizeMake(self.ronchiView.frame.size.width, self.ronchiView.frame.size.height));
    //UIGraphicsBeginImageContext(CGSizeMake(RESOLUTION,RESOLUTION));
    
    // draw original image into the context
    [image drawAtPoint:CGPointZero];
    
    // get the context for CoreGraphics
    //CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //height and width are integers denoting the dimensions of the image
    //ARC to release heap
    NSMutableData* myData = [[NSMutableData alloc] initWithCapacity:height * width * 4];
    
    int x, y ;
    Vec I, N, R, P, O ;
    double r, fx, fy, gx, t ;
    
    r = self.diameter_fl / 2 ;
    
    O[0] = O[1] = 0.0 ;
    O[2] = 2.0 * self.focalLength_fl + self.offset_fl ;
    
    for (y=0; y<width; y++) {
        fy = y * self.diameter_fl / width - self.diameter_fl / 2.0 ;
        for (x=0; x<height; x++) {
            fx = x * self.diameter_fl / height - self.diameter_fl / 2.0 ;
            if (fx*fx+fy*fy>r*r) {
                //putchar(0) ;
                //[myData appendBytes:"\x0\x0\x0\x0" length:4];
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
                continue ;
            }
            // construct P
            P[0] = fx ;
            P[1] = fy ;
            
            if (fabs(K+1.0) < 1e-5){
                P[2] = (fx*fx+fy*fy)/(4.0 * self.focalLength_fl) ;
            }else{
                P[2] = (2*self.focalLength_fl - sqrt((K + 1)*(-fx*fx - fy*fy) + 4*self.focalLength_fl*self.focalLength_fl)) / (K + 1) ;
            }
            // I starts at O and ends at P
            VecSub(I, P, O) ;
            VecNormalize(I) ;
            
            N[0] = -2.0 * P[0] ;
            N[1] = -2.0 * P[1] ;
            N[2] = 4.0 * self.focalLength_fl - 2.0 * (K + 1) * P[2] ;
            VecNormalize(N) ;
            
            Reflect(R, I, N) ;
            
            // compute the intersection of R
            //with the plane z = R + offset
            //
            t = (2.0 * self.focalLength_fl + self.offset_fl - P[2]) / R[2] ;
            
            if(t <= 0.0){
                t = 0.1;
            }
            //assert(t > 0.0) ;
            
            gx = (P[0] + t * R[0]) * 2.0 * self.grating_fl - 0.5 ;
            
            if (((int)floorf(gx)) & 1){
                //putchar(255) ;
                [myData appendBytes:"\x00\xff\xff\xff" length:4];
            }else{
                //putchar(32) ;
                [myData appendBytes:"\x00\x00\x00\xff" length:4];
            }
        }
    }
    unsigned char *rawData = myData.mutableBytes;
    //Allocate heap for CGDataProviderRef
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              rawData,
                                                              width*height*4,
                                                              NULL);
    int bitsPerComponent = 8;
    //int bitsPerPixel = 32;
    int bytesPerRow = 4*width;
    
    //Allocate heap for CGColorSpaceRef
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little;   // BGRA. Must unpremultiply the image.
    //CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    //Allocate heap for CGContextRef
    CGContextRef bitmapContext = CGBitmapContextCreate(rawData,
                                                       width,
                                                       height,
                                                       bitsPerComponent,
                                                       bytesPerRow,
                                                       colorSpaceRef,
                                                       bitmapInfo);
    
    // Copy the source bitmap into the destination, ignoring any data in the uninitialized destination
    //CGContextSetBlendMode(bitmapContext, kCGBlendModeCopy);
    
    //Create an CGImageRef from bitmapContext
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // make image out of bitmap context
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    //UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //[self.ronchiView setImage: newImage ];
    NSLog(@"resultImg width:%f, height:%f",
          newImage.size.width,newImage.size.height);
    // Release heap
    CGDataProviderRelease(provider);
    // Clean up reference pointers (heap)
    CGImageRelease(imageRef);
    // Drawing CGImage to CGContext (heap)
    CGContextRelease(bitmapContext);
    // free the context (heap)
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.offsetTextBox resignFirstResponder];
    [self.diameterTextBox resignFirstResponder];
    [self.focalLengthTextBox resignFirstResponder];
    [self.gratingTextBox resignFirstResponder];
    
    [self.view endEditing:YES];
    NSLog(@"keyboard dismissed");
    return YES;
}

//This wierd hack with DismissAreaButton was adapted from https://pinkstone.co.uk/how-to-dismiss-the-keyboard-from-a-uitextfield-in-ios/
- (IBAction)dismissKeyboard:(id)sender {
    [self textFieldShouldReturn:self.offsetTextBox];
}

- (void)drawText:(CGFloat)xPosition yPosition:(CGFloat)yPosition canvasWidth:(CGFloat)canvasWidth canvasHeight:(CGFloat)canvasHeight textString: (NSString*) text
{
    //Draw Text
    CGRect textRect = CGRectMake(xPosition, yPosition, canvasWidth, canvasHeight);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 50], NSForegroundColorAttributeName: UIColor.redColor, NSParagraphStyleAttributeName: textStyle};
    
    [text drawInRect: textRect withAttributes: textFontAttributes];
}

- (void)drawRect:(CGRect)rect xPosition:(CGFloat)xPosition yPosition:(CGFloat)yPosition canvasWidth:(CGFloat)canvasWidth canvasHeight:(CGFloat)canvasHeight{
    //[self drawText:x yPosition:y canvasWidth:width canvasHeight:height];
}

-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
