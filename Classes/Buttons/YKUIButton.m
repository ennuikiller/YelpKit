//
//  YKUIButton.m
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

#import "YKUIButton.h"


@implementation YKUIButton

@synthesize title=_title, titleColor=_titleColor, titleFont=_titleFont, borderWidth=_borderWidth, borderAlternateWidth=_borderAlternateWidth, color=_color, color2=_color2, color3=_color3, color4=_color4, highlightedTitleColor=_highlightedTitleColor, highlightedColor=_highlightedColor, highlightedColor2=_highlightedColor2, highlightedShadingType=_highlightedShadingType, disabledTitleColor=_disabledTitleColor, disabledColor=_disabledColor, disabledColor2=_disabledColor2, disabledShadingType=_disabledShadingType, shadingType=_shadingType, borderColor=_borderColor, borderStyle=_borderStyle, titleShadowColor=_titleShadowColor, imageView=_imageView, accessoryImageView=_accessoryImageView, titleAlignment=_titleAlignment, titleHidden=_titleHidden, titleEdgeInsets=_titleEdgeInsets, titleShadowOffset=_titleShadowOffset, selectedTitleColor=_selectedTitleColor, selectedColor=_selectedColor, selectedColor2=_selectedColor2, selectedShadingType=_selectedShadingType, cornerRadius=_cornerRadius, highlightedTitleShadowColor=_highlightedTitleShadowColor, highlightedTitleShadowOffset=_highlightedTitleShadowOffset, disabledBorderColor=_disabledBorderColor, insets=_insets, imageSize=_imageSize, borderShadowColor=_borderShadowColor, borderShadowBlur=_borderShadowBlur;


- (id)init {
  return [self initWithFrame:CGRectZero];
}

- (void)sharedInit {
  self.layout = [YKLayout layoutForView:self];
  self.opaque = YES;
  self.backgroundColor = [UIColor clearColor];
  self.titleAlignment = UITextAlignmentCenter;
  self.insets = UIEdgeInsetsZero;
  self.titleEdgeInsets = UIEdgeInsetsZero;
  self.imageSize = CGSizeZero;
  self.highlightedEnabled = YES;

  // Default style
  self.titleColor = [UIColor colorWithRed:(77.0/255.0) green:(95.0/255.0) blue:(154.0/255.0) alpha:1];
  self.titleEdgeInsets = UIEdgeInsetsZero;
  self.titleFont = [UIFont boldSystemFontOfSize:14.0];
  self.titleShadowColor = nil;
  self.titleShadowOffset = CGSizeZero;
  self.color = [UIColor whiteColor];          
  self.color2 = nil;
  self.shadingType = YKUIShadingTypeNone;        
  // Highlighted: White text on gray linear shading
  self.highlightedTitleColor = [UIColor whiteColor];
  self.highlightedShadingType = YKUIShadingTypeLinear;
  self.highlightedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
  self.highlightedColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
  // Disabled: Gray text on gray linear shading
  self.disabledTitleColor = [UIColor grayColor];
  self.disabledShadingType = YKUIShadingTypeLinear;
  self.disabledColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
  self.disabledColor2 = [UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0];
  // Border
  [self setBorderStyle:YKUIBorderStyleRounded color:[UIColor colorWithRed:0.659 green:0.671 blue:0.678 alpha:1.0] width:1.0 alternateWidth:0 cornerRadius:10.0];

  self.accessibilityTraits |= UIAccessibilityTraitButton;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action {
  if ((self = [super initWithFrame:frame])) {    
    self.title = title;   
    [self setTarget:target action:action];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
  if ((self = [self initWithFrame:frame title:title target:nil action:NULL])) { }
  return self;
}

- (void)dealloc {
  [_title release];
  [_titleFont release];
  [_titleColor release];
  [_color release];
  [_color2 release];
  [_color3 release];
  [_color4 release];
  [_highlightedTitleColor release];
  [_highlightedColor release];
  [_highlightedColor2 release];
  [_disabledColor2 release];
  [_disabledTitleColor release];
  [_disabledColor release];
  [_disabledBorderColor release];
  [_borderColor release];
  [_borderShadowColor release];
  [_titleShadowColor release];
  [_imageView release];
  [_accessoryImageView release];
  [super dealloc];
}

+ (YKUIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title {
  return [[[[self class] alloc] initWithFrame:frame title:title] autorelease];
}

+ (YKUIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action {
  return [[[[self class] alloc] initWithFrame:frame title:title target:target action:action] autorelease];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  CGFloat y = 0;

  y += _titleEdgeInsets.top;
  
  if (_title) {
    CGSize constrainedToSize = size;
    constrainedToSize.width -= (_titleEdgeInsets.left + _titleEdgeInsets.right);
    _titleSize = [_title sizeWithFont:_titleFont constrainedToSize:constrainedToSize lineBreakMode:UILineBreakModeTailTruncation];
    y += _titleSize.height;
  }
  
  y += _titleEdgeInsets.bottom;

  return CGSizeMake(size.width, y);
}

- (CGSize)sizeThatFitsTitle:(CGSize)size {
  CGSize titleSize = [_title sizeWithFont:_titleFont constrainedToSize:size lineBreakMode:UILineBreakModeTailTruncation];  
  return CGSizeMake(titleSize.width + _titleEdgeInsets.left + _titleEdgeInsets.right, titleSize.height + _titleEdgeInsets.top + _titleEdgeInsets.bottom);
}

- (void)setHighlighted:(BOOL)highlighted {
  for (UIView *view in [self subviews]) {
    if ([view respondsToSelector:@selector(setHighlighted:)]) {
      [(id)view setHighlighted:highlighted];
    }
  }
  [super setHighlighted:highlighted];
}

- (void)didChangeValueForKey:(NSString *)key {
  [super didChangeValueForKey:key];
  [self setNeedsLayout];
  [self setNeedsDisplay];  
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
  _titleEdgeInsets = titleEdgeInsets;
  [self didChangeValueForKey:@"titleEdgeInsets"];
}

- (void)setTitleFont:(UIFont *)titleFont {
  [titleFont retain];
  [_titleFont release];
  _titleFont = titleFont;
  [self didChangeValueForKey:@"titleFont"];
}

- (void)setTitle:(NSString *)title {
  [title retain];
  [_title release];
  _title = title;
  [self didChangeValueForKey:@"title"];
}

+ (YKUIButton *)button {
  return [[[YKUIButton alloc] initWithFrame:CGRectZero] autorelease];
}

- (void)sizeToFitWithMinimumSize:(CGSize)minSize {
  CGSize size = [self sizeThatFits:minSize];
  if (size.width < minSize.width) size.width = minSize.width;
  if (size.height < minSize.height) size.height = minSize.height;
  self.frame = YKCGRectSetSize(self.frame, size);
}

- (void)setBorderStyle:(YKUIBorderStyle)borderStyle color:(UIColor *)color width:(CGFloat)width alternateWidth:(CGFloat)alternateWidth cornerRadius:(CGFloat)cornerRadius {
  self.borderStyle = borderStyle;
  self.borderColor = color;
  self.borderWidth = width;
  self.borderAlternateWidth = alternateWidth;
  self.cornerRadius = cornerRadius;  
}

- (void)setImage:(UIImage *)image {
  self.imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
}

- (UIImage *)image {
  return self.imageView.image;
}

- (UIColor *)textColorForState:(UIControlState)state {
  
  BOOL isHighlighted = self.isHighlighted;
  BOOL isDisabled = !self.isEnabled;
  
  if (_highlightedTitleColor && isHighlighted) {
    return _highlightedTitleColor;
  } else if (_disabledTitleColor && isDisabled) {
    return _disabledTitleColor;
  } else if (_titleColor) {
    return _titleColor;
  } else {
    return [UIColor blackColor];
  }
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  UIControlState state = self.state;
  CGRect bounds = self.bounds;
  CGSize size = bounds.size;
  
  size.height -= _insets.top + _insets.bottom;
  
  BOOL isHighlighted = self.isHighlighted;
  BOOL isSelected = self.isSelected;
  BOOL isDisabled = !self.isEnabled;
  
  YKUIShadingType shadingType = _shadingType;
  UIColor *color = _color;
  UIColor *color2 = _color2;
  UIColor *color3 = _color3;
  UIColor *color4 = _color4;
  UIColor *borderColor = _borderColor;
  
  if (isDisabled) {
    if (_disabledShadingType != YKUIShadingTypeNone) shadingType = _disabledShadingType;
    if (_disabledColor) color = _disabledColor;
    if (_disabledColor2) color2 = _disabledColor2;
    if (_disabledBorderColor) borderColor = _disabledBorderColor;
  } else if (isHighlighted) { //  || self.isTracking ; TODO(gabe): Check if we still need the tracking
    if (_highlightedShadingType != YKUIShadingTypeNone) shadingType = _highlightedShadingType;
    if (_highlightedColor) color = _highlightedColor;
    if (_highlightedColor2) color2 = _highlightedColor2;
  } else if (isSelected) {
    // Set from selected properties; Fall back to highlighted properties
    if (_selectedShadingType != YKUIShadingTypeNone) shadingType = _selectedShadingType;
    else if (_highlightedShadingType != YKUIShadingTypeNone) shadingType = _highlightedShadingType;
    if (_selectedColor) color = _selectedColor;
    else if (_highlightedColor) color = _highlightedColor;
    if (_selectedColor2) color2 = _selectedColor2;
    else if (_highlightedColor2) color2 = _highlightedColor2;
  }
  
  UIColor *fillColor = color;
  
  UIImage *icon = _imageView.image;
  if (isHighlighted && [_imageView respondsToSelector:@selector(highlightedImage)] && _imageView.highlightedImage) icon = _imageView.highlightedImage;
  
  UIImage *accessoryIcon = _accessoryImageView.image;
  if (isHighlighted && _accessoryImageView.highlightedImage) accessoryIcon = _accessoryImageView.highlightedImage;
  
  if (color && shadingType != YKUIShadingTypeNone) {
    YKCGContextAddStyledRect(context, bounds, _borderStyle, _borderWidth, _borderAlternateWidth, _cornerRadius);  
    // Clip for border styles that support it (that form a cohesive path)
    if (_borderStyle != YKUIBorderStyleTop && 
        _borderStyle != YKUIBorderStyleBottom &&
        _borderStyle != YKUIBorderStyleTopBottom) {
      
      CGContextClip(context);
    }
    YKCGContextDrawShadingWithHeight(context, color.CGColor, color2.CGColor, color3.CGColor, color4.CGColor, self.bounds.size.height, shadingType);
    fillColor = nil;
  }
  
  if (_borderWidth > 0) {
    if (_borderShadowColor) {
      YKCGContextDrawBorderWithShadow(context, bounds, _borderStyle, fillColor.CGColor, borderColor.CGColor, _borderWidth, _borderAlternateWidth, _cornerRadius, _borderShadowColor.CGColor, _borderShadowBlur);
    } else {
      YKCGContextDrawBorder(context, bounds, _borderStyle, fillColor.CGColor, borderColor.CGColor, _borderWidth, _borderAlternateWidth, _cornerRadius);
    }
  }
  
  UIColor *textColor = [self textColorForState:state];
  
  UIFont *font = self.titleFont;
  
  CGFloat y = bounds.origin.y + roundf(YKCGPointToCenter(_titleSize, size).y) + _insets.top;

  BOOL showIcon = (icon != nil && !_imageView.hidden);
  CGSize iconSize = _imageSize;
  if (icon && YKCGSizeIsZero(iconSize)) {
    iconSize = icon.size;
  }
  
  if (!_titleHidden) {
    CGFloat lineWidth = _titleSize.width + _titleEdgeInsets.left + _titleEdgeInsets.right;
    if (showIcon) lineWidth += iconSize.width + 2;
    CGFloat x = _insets.left;
    
    if (_titleAlignment == UITextAlignmentCenter) {
      CGFloat width = size.width;
      if (accessoryIcon) width -= accessoryIcon.size.width;
      x = bounds.origin.x + roundf(width/2.0 - lineWidth/2.0);      
    }
    if (x < 0) x = 0;
    
    if (showIcon) {
      CGFloat iconTop = roundf(YKCGPointToCenter(iconSize, size).y);
      [icon drawInRect:CGRectMake(x, iconTop, iconSize.width, iconSize.height)];
      x += iconSize.width + 2; // TODO(gabe): This 2px padding should come from default inset
      showIcon = NO;
    } else if (!YKCGSizeIsZero(iconSize)) {
      x += iconSize.width + 2;
    }
    
    y += _titleEdgeInsets.top;

    [textColor setFill];
    if (_highlightedTitleShadowColor && isHighlighted) {
      CGContextSetShadowWithColor(context, _highlightedTitleShadowOffset, 0.0, _highlightedTitleShadowColor.CGColor);
    } else if (_titleShadowColor && !isHighlighted && !isDisabled) {
      CGContextSetShadowWithColor(context, _titleShadowOffset, 0.0, _titleShadowColor.CGColor);
    }

    x += _titleEdgeInsets.left;
    [_title drawInRect:CGRectMake(x, y, _titleSize.width, _titleSize.height) withFont:font lineBreakMode:UILineBreakModeTailTruncation alignment:_titleAlignment];
  }
  
  if (accessoryIcon)
    [accessoryIcon drawAtPoint:YKCGPointToRight(accessoryIcon.size, CGSizeMake(size.width - 10, size.height))];
  
  if (showIcon) {
    [icon drawInRect:YKCGRectToCenterInRect(iconSize, bounds)];
  }  
}

@end


@implementation YKUIButtonBackground

@synthesize color=_color, color2=_color2, color3=_color3, color4=_color4, shadingType=_shadingType;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    // Default to gray shading background (For use as selected background view)
    self.color = [[UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.0] retain];
    self.color2 = [[UIColor colorWithRed:0.675 green:0.675 blue:0.675 alpha:1.0] retain];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = 10.0;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    self.shadingType = YKUIShadingTypeLinear;
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (void)dealloc {
  [_color release];
  [_color2 release];
  [_color3 release];
  [_color4 release];
  [super dealloc];
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  YKCGContextDrawShadingWithHeight(context, _color.CGColor, _color2.CGColor, _color3.CGColor, _color4.CGColor, self.bounds.size.height, _shadingType);
} 

@end
