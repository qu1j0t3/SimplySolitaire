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

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject {
	Card *pile[52];
	int cards;
	int frontIndex; // index of topmost card (i.e. card you see if deck is face up)
	int backIndex; // index of rearmost card (top card if deck is face down)
}

- (int)cards;
- (void)fill;
- (void)shuffle;
- (Card*)topCard;
- (Card*)takeCard;
- (Card*)takeCardFromBack;
- (Card*)addCard:(Card*)card;

@end
