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

#import <Foundation/Foundation.h>

#import "CardView.h"
#import "SolitaireGame.h"
#import "StackView.h"

@interface GameView : UIView {
	IBOutlet UILabel *timerLabel;
	IBOutlet CardView *pile1Ctl, *pile2Ctl, *pile3Ctl, *pile4Ctl,
					  *deckCtl, *dealtCardCtl;
	StackView *highlightedPile;
}

@property (nonatomic, retain) CardView *dealtCardCtl;
@property (nonatomic, retain) CardView *deckCtl;

- (void)highlightPile:(StackView*)pile;

@end
