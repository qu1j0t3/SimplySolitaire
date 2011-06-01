/* This file is part of SimplySolitaire, an iPhone/iPod application.
 * Copyright (C) 2011 Toby Thain <toby@telegraphics.com.au>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

//  Created by Toby Thain on 5/15/11.

#include <math.h>

#import "GameView.h"

@implementation GameView

@synthesize dealtCardCtl;
@synthesize deckCtl;

/*
- (id)initWithCoder:(NSCoder*)aDecoder {
	if(self = [super initWithCoder:aDecoder]){
	}
	return self;
}*/

- (void)highlightPile:(StackView*)pile {
	if(pile != highlightedPile){
		if(highlightedPile)
			[self setNeedsDisplayInRect:[highlightedPile highlightRect]];
		if(pile)
			[self setNeedsDisplayInRect:[pile highlightRect]];
		highlightedPile = pile;
	}
}

- (void)roundRect:(CGRect)rect cornerRadius:(float)rad inContext:(CGContextRef)ctx {
	CGRect r = CGRectInset(rect, rad, rad);

	CGContextBeginPath(ctx);
	CGContextAddArc(ctx, CGRectGetMinX(r), CGRectGetMaxY(r), rad, M_PI, M_PI/2, YES);
	CGContextAddArc(ctx, CGRectGetMaxX(r), CGRectGetMaxY(r), rad, M_PI/2, 0, YES);
	CGContextAddArc(ctx, CGRectGetMaxX(r), CGRectGetMinY(r), rad, 0, -M_PI/2, YES);
	CGContextAddArc(ctx, CGRectGetMinX(r), CGRectGetMinY(r), rad, -M_PI/2, -M_PI, YES);
	CGContextClosePath(ctx);
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];

	if(highlightedPile
	   && CGRectIntersectsRect(rect, [highlightedPile highlightRect]))
	{
		/*CGSize offset = CGSizeMake(0, 0);
		float white = {1, 1, 1, .4};
		CGColorRef colRef;
		CGColorSpaceRef colSpaceRef;
		
		CGContextSaveGState(ctx);
		colSpaceRef = CGColorSpaceCreateDeviceRGB();
		colRef = CGColorCreate(colSpaceRef, white);
		CGContextSetShadowWithColor(ctx, offset, 5, colRef);*/
		CGRect r = CGRectInset([highlightedPile highlightRect], 3, 3);
		
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGContextSetRGBStrokeColor(ctx, 1, 1, 1, .8);
		//CGContextStrokeRectWithWidth(ctx, r, 3.0);
		[self roundRect:r cornerRadius:6 inContext:ctx];
		CGContextSetLineWidth(ctx, 5);
		CGContextStrokePath(ctx);
	}
}

@end
