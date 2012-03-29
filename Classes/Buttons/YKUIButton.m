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

@synthesize title=_title, titleColor=_titleColor, titleFont=_titleFont, borderWidth=_borderWidth, borderAlternateWidth=_borderAlternateWidth, color=_color, color2=_color2, color3=_color3, color4=_color4, highlightedTitleColor=_highlightedTitleColor, highlightedColor=_highlightedColor, highlightedColor2=_highlightedColor2, highlightedShadingType=_highlightedShadingType, disabledTitleColor=_disabledTitleColor, disabledColor=_disabledColor, disabledColor2=_disabledColor2, disabledShadingType=_disabledShadingType, shadingType=_shadingType, borderColor=_borderColor, borderStyle=_borderStyle, titleShadowColor=_titleShadowColor, accessoryImageView=_accessoryImageView, titleAlignment=_titleAlignment, titleHidden=_titleHidden, titleInsets=_titleInsets, titleShadowOffset=_titleShadowOffset, selectedTitleColor=_selectedTitleColor, selectedColor=_selectedColor, selectedColor2=_selectedColor2, selectedShadingType=_selectedShadingType, cornerRadius=_cornerRadius, highlightedTitleShadowColor=_highlightedTitleShadowColor, highlightedTitleShadowOffset=_highlightedTitleShadowOffset, disabledBorderColor=_disabledBorderColor, insets=_insets, borderShadowColor=_borderShadowColor, borderShadowBlur=_borderShadowBlur, iconImageSize=_iconImageSize, iconImageView=_iconImageView, highlightedImage=_highlightedImage, image=_image, selectedBorderShadowColor=_selectedBorderShadowColor, selectedBorderShadowBlur=_selectedBorderShadowBlur, disabledImage=_disabledImage, iconPosition=_iconPosition, highlightedBorderShadowColor=_highlightedBorderShadowColor, highlightedBorderShadowBlur=_highlightedBorderShadowBlur, secondaryTitle=_secondaryTitle, secondaryTitleColor=_secondaryTitleColor, secondaryTitleFont=_secondaryTitleFont, iconOrigin=_iconOrigin, contentView=_contentView, maxLineCount=_maxLineCount;
;


- (id)init {
  return [self initWithFrame:CGRectZero];
}

- (void)sharedInit {
  self.userInteractionEnabled = YES;
  self.layout = [YKLayout layoutForView:self];
  self.opaque = YES;
  self.backgroundColor = [UIColor clearColor];
  self.titleAlignment = UITextAlignmentCenter;
  self.insets = UIEdgeInsetsZero;
  self.titleInsets = UIEdgeInsetsZero;
  self.iconImageSize = CGSizeZero;
  self.highlightedEnabled = YES;
  self.iconOrigin = CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
  _selectedShadingType = YKUIShadingTypeUnknown;
  _highlightedShadingType = YKUIShadingTypeUnknown;
  _disabledShadingType = YKUIShadingTypeUnknown;

  // Default style  
  self.titleColor = [UIColor blackColor];
  self.titleFont = [UIFont boldSystemFontOfSize:14.0];
  self.titleShadowOffset = CGSizeZero;
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

- (id)initWithContentView:(UIView *)contentView {
  if ((self = [self initWithFrame:CGRectZero])) { 
    [self setContentView:contentView];
  }
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
  [_selectedBorderShadowColor release];
  [_titleShadowColor release];
  [_iconImageView release];
  [_accessoryImageView release];
  [_image release];
  [_highlightedImage release];
  [_disabledImage release];
  [_highlightedBorderShadowColor release];
  [_secondaryTitle release];
  [_secondaryTitleColor release];
  [_secondaryTitleFont release];
  [_contentView release];
  [super dealloc];
}

+ (YKUIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title {
  return [[[[self class] alloc] initWithFrame:frame title:title] autorelease];
}

+ (YKUIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action {
  return [[[[self class] alloc] initWithFrame:frame title:title target:target action:action] autorelease];
}

- (CGSize)_sizeForTitle:(CGSize)constrainedToSize {
  if (_maxLineCount > 0) {
    CGSize lineSize = [@" " sizeWithFont:_titleFont];
    constrainedToSize.height = lineSize.height * _maxLineCount;
  }
  CGSize titleSize = [_title sizeWithFont:_titleFont constrainedToSize:constrainedToSize lineBreakMode:UILineBreakModeTailTruncation];
  
  if (_secondaryTitle) {
    constrainedToSize.width -= roundf(titleSize.width);
    CGSize secondaryTitleSize = [_secondaryTitle sizeWithFont:(_secondaryTitleFont ? _secondaryTitleFont : _titleFont) constrainedToSize:constrainedToSize lineBreakMode:UILineBreakModeTailTruncation];
    titleSize.width += roundf(secondaryTitleSize.width);
  }
  return titleSize;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  [self setNeedsDisplay];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  if (_contentView) {
    CGFloat y = _insets.top;
    CGRect contentViewFrame = [layout setFrame:CGRectMake(_insets.left, y, size.width - _insets.left - _insets.right, 0) view:_contentView options:YKLayoutOptionsSizeToFit|YKLayoutOptionsSizeToFitVariableWidth];
    y += contentViewFrame.size.height;
    return CGSizeMake(size.width, y + _insets.bottom);
  }
  
  CGFloat y = 0;

  y += _insets.top;
  y += _titleInsets.top;
  
  if (_title) {
    CGSize constrainedToSize = size;
    // Subtract insets
    constrainedToSize.width -= (_titleInsets.left + _titleInsets.right);
    constrainedToSize.width -= (_insets.left + _insets.right);
    
    // Subtract icon width
    CGSize iconSize = _iconImageSize;
    if (_iconImageView.image && YKCGSizeIsZero(iconSize)) {
      iconSize = _iconImageView.image.size;
      iconSize.width += 2; // TODO(gabe): Set configurable
    }
    constrainedToSize.width -= iconSize.width;
    
    if (_activityIndicatorView && _activityIndicatorView.isAnimating) {
      constrainedToSize.width -= _activityIndicatorView.frame.size.width;
    }
    
    if (constrainedToSize.height == 0) {
      constrainedToSize.height = 9999;
    }
    
    _titleSize = [self _sizeForTitle:constrainedToSize];
    
    if (_activityIndicatorView) {
      if (_titleHidden) {
        CGPoint p = YKCGPointToCenter(_activityIndicatorView.frame.size, size);
        [layout setOrigin:p view:_activityIndicatorView];
      } else {
        CGPoint p = YKCGPointToCenter(_titleSize, size);
        p.x -= _activityIndicatorView.frame.size.width + 4;
        [layout setOrigin:p view:_activityIndicatorView];
      }
    }
    
    y += _titleSize.height;
  }
  
  y += _titleInsets.bottom;
  y += _insets.bottom;

  return CGSizeMake(size.width, y);
}

- (CGSize)sizeThatFitsTitle:(CGSize)size minWidth:(CGFloat)minWidth {
  CGSize sizeThatFitsTitle = [self sizeThatFitsTitle:size];
  if (sizeThatFitsTitle.width < minWidth) sizeThatFitsTitle.width = minWidth;
  return sizeThatFitsTitle;
}

- (CGSize)sizeThatFitsTitle:(CGSize)size {
  CGSize titleSize = [self _sizeForTitle:size];
  return CGSizeMake(titleSize.width + _insets.left + _insets.right + _titleInsets.left + _titleInsets.right, titleSize.height + _titleInsets.top + _titleInsets.bottom);
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

- (void)setTitleInsets:(UIEdgeInsets)titleInsets {
  _titleInsets = titleInsets;
  [self didChangeValueForKey:@"titleInsets"];
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

- (void)setTitleHidden:(BOOL)titleHidden {
  _titleHidden = titleHidden;
  [self didChangeValueForKey:@"titleHidden"];
}

- (void)setContentView:(UIView *)contentView {
  [contentView retain];
  [_contentView removeFromSuperview];
  [_contentView release];
  _contentView = contentView;
  [self addSubview:_contentView];
  [self didChangeValueForKey:@"contentView"];
}

- (void)setColor:(UIColor *)color {
  [color retain];
  [_color release];
  _color = color;
  // Set shading type to none if a color is set
  if (_shadingType == YKUIShadingTypeUnknown) {
    _shadingType = YKUIShadingTypeNone;
  }
  [self didChangeValueForKey:@"contentView"];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _cornerRadius = cornerRadius;
  if (_borderStyle == YKUIBorderStyleNone) {
    _borderStyle = YKUIBorderStyleRounded;
  }
  [self didChangeValueForKey:@"cornerRadius"];
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

- (void)setIconImage:(UIImage *)iconImage {
  self.iconImageView = [[[UIImageView alloc] initWithImage:iconImage] autorelease];
}

- (UIImage *)iconImage {
  return self.iconImageView.image;
}

- (UIColor *)textColorForState:(UIControlState)state {
  
  BOOL isHighlighted = (self.isHighlighted && self.userInteractionEnabled);
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

- (void)setActivityIndicatorAnimating:(BOOL)animating {
  if (!_activityIndicatorView) {
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.hidesWhenStopped = YES;
    [self addSubview:_activityIndicatorView];
  }
  if (animating) [_activityIndicatorView startAnimating];
  else [_activityIndicatorView stopAnimating];
  self.userInteractionEnabled = !animating;
  [self setNeedsLayout];
}

- (BOOL)isAnimating {
  return [_activityIndicatorView isAnimating];
}

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  [_contentView setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  UIControlState state = self.state;
  CGRect bounds = self.bounds;
  CGSize size = bounds.size;
  
  size.height -= _insets.top + _insets.bottom;
  
  BOOL isHighlighted = (self.isHighlighted && self.userInteractionEnabled);
  BOOL isSelected = self.isSelected;
  BOOL isDisabled = !self.isEnabled;
  
  YKUIShadingType shadingType = _shadingType;
  UIColor *color = _color;
  UIColor *color2 = _color2;
  UIColor *color3 = _color3;
  UIColor *color4 = _color4;
  UIColor *borderColor = _borderColor;
  
  UIImage *image = _image;
  
  UIColor *borderShadowColor = _borderShadowColor;
  CGFloat borderShadowBlur = _borderShadowBlur;
  
  if (isDisabled) {
    if (_disabledShadingType != YKUIShadingTypeUnknown) shadingType = _disabledShadingType;
    if (_disabledColor) color = _disabledColor;
    if (_disabledColor2) color2 = _disabledColor2;
    if (_disabledBorderColor) borderColor = _disabledBorderColor;
    if (_disabledImage) image = _disabledImage;
  } else if (isHighlighted) { //  || self.isTracking ; TODO(gabe): Check if we still need the tracking
    if (_highlightedShadingType != YKUIShadingTypeUnknown) shadingType = _highlightedShadingType;
    if (_highlightedColor) color = _highlightedColor;
    if (_highlightedColor2) color2 = _highlightedColor2;
    if (_highlightedImage) image = _highlightedImage;
    if (_highlightedBorderShadowColor) borderShadowColor = _highlightedBorderShadowColor;
    if (_highlightedBorderShadowBlur) borderShadowBlur = _highlightedBorderShadowBlur;
  } else if (isSelected) {
    // Set from selected properties; Fall back to highlighted properties
    if (_selectedShadingType != YKUIShadingTypeUnknown) shadingType = _selectedShadingType;
    else if (_highlightedShadingType != YKUIShadingTypeUnknown) shadingType = _highlightedShadingType;
    if (_selectedColor) color = _selectedColor;
    else if (_highlightedColor) color = _highlightedColor;
    if (_selectedColor2) color2 = _selectedColor2;
    else if (_highlightedColor2) color2 = _highlightedColor2;
    if (_selectedBorderShadowColor) borderShadowColor = _selectedBorderShadowColor;
    if (_selectedBorderShadowBlur) borderShadowBlur = _selectedBorderShadowBlur;
  }
  
  UIColor *fillColor = color;
  
  UIImage *icon = _iconImageView.image;
  if (isHighlighted && [_iconImageView respondsToSelector:@selector(highlightedImage)] && _iconImageView.highlightedImage) icon = _iconImageView.highlightedImage;
  
  UIImage *accessoryIcon = _accessoryImageView.image;
  if (isHighlighted && _accessoryImageView.highlightedImage) accessoryIcon = _accessoryImageView.highlightedImage;
  
  if (image) {
    [image drawInRect:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
  }
  
  CGContextSaveGState(context);
  
  // Clip for border styles that support it (that form a cohesive path)
  BOOL clip = (_borderStyle != YKUIBorderStyleTopOnly && _borderStyle != YKUIBorderStyleBottomOnly && _borderStyle != YKUIBorderStyleTopBottom);    
  
  CGFloat borderWidth = _borderWidth;
  CGFloat borderAlternateWidth = _borderAlternateWidth;
  if (borderAlternateWidth == 0) borderAlternateWidth = borderWidth;
  
  if (color && _borderStyle != YKUIBorderStyleNone) {
    YKCGContextAddStyledRect(context, bounds, _borderStyle, borderWidth, borderAlternateWidth, _cornerRadius);  
    if (clip) CGContextClip(context);
    if (shadingType != YKUIShadingTypeNone) {
      YKCGContextDrawShadingWithHeight(context, color.CGColor, color2.CGColor, color3.CGColor, color4.CGColor, self.bounds.size.height, shadingType);
      fillColor = nil;
    }
  }
  
  if (_borderWidth > 0) {
    if (borderShadowColor) {
      YKCGContextDrawBorderWithShadow(context, bounds, _borderStyle, fillColor.CGColor, borderColor.CGColor, borderWidth, borderAlternateWidth, _cornerRadius, borderShadowColor.CGColor, borderShadowBlur);
    } else {
      YKCGContextDrawBorder(context, bounds, _borderStyle, fillColor.CGColor, borderColor.CGColor, borderWidth, borderAlternateWidth, _cornerRadius);
    }
  } else if (fillColor) {
    [fillColor setFill];
    CGContextFillRect(context, self.bounds);
  }
  
  CGContextRestoreGState(context);
  
  UIColor *textColor = [self textColorForState:state];
  
  UIFont *font = self.titleFont;
  
  CGFloat y = bounds.origin.y + roundf(YKCGPointToCenter(_titleSize, size).y) + _insets.top;

  BOOL showIcon = (icon != nil && !_iconImageView.hidden);
  CGSize iconSize = _iconImageSize;
  if (icon && YKCGSizeIsZero(iconSize)) {
    iconSize = icon.size;
  }
  
  if (!_titleHidden) {
    CGFloat lineWidth = _titleSize.width + _titleInsets.left + _titleInsets.right;
    if (showIcon && _iconPosition == YKUIButtonIconPositionLeft) lineWidth += iconSize.width + 2;
    CGFloat x;
    
    if (_titleAlignment == UITextAlignmentCenter) {
      CGFloat width = size.width;
      if (accessoryIcon) width -= accessoryIcon.size.width;
      x = bounds.origin.x + roundf(width/2.0 - lineWidth/2.0);      
    } else {
      x = _insets.left;
    }
    if (x < 0) x = 0;

    if (showIcon) {
      switch (_iconPosition) {
        case YKUIButtonIconPositionLeft: {
          CGPoint iconTop = YKCGPointToCenter(iconSize, bounds.size);
          iconTop.x = x;          
          [icon drawInRect:CGRectMake(iconTop.x, iconTop.y, iconSize.width, iconSize.height)];
          x += iconSize.width + 2; // TODO(gabe): This 2px padding should come from default inset
          break;
        }
        case YKUIButtonIconPositionTop: {
          CGPoint iconTop = YKCGPointToCenter(iconSize, CGSizeMake(size.width, size.height - _titleSize.height - _titleInsets.top - _titleInsets.bottom));
          if (_iconOrigin.x != CGFLOAT_MAX) iconTop.x = _iconOrigin.x;
          if (_iconOrigin.y != CGFLOAT_MAX) iconTop.y = _iconOrigin.y;
          [icon drawInRect:CGRectMake(iconTop.x, iconTop.y, iconSize.width, iconSize.height)];
          y = iconTop.y + iconSize.height;
          break;
        }
      }
      showIcon = NO;
    } else if (!YKCGSizeIsZero(iconSize)) {
      if (_iconPosition == YKUIButtonIconPositionLeft) {
        x += iconSize.width + 2;
      }
    }
    
    y += _titleInsets.top;

    [textColor setFill];
    if (_highlightedTitleShadowColor && isHighlighted) {
      CGContextSetShadowWithColor(context, _highlightedTitleShadowOffset, 0.0, _highlightedTitleShadowColor.CGColor);
    } else if (_titleShadowColor && !isHighlighted && !isDisabled) {
      CGContextSetShadowWithColor(context, _titleShadowOffset, 0.0, _titleShadowColor.CGColor);
    }

    x += _titleInsets.left;
    CGSize titleSize = [_title drawInRect:CGRectMake(x, y, _titleSize.width, _titleSize.height) withFont:font lineBreakMode:UILineBreakModeTailTruncation];
    x += titleSize.width;
    if (_secondaryTitle) {
      if (_secondaryTitleColor) [_secondaryTitleColor set];
      if (_secondaryTitleFont) font = _secondaryTitleFont;
      [_secondaryTitle drawAtPoint:CGPointMake(x, y) withFont:font];  
    }
  }

  if (accessoryIcon) {
    [accessoryIcon drawAtPoint:YKCGPointToRight(accessoryIcon.size, CGSizeMake(size.width - 10, bounds.size.height))];
  }
    
  if (showIcon) {
    [icon drawInRect:YKCGRectToCenterInRect(iconSize, bounds)];
  }  
}

@end
