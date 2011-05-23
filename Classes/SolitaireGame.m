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

#import "SolitaireGame.h"
#import "GameView.h"

// This class models game state. It should not deal with any view directly.

@implementation SolitaireGame

- (void)dealloc {
	if(gameDeck) [gameDeck release];
	if(discards) [discards release];
	
	[super dealloc];
}

- (void)start {
	srand(time(NULL));
	gameDeck = [[Deck alloc] init];
	[gameDeck fill];
	[gameDeck shuffle];
	assert([gameDeck cards] == 52);
	discards = [[Deck alloc] init];
	// TODO: clear out all the piles
	// reset timer
}

- (Card*)dealCard {
	if([gameDeck cards] == 0){
		gameDeck = discards;
		discards = [[Deck alloc] init];
	}
	Card *c = [gameDeck takeCardFromBack];
	return [discards addCard:c];
}

- (Card*)takeDealt {
	return [discards takeCard];
}

- (Deck*)gameDeck { return gameDeck; }

@end
