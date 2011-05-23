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

#import "GameView.h"

@implementation GameView

@synthesize dealtCardCtl;
@synthesize deckCtl;
@synthesize draggingCard;

/*
- (id)initWithCoder:(NSCoder*)aDecoder {
	if(self = [super initWithCoder:aDecoder]){
	}
	return self;
}*/

- (CGRect)highlightRectOf:pile {
	return CGRectInset([pile frame], -6, -6);
}

- (void)highlightPile:(CardView*)pile {
	if(pile != highlightedPile){
		if(highlightedPile)
			[self setNeedsDisplayInRect:[self highlightRectOf:highlightedPile]];
		if(pile)
			[self setNeedsDisplayInRect:[self highlightRectOf:pile]];
		highlightedPile = pile;
	}
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];

	if(highlightedPile && CGRectIntersectsRect(rect, [self highlightRectOf:highlightedPile])){
		/*CGSize offset = CGSizeMake(0, 0);
		float white = {1, 1, 1, .4};
		CGColorRef colRef;
		CGColorSpaceRef colSpaceRef;
		
		CGContextSaveGState(ctx);
		colSpaceRef = CGColorSpaceCreateDeviceRGB();
		colRef = CGColorCreate(colSpaceRef, white);
		CGContextSetShadowWithColor(ctx, offset, 5, colRef);*/
		CGRect r = CGRectInset([self highlightRectOf:highlightedPile], 3, 3);
		
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGContextSetRGBStrokeColor(ctx, 1, 1, 1, .5);
		CGContextStrokeRectWithWidth(ctx, r, 3.0);
	}
}

@end
