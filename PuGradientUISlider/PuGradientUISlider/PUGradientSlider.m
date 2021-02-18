//
//  PUGradientSlider.m
//  PUGradientSliderPro
//
//  Created by iMac on 17/02/21.
//

#import "PUGradientSlider.h"

@implementation PUGradientSlider

+(void)setSliderWithFrame:(CGRect)frm sliderNamed:(UISlider *)slider withcolors:(NSArray *)arr thumbFrm:(CGRect)thumbframe thumbBgColor:(UIColor*)clr thumbImg:(UIImage *)img
{
    CAGradientLayer *tgl = [CAGradientLayer layer];
    CGRect frame = frm;
    tgl.frame = frame;
    
    tgl.colors = arr;

    tgl.borderWidth = 1.5;
    tgl.borderColor = [UIColor whiteColor].CGColor;

    
    tgl.endPoint = CGPointMake(1.0, 1.0);
    tgl.startPoint = CGPointMake(0.0,1.0);
    tgl.masksToBounds = true;
    tgl.cornerRadius = frm.size.height/2;
    
    UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0);
    [tgl renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    dispatch_async(dispatch_get_main_queue(), ^(void){
        UIImage *trackImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        [slider setMinimumTrackImage:trackImage forState:UIControlStateNormal];
        [slider setMaximumTrackImage:trackImage forState:UIControlStateNormal];
    });
    
    UIImage *thumbImage = nil;
    if(img == nil)
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = CGPathCreateWithRect(thumbframe, nil);
        [shapeLayer setFillColor:[clr CGColor]];
        CALayer *thumb = [[CALayer alloc]init];
        thumb.frame = thumbframe;
        thumb.cornerRadius = thumbframe.size.width / 2;
        [thumb addSublayer:shapeLayer];
        UIGraphicsBeginImageContextWithOptions(thumb.frame.size, false, 0.0);
        [thumb renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
        thumbImage = [self circularScaleAndCropImage:thumbImage frame:thumbframe];
        
    }
    else
    {
        thumbImage = [self circularScaleAndCropImage:img frame:thumbframe];
    }
    [slider setThumbImage:thumbImage forState:UIControlStateNormal];
    [slider setThumbImage:thumbImage forState:UIControlStateHighlighted];
        
}
+ (UIImage*)circularScaleAndCropImage:(UIImage*)image frame:(CGRect)frame {
   
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(frame.size.width, frame.size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat rectWidth = frame.size.width;
    CGFloat rectHeight = frame.size.height;
    
    
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    
    
    CGFloat imageCentreX = rectWidth/2;
    CGFloat imageCentreY = rectHeight/2;
   
    CGFloat radius = rectWidth/2;
    CGContextBeginPath (context);
    CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
    CGContextClosePath (context);
    CGContextClip (context);
    
   
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    
    CGRect myRect = CGRectMake(0, 0, imageWidth, imageHeight);
    [image drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
