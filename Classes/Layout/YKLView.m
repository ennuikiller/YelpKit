//
//  YKLView.m
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

#import "YKLView.h"
#import "YKCGUtils.h"

@implementation YKLView

@synthesize frame=_frame;

- (CGSize)sizeThatFits:(CGSize)size {
  return _frame.size;
}

- (CGRect)sizeThatFitsInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
  CGSize sizeThatFits = [self sizeThatFits:rect.size];
  CGRect frame;
  if (contentMode == UIViewContentModeCenter) {
    frame = YKCGRectToCenter(sizeThatFits, rect.size);
    frame.origin.x += rect.origin.x;
    frame.origin.y += rect.origin.y;
  } else {
    [NSException raise:NSInvalidArgumentException format:@"Only contentMode UIViewContentModeCenter is supported"];
  }
  return frame;
}

- (CGPoint)origin {
  return _frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
  _frame = CGRectMake(origin.x, origin.y, _frame.size.width, _frame.size.height);
}

- (void)drawInRect:(CGRect)rect { }

- (void)drawRect:(CGRect)rect { 
  [self drawInRect:self.frame];
}

- (void)draw {
  [self drawRect:self.frame];
}

@end
