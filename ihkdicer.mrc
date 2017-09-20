// First coding experience
// Bot for dice games on mIRC

alias ihkdicer {
  $iif($$1 == on,enable,disable) #ihkdicer
  echo -ag IHKDicer $iif($$1 == on,enabled,disabled) $+ .
}
#ihkdicer on
on $*:TEXT:/^[!.@]*/i:#:{
  if ($me == IHKDicer) {
    if ($regex($1,/^[!.@]dd\b/i)) {
      if ($nick isop # || $nick ishop #) && ($2 ison $chan) && ($3 ison $chan) && ($remove($4,k,m,b) isnum) {
        if (%dice [ $+ [ $2 ] ] || %dice [ $+ [ $3 ] ]) { msg $chan Either $2 or $3 is already in a dice duel! | halt }
        set %dice  $+  $2  on
        set %dice  $+  $3  on
        set %players  $+  $2  $2 $3
        set %players  $+  $3  $2 $3
        set %host  $+  $nick  $nick
        set %host  $+  $2  $nick
        set %host  $+  $3  $nick
        set %bothplayers [ $+ [ $nick ] ] $2 $3
        set %pot [ $+ [ $nick ] ] $calc(($calc($replace($4,k,*1000,m,*1000000,b,*1000000000)) * 2) * .90/1000000)
        set %bet [ $+ [ $nick ] ] $calc($replace($4,k,*1000,m,*1000000,b,*1000000000))
        msg $chan $chr(91) $+  %host [ $+ [ $nick ] ] $+ $chr(93) New DD between $2 and $3 for a  %pot [ $+ [ $nick ] ] $+ M Pot! Good luck $+ $chr(44) please please type !roll


      }
    }
    elseif ($regex($1,/^[!.@]del\b/i)) {
      if (!%bothplayers [ $+ [ $nick ] ]) { notice $nick You are not currently hosting a dice duel }
      else { if ($nick isop # || $nick ishop #) {
          tokenize 32 %bothplayers [ $+ [ $nick ] ]
          msg $chan $chr(91) $+  %host [ $+ [ $nick ] ] $+ $chr(93) The dice-duel between $1 and $2 has been removed!
          unset %dice  $+  $1
          unset %dice  $+  $2
          unset %players  $+  $1
          unset %players  $+  $2
          unset %host  $+  $nick   $nick
          unset %roll  $+  $1
          unset %roll  $+  $2
          unset %pot  $+  %host  $+  $nick
          unset %bothplayers  $+  $nick   $2 $3
          unset %bet  $+  %host  $+  $nick
        }
      }
    }
    elseif ($regex($1,/^[!.@]preroll\b/i)) {
      notice $nick You have rolled $calc($rand(1,6)+$rand(1,6)) on the two six-sided dice!
      ignore -u8 $nick
    }
    elseif ( %roll [ $+ [ $2 ] ] ) {
      notice $2 Sorry, you have already been forced $2 $+ !
    }

    elseif ($regex($1,/^[!.@]force\b/i)) {
      if ( %players [ $+ [ $2 ] ] ) && ($nick isop # || $nick ishop #) {
        set %roll [ $+ [ $2 ] ] $calc($rand(1,6) + $rand(1,6))
        msg $chan $chr(91) $+  %host [ $+ [ $nick ] ] $+ $chr(93) $2 has rolled %roll [ $+ [ $2 ] ] on the two six-sided dice!
        tokenize 32 %players [ $+ [ $nick ] ]
        while (%roll [ $+ [ $1 ] ]) && (%roll [ $+ [ $2 ] ]) {
          if (%roll [ $+ [ $1 ] ] == %roll [ $+ [ $2 ] ]) {
            msg $chan $chr(91) $+ %host [ $+ [ $nick ] ] $+ $chr(93) It was a tie, please reroll $1 and 2 $+ !
            unset %roll  $+  $1
            unset %roll  $+  $2
          }
          else {
            msg $chan $chr(91) $+ %host [ $+ [ $nick ] ] $+ $chr(93) $iif(%roll [ $+ [ $1 ] ] > %roll [ $+ [ $2 ] ], $1 has won the %pot [ $+ [ %host [ $+ [ $nick ] ] ] ] $+ M! Sorry $2 $+ !,$2 has won the %pot [ $+ [ %host [ $+ [ $nick ] ] ] ] $+ M! Sorry $1 $+ !)
            if ( %roll [ $+ [ $1 ] ] > %roll [ $+ [ $2 ] ] ) { writeini dice.ini $1 wins $iif($readini(dice.ini,n,$1,wins),$calc($v1 + 1),1) |  writeini -n dice.ini $2 losses $iif($readini(dice.ini,n,$2,losses),$calc($v1 + 1),1) }
            if ( %roll [ $+ [ $1 ] ] < %roll [ $+ [ $2 ] ] ) { writeini dice.ini $2 wins $iif($readini(dice.ini,n,$2,wins),$calc($v1 + 1),1) |  writeini -n dice.ini $1 losses $iif($readini(dice.ini,n,$1,losses),$calc($v1 + 1),1) }
            writeini dice.ini $1 duels $iif($readini(dice.ini,n,$1,duels),$calc($v1 + 1),1)
            writeini dice.ini $2 duels $iif($readini(dice.ini,n,$2,duels),$calc($v1 + 1),1)
            writeini dice.ini $1 wagered $iif($readini(dice.ini,n,$1,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
            writeini dice.ini $2 wagered $iif($readini(dice.ini,n,$2,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
            unset %dice  $+  $1
            unset %dice  $+  $2
            unset %players  $+  $1
            unset %players  $+  $2
            unset %host  $+  $nick   $nick
            unset %roll  $+  $1
            unset %roll  $+  $2
            unset %pot  $+  %host  $+  $nick
            unset %bothplayers  $+  $nick   $2 $3
            unset %bet  $+  %host  $+  $nick
          }
        }
      }
    }

    elseif ($regex($1,/^[!.@]roll\b/i)) {
      if ( !%dice [ $+ [ $nick ] ] ) {
        notice $nick Sorry, you are currently not in a dice-duel!
      }
      elseif ( %roll [ $+ [ $nick ] ] ) {
        notice $nick Sorry, you have already rolled $nick $+ !
      }
      elseif (%dice [ $+ [ $nick ] ]) {
        set %roll [ $+ [ $nick ] ] $calc($rand(1,6) + $rand(1,6))
        msg $chan $chr(91) $+ %host [ $+ [ $nick ] ] $+ $chr(93) $nick has rolled %roll [ $+ [ $nick ] ] on the two six sided dice!
        tokenize 32 %players [ $+ [ $nick ] ]
        while (%roll [ $+ [ $1 ] ]) && (%roll [ $+ [ $2 ] ]) {
          if (%roll [ $+ [ $1 ] ] == %roll [ $+ [ $2 ] ]) {
            msg $chan $chr(91 $+ %host [ $+ [ $nick ] ] $+ $chr(93)) It was a tie, please reroll $1 and $2 $+ !
            unset %roll  $+  $1
            unset %roll  $+  $2
          }
          else {
            msg $chan $chr(91) $+ %host [ $+ [ $nick ] ] $+ $chr(93) $iif(%roll [ $+ [ $1 ] ] > %roll [ $+ [ $2 ] ], $1 has won the %pot [ $+ [ %host [ $+ [ $nick ] ] ] ] $+ M! Sorry $2 $+ !,$2 has won the %pot [ $+ [ %host [ $+ [ $nick ] ] ] ] $+ M! Sorry $1 $+ !)
            if ( %roll [ $+ [ $1 ] ] > %roll [ $+ [ $2 ] ] ) { writeini -n dice.ini $1 wins $iif($readini(dice.ini,n,$1,wins),$calc($v1 + 1),1) |  writeini -n dice.ini $2 losses $iif($readini(dice.ini,n,$2,losses),$calc($v1 + 1),1) }
            if ( %roll [ $+ [ $1 ] ] < %roll [ $+ [ $2 ] ] ) { writeini -n dice.ini $2 wins $iif($readini(dice.ini,n,$2,wins),$calc($v1 + 1),1) |  writeini -n dice.ini $1 losses $iif($readini(dice.ini,n,$1,losses),$calc($v1 + 1),1) }
            writeini dice.ini $1 duels $iif($readini(dice.ini,n,$1,duels),$calc($v1 + 1),1)
            writeini dice.ini $2 duels $iif($readini(dice.ini,n,$2,duels),$calc($v1 + 1),1)
            writeini dice.ini $1 wagered $iif($readini(dice.ini,n,$1,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
            writeini dice.ini $2 wagered $iif($readini(dice.ini,n,$2,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
            unset %dice  $+  $1
            unset %dice  $+  $2
            unset %players  $+  $1
            unset %players  $+  $2
            unset %host  $+  $nick   $nick
            unset %roll  $+  $1
            unset %roll  $+  $2
            unset %pot  $+  %host  $+  $nick
            unset %bothplayers  $+  $nick   $2 $3
            unset %bet  $+  %host  $+  $nick

          }
        }
      }
    }
    elseif ($regex($1,/^[!.@]60x2\b/i)) {
      if ($nick isop # || $nick ishop #) && ($2 ison $chan) && ($remove($3,k,m,b) isnum) {
        set %60x2 [ $+ [ $2 ] ] $rand(1,100)
        set %bet [ $+ [ $nick ] ] $calc($replace($3,k,*1000,m,*1000000,b,*1000000000))
        set %host [ $+ [ $nick ] ]
        set %60x2player [ $+ [ $nick ] ]
        msg $chan $chr(91) $+ $nick $+ $chr(93) $nick has rolled %60x2 [ $+ [ $2 ] ] on the percentile dice! $iif(%60x2 [ $+ [ $2 ] ] >= 60,$2 has won the pot of $calc($calc($replace($3,k,*1000,m,*1000000,b,*1000000000)) * 2/1000000) $+ M,Sorry bad luck $chr(44) you have lost the $calc($calc($replace($3,k,*1000,m,*1000000,b,*1000000000)) * 2/1000000) $+ M pot!)
        writeini dice.ini $2 wagered $iif($readini(dice.ini,n,$2,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
        unset %bet  $+  $nick  $+ %host [ $+  $nick
        unset %host  $+  $nick
      }
    }
    elseif ($regex($1,/^[!.@]delou\b/i)) {
      if ($nick isop # || $nick ishop #) && (!%ouplayer [ $+ [ $2 ] ]) notice $nick You are currently not hosting over/under!
      else {
        if ($nick isop # || $nick ishop #) {
        msg $chan The over/under game with $2 has been removed! }
        unset %ouplayer  $+  $nick
        unset %host  $+ [ $2 ] ] $nick
        unset %ouroll  $+  $nick
        unset %bet  $+  $nick ] ] $+ %host [ $+ [ $nick ] ]
        unset %potou [ $+ [ %host [ $+ [ $nick ] ] ] ]
      }
    }
    elseif ($regex($1,/^[!.@]ou\b/i)) {
      if ($nick isop # || $nick ishop #) && ($2 ison $chan) && ($remove($3,k,m,b) isnum) {
        if ( %ouplayer [ $+ [ $2 ] ]) {
        notice $nick Sorry $nick, that player is currently in a game of over/under! | halt }
        set %bet [ $+ [ $nick ] ] $calc($replace($3,k,*1000,m,*1000000,b,*1000000000))
        set %ouplayer [ $+ [ $2 ] ] on
        set %host [ $+ [ $2 ] ] $nick
        set %ouroll [ $+ [ $2 ] ] $calc($rand(1,6)+$rand(1,6))
        set %potou [ $+ [ $nick ] ] $calc($calc($replace($3,k,*1000,m,*1000000,b,*1000000000)) * 2/1000000) $+ M
        msg $chan $2 good luck on the %potou [ $+ [ %host [ $+ [ $nick ] ] ] ] pot! Choose !over or !under
      }
    }
    elseif ($regex($1,/^[!.@]over\b/i)) {
      if (!%ouplayer [ $+ [ $nick ] ]) { halt }
      msg $chan $nick has chosen over!
      msg $chan The two six-sided dice have landed on %ouroll [ $+ [ $nick ] ] $+ !
      if (%ouroll [ $+ [ $nick ] ] > 7) { msg $chan $nick has won the %potou [ $+ [ %host [ $+ [ $nick ] ] ] ] pot! }
      else { msg $chan $nick has lost the %potou pot, sorry $2 $+! }
      elseif (%ouroll [ $+ [ $nick ] ] == 7) { msg $chan $nick has lost the %potou [ $+ [ %host [ $+ [ $nick ] ] ] ] pot, sorry $nick $+! }
      writeini dice.ini $nick wagered $iif($readini(dice.ini,n,$nick,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
      unset %ouplayer  $+  $nick
      unset %host  $+ [ $2 ] ] $nick
      unset %ouroll  $+  $nick
      unset %bet  $+  $nick ] ] $+ %host [ $+ [ $nick ] ]
      unset %potou [ $+ [ %host [ $+ [ $nick ] ] ] ]

    }
    elseif ($regex($1,/^[!.@]under\b/i)) {
      if (!%ouplayer [ $+ [ $nick ] ])  { halt }
      msg $chan $nick has chosen under!
      msg $chan The two six-sided dice have landed on %ouroll [ $+ [ $nick ] ] $+ !
      if (%ouroll [ $+ [ $nick ] ] < 7) { msg $chan $nick has won the %potou pot! }
      else { msg $chan $nick has lost the %potou pot, sorry $nick $+ ! }
      elseif (%ouroll [ $+ [ $nick ] ] == 7) { msg $chan $nick has lost the %potou pot, sorry $nick $+ ! }
      writeini dice.ini $nick wagered $iif($readini(dice.ini,n,$nick,wagered),$calc($v1 + [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
      unset %ouplayer [ $+ [ $nick ] ]
      unset %host [ $+ [ $2 ] ] $nick
      unset %ouroll [ $+ [ $nick ] ]
      unset %bet [ $+ [ $nick ] ] $+ %host [ $+ [ $nick ] ]
      unset %potou [ $+ [ %host [ $+ [ $nick ] ] ] ]

    }
    elseif ($regex($1,/^[!.@]part\b/i)) {
      if ($nick isop # || $nick ishop #) && ($2 == IHKDicer) {
        msg $chan Sorry if I've annoyed you $nick $+ . Good bye people of this channel!
      leave # }
    }
    elseif ($regex($1,/^[!.@]delroul\b/i)) {
      if ( %host [ $+ [ $2 ] ] ) && ($nick isop # || $nick ishop #) {
      msg $chan The roulette game with $2 has been removed! }
      unset %roulroll [ $+ [ $2 ] ]
      unset %wager [ $+ [ $2 ] ]
      unset %roulplayer [ $+ [ $2 ] ] on
      unset %host [ $+ [ $2 ] ] $nick
      unset %bet [ $+ [ $nick ] ]
    }

    elseif ($regex($1,/^[!.@]roulette\b/i)) {
      if ($nick isop # || $nick ishop #) && ($2 ison $chan) && ($remove($3,k,m,b) isnum) {
        if (%roulplayer [ $+ [ $2 ] ] ) { msg $chan $2 is already in a game of roulette! | halt }
        msg $chan Good luck, choose wisely $2 $+ ! Use !choose (any numbers 1-35, up to 5 numbers; use spaces to separate them)
        set %roulroll [ $+ [ $2 ] ] $rand(1,35)
        set %wager [ $+ [ $2 ] ] $replace($3,k,*1000,m,*1000000,b,*1000000000)
        set %roulplayer [ $+ [ $2 ] ] on
        set %host [ $+ [ $2 ] ] $nick
        set %bet [ $+ [ $nick ] ] $calc($replace($3,k,*1000,m,*1000000,b,*1000000000))
        else { if ($nick !isop # || $nick !ishop #) notice $nick You must be a host to use this command, sorry! }
      }
    }
    elseif ($regex($1,/^[!.@]choose\b/i)) {
      if (%roulplayer [ $+ [ $nick ] ]) {
        if ($2 !isnum 1-35) { msg $chan Please choose numbers within the range 1-35 $nick $+ ! | halt }
        if ($3 !isnum 1-35) { msg $chan Please choose numbers within the range 1-35 $nick $+ ! | halt }
        if ($4 !isnum 1-35) { msg $chan Please choose numbers within the range 1-35 $nick $+ ! | halt }
        if ($5 !isnum 1-35) { msg $chan Please choose numbers within the range 1-35 $nick $+ ! | halt }
        if ($6 !isnum 1-35) { msg $chan Please choose numbers within the range 1-35 $nick $+ ! | halt }
        if ($2 isnum 1-35) { set %pick1 $2 }
        if ($3 isnum 1-35) { set %pick2 $3 }
        if ($4 isnum 1-35) { set %pick3 $4 }
        if ($5 isnum 1-35) { set %pick4 $5 }
        if ($6 isnum 1-35) { set %pick5 $6 }
        if ( %pick1 ) { set %totalpot $calc(%wager [ $+ [ $nick ] ] *10/1000000) $+ M! }
        if ( %pick1 && %pick2 ) { set %totalpot $calc(%wager [ $+ [ $nick ] ] *6/1000000) $+ M! }
        if ( %pick1 && %pick2 && %pick3 ) { set %totalpot $calc(%wager [ $+ [ $nick ] ] *3/1000000) $+ M! }
        if ( %pick1 && %pick2 && %pick3 && %pick4) { set %totalpot $calc(%wager [ $+ [ $nick ] ] *4/1000000) $+ M! }
        if ( %pick1 && %pick2 && %pick3 && %pick4 && %pick5) { set %totalpot $calc(%wager [ $+ [ $nick ] ] *2.5/1000000) $+ M! }
        if ($2 ==  %roulroll [ $+ [ $nick ] ] || $3 ==  %roulroll [ $+ [ $nick ] ] || $4 ==  %roulroll [ $+ [ $nick ] ] || $5 ==  %roulroll [ $+ [ $nick ] ] || $6 ==  %roulroll [ $+ [ $nick ] ] )  { msg $chan The ball has landed on %roulroll [ $+ [ $nick ] ] $nick $+ .
          msg $chan Congratulations $nick you have won the pot of %totalpot
          writeini dice.ini $nick wagered $iif($readini(dice.ini,n,$nick,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
          unset %wager [ $+ [ $nick ] ]
          unset %roulroll [ $+ [ $nick ] ]
          unset %pick1
          unset %pick2
          unset %pick3
          unset %pick4
          unset %totalpot
          unset %wager [ $+ [ $nick ] ]
          unset %roulplayer [ $+ [ $nick ] ]
          unset %bet [ $+ [ %host [ $+ [ $nick ] ] ] ]
          unset %host [ $+ [ $nick ] ] $nick
        }
        else { msg $chan The ball has landed on %roulroll [ $+ [ $nick ] ] $nick $+ . | msg $chan Sorry $nick you have lost the pot of %totalpot }
        writeini dice.ini $nick wagered $iif($readini(dice.ini,n,$nick,wagered),$calc($v1 + %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] ), %bet [ $+ [ %host [ $+ [ $nick ] ] ] ] )
        unset %wager [ $+ [ $nick ] ]
        unset %roulroll [ $+ [ $nick ] ]
        unset %pick1
        unset %pick2
        unset %pick3
        unset %pick4
        unset %pick5
        unset %totalpot
        unset %wager [ $+ [ $nick ] ]
        unset %roulplayer [ $+ [ $nick ] ]
        unset %bet [ $+ [ %host [ $+ [ $nick ] ] ] ]
        unset %host [ $+ [ $nick ] ] $nick
      }
    }
    elseif ($regex($1,/^[!.@]stats/i)) {
      var %who $iif($2,$2,$nick)
      msg $chan $+($chr(91),%who,$chr(93)) $chr(91) $+ Total Wagered: $bytes($readini(dice.ini,n,%who,wagered),b) $+ $chr(93) $chr(91) $+ Win/Loss Ratio: $round($calc($readini(dice.ini,n,%who,wins) / $readini(dice.ini,n,%who,losses)),2) $+ $chr(93) $chr(91) $+ Total Duels: $calc( $readini(dice.ini,n,%who,wins) + $readini(dice.ini,n,%who,losses)) $+ $chr(93) $chr(91) $+ Total Wins: $iif($readini(dice.ini,n,%who,wins),$v1,0) $+ $chr(93) $chr(91) $+ Total Losses: $iif($readini(dice.ini,n,%who,losses),$v1,0) $+ $chr(93)
    }
  }
}

#ihkdicer end
