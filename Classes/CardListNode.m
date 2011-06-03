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

//  Created by Toby Thain on 5/23/11.

#import "CardListNode.h"

@implementation CardListNode

@synthesize card;
@synthesize next;

// vertical distance between this card and the card on top
#define CARD_OFFSET 15

- (void)drawInRect:(CGRect)r cardsUnder:(CardListNode*)draggedCard {
	// don't draw cards that are being dragged
	if(self != draggedCard){
		[[self card] drawInRect:r];
		if(next)
			[next drawInRect:CGRectOffset(r, 0, CARD_OFFSET)];
	}
}

- (void)drawInRect:(CGRect)r {
	[self drawInRect:r cardsUnder:nil];
}

- (CGRect)nextCardRect:(CGRect)myRect {
	CGRect r = CGRectOffset(myRect, 0, CARD_OFFSET);
	return next ? [next nextCardRect:r]
				: CGRectInset(r, -6, -6);
}

- (CardListNode*)hitTest:(CGPoint)pt inRect:(CGRect)r belowHit:(CardListNode*)node {
	CardListNode *hitMe = CGRectContainsPoint(r, pt) ? self : node;
	
	if(next) // need to check all cards on top of this one:
		return [next hitTest:pt inRect:CGRectOffset(r, 0, CARD_OFFSET) belowHit:hitMe];
	else
		return hitMe;
}

- (CardListNode*)hitTest:(CGPoint)pt inRect:(CGRect)r {
	return [self hitTest:pt inRect:r belowHit:nil];
}

@end
