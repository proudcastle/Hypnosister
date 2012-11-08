//
//  BNRLogo.m
//  Hypnosister
//
//  Created by Markus Stolzenburg on 08.11.12.
//  Copyright (c) 2012 Markus Stolzenburg. All rights reserved.
//

#import "BNRLogo.h"

@implementation BNRLogo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _logo = [UIImage imageNamed:@"Icon.png"];
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = CGRectMake(0, 0, _logo.size.width, _logo.size.height);
    
    CGContextSaveGState(ctx);
    
    
    CGContextAddEllipseInRect(ctx, bounds);
    // Clip content to stroke
    CGContextClip(ctx);
    
    CGPoint drawPoint = CGPointMake(0, 0);
    [_logo drawAtPoint:drawPoint];
        
    // The radius of the circle should be nearly as big as the view
    float maxRadius = bounds.size.width / 2.0;
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
        
    CGGradientRef blueWhiteGradient;
    CGColorSpaceRef rgbColorSpace;
    CGFloat locations[2] = {0.0, 0.6};
    CGFloat components[8] = {0.0f, 0.0f, 1.0f, 0.35f,    //  Start color
                             0.0f, 0.0f, 1.0f, 0.0f};    //  End Color
    size_t numLocations = 2;
    
    rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    blueWhiteGradient = CGGradientCreateWithColorComponents(rgbColorSpace,
                                                            components,
                                                            locations,
                                                            numLocations);
    
    CGPoint startPoint, endPoint;
    startPoint.x = bounds.origin.y;
    startPoint.y = 0.0f;
    endPoint.x = 1.0f;
    endPoint.y = bounds.origin.y + bounds.size.height;
    
    CGContextDrawLinearGradient(ctx,
                                blueWhiteGradient,
                                startPoint,
                                endPoint,
                                0);
    
    CGGradientRelease(blueWhiteGradient);
    CGColorSpaceRelease(rgbColorSpace);
    
    CGContextRestoreGState(ctx);
    
    // Set the fill color of the current context to black
    [[UIColor blackColor] setFill];
    
    // The shadow will move 4 points to the right and 3 points down from the text
    CGSize offset = CGSizeMake(0, 2);
    
    // The shadow will be dark gray in color
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    
    // Set the shadow of the context with these parameters
    // all subsequent drawing will be shadowed
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    
    // The thickness of the line should be 10 points wide
    CGContextSetLineWidth(ctx, 1.0);
    
    //Add a path to the context
    CGContextAddArc(ctx, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);
    
    // Set color for stroke
    [[UIColor blackColor] setStroke];
    
    // Perform drawing instruction; removes path
    CGContextStrokePath(ctx);
    
    
}


@end
