//
//  PUGradientSlider.h
//  PUGradientSliderPro
//
//  Created by iMac on 17/02/21.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface PUGradientSlider : NSObject

+(void)setSliderWithFrame:(CGRect)frm sliderNamed:(UISlider *)slider withcolors:(NSArray *)arr thumbFrm:(CGRect)thumbframe thumbBgColor:(UIColor*)clr thumbImg:(UIImage *)img;

@end

