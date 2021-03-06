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

#import <Foundation/Foundation.h>

#import "Card.h"

// A CardListNode is a pointer to the bottom card of a face-up card pile.

@interface CardListNode : NSObject {
	Card *card;
	CardListNode *next; // points to card on top of this one
}

@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) CardListNode *next;

- (void)drawInRect:(CGRect)r cardsUnder:(CardListNode*)draggedCard;
- (void)drawInRect:(CGRect)r;
- (CGRect)nextCardRect:(CGRect)bottomCardRect;
- (CardListNode*)hitTest:(CGPoint)pt inRect:(CGRect)r;

@end
