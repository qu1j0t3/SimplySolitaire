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

#import "Card.h"

@implementation Card

static Card *deck[4][13];

/* not sure if this is needed
+ (void)initialize
{
	int s, v;
	for(s = 0; s < 4; ++s)
		for(v = 0; v < 13; ++v)
			deck[s][v] = nil;
}*/

- (id)initWithSuit:(int)s value:(int)v
{
	if(s < 1 || s > 4 || v < 1 || v > 13)
		return nil;

	self = [super init];
	suit = s;
	value = v;
	image = [UIImage imageNamed:
				[NSString stringWithFormat:@"card-%d-%d.png", suit, value]];
	return self;
}	

- (UIImage*)image { return image; }
- (int)suit { return suit; }
- (int)value { return value; }


// this class method ensures that cards come from a fixed pool of 52.
+ (id)withSuit:(int)suit value:(int)value
{
	if(deck[suit-1][value-1] == nil)
		deck[suit-1][value-1] = [[Card alloc] initWithSuit:suit value:value];
	
	return deck[suit-1][value-1];
}

- (void)drawInRect:(CGRect)r {
	[[self image] drawInRect:r];
}

@end
