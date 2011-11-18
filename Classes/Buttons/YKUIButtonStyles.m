//
//  YKUIButtonStyles.m
//  YelpKit
//
//  Created by Gabriel Handford on 10/25/11.
//  Copyright (c) 2011 Yelp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "YKUIButtonStyles.h"


@implementation YKUIButtonStyles

+ (void)setStyle:(YKUIButtonStyle)style button:(YKUIButton *)button {
  switch (style) {
    case YKUIButtonStyleNone:
      button.titleColor = [UIColor blackColor];
      button.titleInsets = UIEdgeInsetsZero;
      button.titleFont = [UIFont boldSystemFontOfSize:14.0];
      button.titleShadowColor = nil;
      button.color = nil;
      button.color2 = nil;
      
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.highlightedColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];

      [button setBorderStyle:YKUIBorderStyleNone color:nil width:0 alternateWidth:0 cornerRadius:0];
      break;
      
    case YKUIButtonStyleBasic:
      button.titleColor = [UIColor colorWithRed:(77.0/255.0) green:(95.0/255.0) blue:(154.0/255.0) alpha:1];
      button.titleInsets = UIEdgeInsetsZero;
      button.titleFont = [UIFont boldSystemFontOfSize:14.0];
      button.titleShadowColor = nil;
      button.titleShadowOffset = CGSizeZero;
      button.color = [UIColor whiteColor];          
      button.color2 = nil;
      button.shadingType = YKUIShadingTypeNone;      
      
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.highlightedColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      [button setBorderStyle:YKUIBorderStyleRounded color:[UIColor colorWithRed:0.659 green:0.671 blue:0.678 alpha:1.0] width:1.0 alternateWidth:0 cornerRadius:10.0];
      break;
      
    case YKUIButtonStyleBasicGrouped:
      button.titleColor = [UIColor colorWithRed:(77.0/255.0) green:(95.0/255.0) blue:(154.0/255.0) alpha:1];
      button.titleInsets = UIEdgeInsetsZero;
      button.titleFont = [UIFont boldSystemFontOfSize:14.0];
      button.titleShadowColor = nil;
      button.titleShadowOffset = CGSizeZero;
      button.color = [UIColor whiteColor];
      button.color2 = nil;
      button.shadingType = YKUIShadingTypeNone;
      
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.highlightedColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      [button setBorderStyle:YKUIBorderStyleRounded color:[UIColor colorWithRed:0.659 green:0.671 blue:0.678 alpha:1.0] width:1.0 alternateWidth:0 cornerRadius:10.0];
      break;
      
    case YKUIButtonStyleDarkBlue:           
      button.titleColor = [UIColor whiteColor];
      button.titleFont = [UIFont boldSystemFontOfSize:14.0];
      button.titleShadowColor = [UIColor blackColor];
      button.color = [UIColor colorWithRed:0.369 green:0.624 blue:1.0 alpha:1.0];
      button.color2 = [UIColor colorWithRed:0.02 green:0.275 blue:0.784 alpha:1.0];      
      
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor colorWithRed:0.227 green:0.388 blue:0.627 alpha:1.0];      
      button.highlightedColor2 = [UIColor colorWithRed:0.016 green:0.271 blue:0.784 alpha:1.0];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];

      button.shadingType = YKUIShadingTypeLinear;
      [button setBorderStyle:YKUIBorderStyleRounded 
                     color:[UIColor blackColor]
                     width:0.5
            alternateWidth:0
              cornerRadius:6.0];      
      break;
      
    case YKUIButtonStyleBlack:
      // Normal: White text on black horizontal edge shading
      button.titleColor = [UIColor whiteColor];     
      button.titleFont = [UIFont boldSystemFontOfSize:14.0];
      button.titleShadowColor = nil;
      button.color = [UIColor blackColor];
      button.color2 = [UIColor blackColor];   
      button.shadingType = YKUIShadingTypeHorizontalEdge;
      
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.highlightedColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      [button setBorderStyle:YKUIBorderStyleRounded
                     color:[UIColor blackColor]
                     width:0.5
            alternateWidth:0
              cornerRadius:10.0];      
      break;
      
    case YKUIButtonStyleGray:
      button.titleColor = [UIColor blackColor];
      button.titleFont = [UIFont boldSystemFontOfSize:14.0];
      button.titleShadowColor = [UIColor whiteColor];
      button.color = [UIColor whiteColor];
      button.color2 = [UIColor lightGrayColor];
      button.shadingType = YKUIShadingTypeLinear;
      
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor lightGrayColor];
      button.highlightedColor2 = [UIColor grayColor];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      [button setBorderStyle:YKUIBorderStyleRounded 
                     color:[UIColor blackColor]
                     width:0.5
            alternateWidth:0
              cornerRadius:6.0];      
      break;
      
    case YKUIButtonStyleLink:
      button.titleColor = [UIColor colorWithRed:(77.0/255.0) green:(95.0/255.0) blue:(154.0/255.0) alpha:1];
      button.titleFont = [UIFont systemFontOfSize:15.0];
      button.titleShadowColor = nil;
      button.color = nil;
      button.color2 = nil;
      button.shadingType = YKUIShadingTypeNone;
      
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.highlightedColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];

      [button setBorderStyle:YKUIBorderStyleRounded 
                     color:[UIColor blackColor]
                     width:0
            alternateWidth:0
              cornerRadius:10.0];      
      break;
      
    case YKUIButtonStyleBlackToolbar:
      button.titleColor = [UIColor whiteColor];     
      button.titleFont = [UIFont boldSystemFontOfSize:13.0];
      button.titleShadowColor = nil;
      button.color = [UIColor colorWithWhite:0 alpha:0.5];
      button.color2 = [UIColor colorWithWhite:0 alpha:0.5];   
      button.shadingType = YKUIShadingTypeHorizontalEdge;
      
      button.highlightedTitleColor = [UIColor colorWithWhite:0.8 alpha:1];
      button.highlightedShadingType = YKUIShadingTypeHorizontalEdge;
      button.highlightedColor = [UIColor colorWithWhite:0.2 alpha:0.6];
      button.highlightedColor2 = [UIColor colorWithWhite:0.2 alpha:0.6];
      button.highlightedShadingType = YKUIShadingTypeLinear;

      button.disabledTitleColor = [UIColor colorWithWhite:0.9 alpha:0.6];
      button.disabledShadingType = button.shadingType;
      button.disabledColor = button.color;
      button.disabledColor2 = button.color2;
      
      [button setBorderStyle:YKUIBorderStyleRounded 
                     color:[UIColor blackColor]
                     width:0.5
            alternateWidth:0
              cornerRadius:6.0];
      break;
      
    case YKUIButtonStyleToggleBlue:
      button.color = [UIColor colorWithRed:(120.0/255.0) green:(141.0/255.0) blue:(169.0/255.0) alpha:1.0];     
      button.shadingType = YKUIShadingTypeHorizontalEdge;
      
      button.titleFont = [UIFont boldSystemFontOfSize:14.0];
      button.titleColor = [UIColor whiteColor];
      button.titleShadowColor = [UIColor colorWithWhite:0 alpha:0.6];
      button.titleShadowOffset = CGSizeMake(0, -1);
      
      button.highlightedTitleColor = [UIColor whiteColor];     
      button.highlightedColor = [UIColor colorWithRed:0.29 green:0.42 blue:0.61 alpha:1.0];
      button.highlightedColor2 = nil;
      button.highlightedShadingType = YKUIShadingTypeHorizontalEdge;
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      [button setBorderStyle:YKUIBorderStyleRounded 
                     color:[UIColor blackColor]
                     width:0.5
            alternateWidth:0
              cornerRadius:10.0];
      
      break;
      
    case YKUIButtonStyleTransparent:
      button.color = [UIColor colorWithWhite:0 alpha:0.25];
      button.titleColor = [UIColor whiteColor];     
      button.titleFont = [UIFont boldSystemFontOfSize:16];
      button.titleShadowColor = nil;    
      button.shadingType = YKUIShadingTypeNone;
      break;
      
    case YKUIButtonStyleMetal:
      button.color = [UIColor colorWithWhite:1.0 alpha:1.0];
      button.color2 = [UIColor colorWithWhite:0.94 alpha:1.0];
      button.color3 = [UIColor colorWithWhite:0.90 alpha:1.0];
      button.color4 = [UIColor colorWithWhite:0.86 alpha:1.0];
      button.titleColor = [UIColor blackColor];
      button.titleFont = [UIFont boldSystemFontOfSize:16];
      button.titleShadowColor = [UIColor whiteColor];
      button.titleShadowOffset = CGSizeMake(0, 1);
      button.shadingType = YKUIShadingTypeMetalEdge;
      
      /*
      button.highlightedColor = [UIColor colorWithWhite:0.82 alpha:1.0];
      button.highlightedColor2 = [UIColor colorWithWhite:0.94 alpha:1.0];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedTitleColor = [UIColor colorWithWhite:0 alpha:1.0];
      button.highlightedTitleShadowColor = [UIColor whiteColor];
      button.highlightedTitleShadowOffset = CGSizeMake(0, 1);
       */

      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.highlightedColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      button.highlightedTitleShadowColor = [UIColor grayColor];
      button.highlightedTitleShadowOffset = CGSizeMake(0, 1);  
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];

      
      [button setBorderStyle:YKUIBorderStyleRounded color:[UIColor colorWithWhite:0.698 alpha:1.0] width:1.0 alternateWidth:0 cornerRadius:10.0];
      button.borderShadowColor = [UIColor colorWithWhite:0 alpha:0.15];
      button.borderShadowBlur = 5;
      break;
      
    case YKUIButtonStyleDarkGray:
      button.color = [UIColor colorWithWhite:0.647 alpha:1.0];
      button.color2 = [UIColor colorWithWhite:0.494 alpha:1.0];
      button.shadingType = YKUIShadingTypeLinear;      
      button.titleColor = [UIColor whiteColor];
      button.titleFont = [UIFont systemFontOfSize:14.0];
      button.titleShadowColor = [UIColor blackColor];
      button.titleShadowOffset = CGSizeMake(0, -1);
            
      // Highlighted: White text on gray linear shading
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedColor = [UIColor lightGrayColor];
      button.highlightedColor2 = [UIColor grayColor];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      [button setBorderStyle:YKUIBorderStyleRounded 
                     color:[UIColor blackColor]
                     width:1.0
            alternateWidth:0
              cornerRadius:6.0];
      break;
      
    case YKUIButtonStyleGrayDisclosure:
      // Clear border style
      [button setBorderStyle:YKUIBorderStyleNone 
                     color:nil
                     width:0.0
            alternateWidth:0
              cornerRadius:0.0];
      
      button.color = [UIColor colorWithWhite:0.773 alpha:1.0];
      button.color2 = nil;
      button.titleColor = [UIColor colorWithWhite:0.333 alpha:1.0];
      button.titleFont = [UIFont boldSystemFontOfSize:13.0];
      button.titleShadowColor = [UIColor whiteColor];
      button.titleShadowOffset = CGSizeMake(0, 1);
      button.highlightedTitleColor = [UIColor lightGrayColor];
      button.highlightedColor = [UIColor darkGrayColor];
      button.highlightedColor2 = nil;
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedTitleShadowColor = [UIColor blackColor];
      button.highlightedTitleShadowOffset = CGSizeMake(0, 0.5);
      button.shadingType = YKUIShadingTypeLinear;
      button.accessoryImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure.png"] 
                                                   highlightedImage:[UIImage imageNamed:@"disclosure_selected.png"]] autorelease];
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      // Custom border
      button.layer.cornerRadius = 15.0;
      button.layer.masksToBounds = YES;
      button.layer.borderWidth = 0.5;
      button.layer.borderColor = [UIColor grayColor].CGColor;
      break;
      
    case YKUIButtonStyleFatYellow:
      button.titleFont = [UIFont boldSystemFontOfSize:28];
      button.titleColor = [UIColor whiteColor];
      button.color = [UIColor colorWithRed:1.0 green:.77 blue:.23 alpha:1.0];
      button.color2 = [UIColor colorWithRed:1.0 green:.59 blue:.16 alpha:1.0];
      button.shadingType = YKUIShadingTypeLinear;
      button.titleShadowColor = [UIColor darkGrayColor];
      button.titleShadowOffset = CGSizeMake(0, 2);

      button.highlightedColor = button.color2;
      button.highlightedColor2 = button.color;
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedTitleColor = [UIColor darkGrayColor];
      button.highlightedTitleShadowColor = [UIColor whiteColor];
      button.highlightedTitleShadowOffset = CGSizeMake(0, 1);

      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];

      [button setBorderStyle:YKUIBorderStyleRounded color:[UIColor whiteColor] width:7
            alternateWidth:0 cornerRadius:20.0];
      break;
      
    case YKUIButtonStyleSkinnyYellow:
      button.titleFont = [UIFont boldSystemFontOfSize:20];
      button.titleColor = [UIColor whiteColor];
      // Brighter Yellow
      //button.color = [UIColor colorWithRed:1.0 green:.77 blue:.23 alpha:1.0];
      //button.color2 = [UIColor colorWithRed:1.0 green:.59 blue:.16 alpha:1.0];
      // Darker Yellow
      button.color = [UIColor colorWithRed:.894 green:.60 blue:.13 alpha:1.0];
      button.color2 = [UIColor colorWithRed:.894 green:.47 blue:.08 alpha:1.0];
      button.shadingType = YKUIShadingTypeLinear;
      button.titleShadowColor = [UIColor colorWithRed:0.61f green:0.35f blue:0.00f alpha:1.0f];
      button.titleShadowOffset = CGSizeMake(0, -1);
      
      button.highlightedColor = button.color2;
      button.highlightedColor2 = button.color;
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedTitleColor = [UIColor darkGrayColor];
      button.highlightedTitleShadowColor = [UIColor whiteColor];
      button.highlightedTitleShadowOffset = CGSizeMake(0, -1);
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];

      [button setBorderStyle:YKUIBorderStyleRounded color:[UIColor whiteColor] width:6
            alternateWidth:0 cornerRadius:10.0];      
      break;
      
    case YKUIButtonStyleGreen:
      button.titleFont = [UIFont boldSystemFontOfSize:20];
      button.titleColor = [UIColor whiteColor];
      button.titleInsets = UIEdgeInsetsZero;
      button.color = [UIColor colorWithRed:0.27 green:0.78 blue:0.16 alpha:1.0];
      button.color2 = [UIColor colorWithRed:0.19 green:0.72 blue:0.08 alpha:1.0];
      button.shadingType = YKUIShadingTypeHorizontalEdge;
      button.titleShadowColor = [UIColor darkGrayColor];
      button.titleShadowOffset = CGSizeMake(0, -1);
      
      button.highlightedColor = [UIColor grayColor];
      button.highlightedColor2 = [UIColor lightGrayColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      button.highlightedTitleColor = [UIColor darkGrayColor];
      button.highlightedTitleShadowColor = [UIColor whiteColor];
      button.highlightedTitleShadowOffset = CGSizeMake(0, -1);
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];

      [button setBorderStyle:YKUIBorderStyleRounded color:[UIColor blackColor] width:0.5
            alternateWidth:0 cornerRadius:10.0];
      break;
      
    case YKUIButtonStyleBasicCellDisclosure:
      button.titleFont = [UIFont systemFontOfSize:16];
      button.titleAlignment = UITextAlignmentLeft;
      button.titleColor = [UIColor blackColor];
      button.titleInsets = UIEdgeInsetsZero;
      button.insets = UIEdgeInsetsMake(0, 10, 0, 0);
      button.color = [UIColor whiteColor];
      button.color2 = nil;
      button.shadingType = YKUIShadingTypeNone;
      
      button.highlightedColor = [UIColor grayColor];
      button.highlightedColor2 = [UIColor lightGrayColor];
      button.highlightedTitleColor = [UIColor whiteColor];
      button.highlightedShadingType = YKUIShadingTypeLinear;
      
      // Disabled: Gray text on gray linear shading
      button.disabledTitleColor = [UIColor grayColor];
      button.disabledShadingType = YKUIShadingTypeLinear;
      button.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
      button.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
      
      button.accessoryImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure.png"] 
                                                   highlightedImage:[UIImage imageNamed:@"disclosure_selected.png"]] autorelease];
      
      [button setBorderStyle:YKUIBorderStyleBottom color:[UIColor blackColor] width:0.5
            alternateWidth:0 cornerRadius:0];
      
      break;
  }
  [button setNeedsLayout];
  [button setNeedsDisplay];
}


@end
