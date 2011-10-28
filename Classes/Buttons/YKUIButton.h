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
 Button.
 */
@interface YKUIButton : YKUIControl {

  NSString *_title;
  
  UIColor *_titleColor;
  UIFont *_titleFont;
  UITextAlignment _titleAlignment;
  CGSize _titleSize;
  UIEdgeInsets _titleInsets;
  
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

  UIColor *_borderColor;
  CGFloat _borderWidth;
  CGFloat _borderAlternateWidth;
  YKUIBorderStyle _borderStyle;
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

/*!
 Text for button.
 */
@property (retain, nonatomic) NSString *title; 

/*!
 Text font for button.
 */
@property (retain, nonatomic) UIFont *titleFont;

/*!
 Text alignment for title. Defaults to center.
 */
@property (assign, nonatomic) UITextAlignment titleAlignment;

/*!
 Text color for title.
 */
@property (retain, nonatomic) UIColor *titleColor;

/*!
 Background color for button.
 Can be used with shadingType, color2, color3, color4.
 */
@property (retain, nonatomic) UIColor *color; 

/*!
 Background (alternate) color for button.
 Not all shading types use color2.
 */
@property (retain, nonatomic) UIColor *color2;

/*!
 Background (alternate) color for button.
 Not all shading types use color3.
 */
@property (retain, nonatomic) UIColor *color3;

/*!
 Background (alternate) color for button.
 Not all shading types use color4.
 */
@property (retain, nonatomic) UIColor *color4;

/*!
 Shading type for background.
 */
@property (assign, nonatomic) YKUIShadingType shadingType;

/*!
 Border style.
 Defaults to YKUIBorderStyleRounded.
 */
@property (assign, nonatomic) YKUIBorderStyle borderStyle;

/*!
 Border color.
 */
@property (retain, nonatomic) UIColor *borderColor;

/*!
 Border width (stroke).
 */
@property (assign, nonatomic) CGFloat borderWidth;

/*!
 Border width (alternate). Used with custom border styles like YKUIBorderStyleLeftRightWithAlternateTop.
 Defaults to 1.
 */
@property (assign, nonatomic) CGFloat borderAlternateWidth;

/*!
 Border corner radius.
 */
@property (assign, nonatomic) CGFloat cornerRadius;

/*!
 Border shadow color (for inner glow).
 */
@property (retain, nonatomic) UIColor *borderShadowColor;

/*!
 Border shadow blur amount (for inner glow).
 */
@property (assign, nonatomic) CGFloat borderShadowBlur;

/*!
 Text shadow color.
 */
@property (retain, nonatomic) UIColor *titleShadowColor;

/*!
 Text shadow offset.
 */
@property (assign, nonatomic) CGSize titleShadowOffset;

/*!
 Image (view) to display to the left of the text.
 Alternatively, you can set the image.
 */
@property (retain, nonatomic) UIImageView *imageView;

/*!
 Image to display on the right side of the button.
 */
@property (retain, nonatomic) UIImageView *accessoryImageView;

/*!
 Insets for title text.
 */
@property (assign, nonatomic) UIEdgeInsets titleInsets; 

/*!
 Insets for the button.
 */
@property (assign, nonatomic) UIEdgeInsets insets;

/*!
 Hide the text.
 */
@property (assign, nonatomic, getter=isTitleHidden) BOOL titleHidden;

/*!
 Image to display to the left of the text.
 Alternatively, you can set the imageView.
 */
@property (retain, nonatomic) UIImage *image;

/*!
 If set, will use this size instead of the image.size.
 Defaults to CGSizeZero (disabled).
 */
@property (assign, nonatomic) CGSize imageSize; 

/*!
 Text color for title (highlighted).
 */
@property (retain, nonatomic) UIColor *highlightedTitleColor;

/*!
 Background color for button (highlighted).
 Can be used with shadingType, color2, color3, color4.
 */
@property (retain, nonatomic) UIColor *highlightedColor;

/*!
 Background (alternate) color for button (highlighted).
 Not all shading types use color2.
 */
@property (retain, nonatomic) UIColor *highlightedColor2;

/*!
 Shading type for background (highlighted).
 */
@property (assign, nonatomic) YKUIShadingType highlightedShadingType;

/*!
 Text shadow color (highlighted).
 */
@property (assign, nonatomic) UIColor *highlightedTitleShadowColor;

/*!
 Text shadow offset (highlighted).
 */
@property (assign, nonatomic) CGSize highlightedTitleShadowOffset;

/*!
 Text color for title (selected).
 */
@property (retain, nonatomic) UIColor *selectedTitleColor;

/*!
 Background color for button (selected).
 Can be used with shadingType, color2, color3, color4.
 */
@property (retain, nonatomic) UIColor *selectedColor;

/*!
 Background (alternate) color for button (selected).
 Not all shading types use color2.
 */
@property (retain, nonatomic) UIColor *selectedColor2;

/*!
 Shading type for background (selected).
 */
@property (assign, nonatomic) YKUIShadingType selectedShadingType;

/*!
 Text color for title (selected).
 */
@property (retain, nonatomic) UIColor *disabledTitleColor;

/*!
 Background color for button (highlighted).
 Can be used with shadingType, color2, color3, color4.
 */
@property (retain, nonatomic) UIColor *disabledColor;

/*!
 Background (alternate) color for button (highlighted).
 Not all shading types use color2.
 */
@property (retain, nonatomic) UIColor *disabledColor2;

/*!
 Border color (disabled).
 */
@property (retain, nonatomic) UIColor *disabledBorderColor;

/*!
 Shading type for background (disabled).
 */
@property (assign, nonatomic) YKUIShadingType disabledShadingType;

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
