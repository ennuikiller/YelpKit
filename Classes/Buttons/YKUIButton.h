//
//  YKUIButton.h
//  YelpKit
//
//  Created by Gabriel Handford on 12/17/08.
//  Copyright 2008 Yelp. All rights reserved.
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

#import "YKUIControl.h"
#import "YKCGUtils.h"

// A default button height
#define kButtonHeight 37


/*!
 Button (control).
 */
@interface YKUIButton : YKUIControl {

  NSString *_title;
  
  UIColor *_titleColor;
  UIFont *_titleFont;
  UITextAlignment _titleAlignment; // Defaults to center
  CGSize _titleSize;
  UIEdgeInsets _titleEdgeInsets;
  
  UIColor *_color;
  UIColor *_color2;
  UIColor *_color3;
  UIColor *_color4;
  
  YKUIShadingType _shadingType;
  
  UIColor *_highlightedTitleColor;
  UIColor *_highlightedTitleShadowColor;
  CGSize _highlightedTitleShadowOffset;

  UIColor *_highlightedColor;
  UIColor *_highlightedColor2;
  YKUIShadingType _highlightedShadingType;
  
  UIColor *_disabledTitleColor;
  UIColor *_disabledColor;
  UIColor *_disabledColor2; 
  UIColor *_disabledBorderColor;
  YKUIShadingType _disabledShadingType;
  
  UIColor *_selectedTitleColor;
  UIColor *_selectedColor;
  UIColor *_selectedColor2;
  YKUIShadingType _selectedShadingType;  

  // For custom border styles
  UIColor *_borderColor;
  CGFloat _borderWidth;
  CGFloat _borderAlternateWidth; // Defaults to 1; Used with custom border styles
  YKUIBorderStyle _borderStyle; // Defaults to YKUIBorderStyleRounded
  CGFloat _cornerRadius;
  UIColor *_borderShadowColor;
  CGFloat _borderShadowBlur;
  
  UIColor *_titleShadowColor;
  CGSize _titleShadowOffset;
  
  UIImageView *_imageView;
  CGSize _imageSize;
  UIImageView *_accessoryImageView;
  
  BOOL _titleHidden;
  
}

@property (retain, nonatomic) NSString *title; // Text
@property (retain, nonatomic) UIFont *titleFont; //! Button title font; Defaults to Helvetica-Bold/14
@property (assign, nonatomic) UITextAlignment titleAlignment; //! Text alignment for title
@property (retain, nonatomic) UIColor *titleColor; // Text color for title

/*!
 Color (background) for button.
 Can be used with shadingType and alternateColor.
 */
@property (retain, nonatomic) UIColor *color; 

/*!
 Alternate colors (background) for shading.
 Not all shading types use an alternate color.
 */
@property (retain, nonatomic) UIColor *color2;
@property (retain, nonatomic) UIColor *color3;
@property (retain, nonatomic) UIColor *color4;


@property (assign, nonatomic) YKUIShadingType shadingType;
@property (assign, nonatomic) YKUIBorderStyle borderStyle;

@property (retain, nonatomic) UIColor *highlightedTitleColor;
@property (retain, nonatomic) UIColor *highlightedColor;
@property (retain, nonatomic) UIColor *highlightedColor2;
@property (assign, nonatomic) YKUIShadingType highlightedShadingType;
@property (assign, nonatomic) UIColor *highlightedTitleShadowColor;
@property (assign, nonatomic) CGSize highlightedTitleShadowOffset;

@property (retain, nonatomic) UIColor *selectedTitleColor;
@property (retain, nonatomic) UIColor *selectedColor;
@property (retain, nonatomic) UIColor *selectedColor2;
@property (assign, nonatomic) YKUIShadingType selectedShadingType;

@property (retain, nonatomic) UIColor *disabledTitleColor;
@property (retain, nonatomic) UIColor *disabledColor;
@property (retain, nonatomic) UIColor *disabledColor2;
@property (retain, nonatomic) UIColor *disabledBorderColor;
@property (assign, nonatomic) YKUIShadingType disabledShadingType;

@property (retain, nonatomic) UIColor *titleShadowColor;
@property (assign, nonatomic) CGSize titleShadowOffset;

@property (retain, nonatomic) UIImageView *imageView;
@property (retain, nonatomic) UIImageView *accessoryImageView;
@property (assign, nonatomic) UIEdgeInsets titleEdgeInsets; // Insets for title text; TODO(gabe): Rename to titleInsets
@property (assign, nonatomic) UIEdgeInsets insets;

@property (assign, nonatomic, getter=isTitleHidden) BOOL titleHidden;

@property (retain, nonatomic) UIImage *image;
@property (assign, nonatomic) CGSize imageSize; // Default to CGSizeZero; If set will use this size instead of the image size

@property (retain, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) CGFloat borderAlternateWidth;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (retain, nonatomic) UIColor *borderShadowColor; // Inner shadow color for border
@property (assign, nonatomic) CGFloat borderShadowBlur; // Inner shadow blur amount (width) for border


/*!
 Create button.
 @param frame Frame
 @param title Title
 @param target Target
 @param action Action
 */
- (id)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;

/*!
 Create button.
 @param frame Frame
 @param title Title
 */
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

/*!
 @result Button
 */
+ (YKUIButton *)button;

/*!
 Button with style.
 @param frame Frame
 @param title Title
 */
+ (YKUIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title;

/*!
 Button with style.
 @param frame Frame
 @param title Title
 @param target Target
 @param action Action
 */
+ (YKUIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;

/*!
 Size to fit button with a minimum size.
 @param minSize Min size
 */
- (void)sizeToFitWithMinimumSize:(CGSize)minSize;

/*!
 Size that fits title.
 @param size Size
 @result Size to only fit the title text (with insets).
 */
- (CGSize)sizeThatFitsTitle:(CGSize)size;

/*!
 Set border.
 @param borderStyle Border style
 @param color Color
 @param width Width
 @param alternateWidth Alternate width
 @param cornerRadius Corner radius
 */
- (void)setBorderStyle:(YKUIBorderStyle)borderStyle color:(UIColor *)color width:(CGFloat)width alternateWidth:(CGFloat)alternateWidth cornerRadius:(CGFloat)cornerRadius;

@end


@interface YKUIButtonBackground : UIView { 
  UIColor *_color;
  UIColor *_color2;
  UIColor *_color3;
  UIColor *_color4;
  CGFloat _borderWidth;
  CGFloat _cornerRadius;
  UIColor *_borderColor;
  YKUIShadingType _shadingType;
}

@property (assign, nonatomic) YKUIShadingType shadingType;
@property (retain, nonatomic) UIColor *color;
@property (retain, nonatomic) UIColor *color2;
@property (retain, nonatomic) UIColor *color3;
@property (retain, nonatomic) UIColor *color4;

@end
