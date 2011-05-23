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

#import "Deck.h"

@implementation Deck

- (int)cards {
	return cards;
}

- (Card*)takeCard {
	if(cards > 0){
		--cards;
		return pile[frontIndex--];
	}else{
		[NSException raise:@"deck empty" format:@""];
	}
	return nil;
}

- (Card*)takeCardFromBack {
	if(cards > 0){
		--cards;
		return pile[backIndex++];
	}else{
		[NSException raise:@"deck empty" format:@""];
	}
	return nil;
}

- (Card*)topCard {
	return cards > 0 ? pile[frontIndex] : nil;
}

// adds card to face-up end of deck
- (Card*)addCard:(Card*)card {
	if(cards < 52){
		if(cards)
			++frontIndex;
		++cards;
		return pile[frontIndex] = card;
	}else
		[NSException raise:@"deck full" format:@""];
	return nil;
}

- (void)fill {
	int i;
	
	cards = 52;
	frontIndex = cards-1;
	backIndex = 0;
	for(i = 0; i < cards; ++i)
		pile[i] = [Card withSuit:(i/13+1) value:((i%13)+1)];
}

- (void)shuffle {
	int n, idx;
	Card *card;
	
	for(n = cards; n; --n){
		idx = backIndex + (rand() % n);
		
		card = pile[idx];
		pile[idx] = pile[backIndex+n-1];
		pile[backIndex+n-1] = card;
	}
}

@end
