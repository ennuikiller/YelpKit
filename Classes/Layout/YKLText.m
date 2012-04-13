//
//  YKLText.m
//  YelpKit
//
//  Created by Gabriel Handford on 4/11/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
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

#import "YKLText.h"
#import "YKCGUtils.h"

@implementation YKLText

- (id)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color lineBreakMode:(UILineBreakMode)lineBreakMode {
  if ((self = [super init])) {
    _text = [text retain];
    _font = [font retain];
    _color = [color retain];
    _lineBreakMode = lineBreakMode;
    _sizeThatFits = YKCGSizeNull;
    _sizeForSizeThatFits = YKCGSizeNull;
  }
  return self;
}

- (void)dealloc {
  [_text release];
  [_font release];
  [_color release];
  [super dealloc];
}

+ (YKLText *)text:(NSString *)text font:(UIFont *)font {
  return [self text:text font:font color:nil lineBreakMode:-1];
}

+ (YKLText *)text:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
  return [self text:text font:font color:color lineBreakMode:-1];
}

+ (YKLText *)text:(NSString *)text font:(UIFont *)font color:(UIColor *)color lineBreakMode:(UILineBreakMode)lineBreakMode {
  return [[[YKLText alloc] initWithText:text font:font color:color lineBreakMode:lineBreakMode] autorelease];
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (size.width == 0) return size;
  
  if (YKCGSizeIsEqual(size, _sizeForSizeThatFits) && !YKCGSizeIsNull(_sizeThatFits)) return _sizeThatFits;
  
  if (_lineBreakMode == -1) {
    _sizeThatFits = [_text sizeWithFont:_font];
  } else {
    _sizeThatFits = [_text sizeWithFont:_font forWidth:_frame.size.width lineBreakMode:_lineBreakMode];
  }
  _sizeForSizeThatFits = size;
  return _sizeThatFits;
}

- (void)draw {
  if (_color) [_color setFill];
  if (_lineBreakMode == -1 || _frame.size.width > 0) {
    [_text drawAtPoint:_frame.origin withFont:_font];
  } else {
    [_text drawAtPoint:_frame.origin forWidth:_frame.size.width withFont:_font lineBreakMode:_lineBreakMode];
  }
}

@end
