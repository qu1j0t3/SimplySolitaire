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

//  Created by Toby Thain on 5/14/11.

#import "CardView.h"
#import "GameView.h"

@implementation CardView

- (Card*)card { return card; }

- (void)setCard:(Card*)newCard {
	card = newCard;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if(card){
		// TODO: draw a shadow if being dragged
		// scale card height in proportion to width
		[card drawInRect:rect];
	}
	/*else{
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGRect r = CGRectInset(rect, 3.0, 3.0);
		static CGFloat dashing[] = {4.0, 2.0},
					   strokeColour[] = {1.0, 1.0, 1.0};
		
		CGContextSetLineWidth(ctx, 2.0);
		CGContextSetLineDash(ctx, 0.0, dashing, 2);
		CGContextAddRect(ctx, r);
		//CGContextSetStrokeColor(ctx, strokeColour);
		CGContextDrawPath(ctx, kCGPathStroke);
	}*/
}

@end
