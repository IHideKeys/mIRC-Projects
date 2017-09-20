// Sajiel Chishti
// Jan 30th, 2013
// Gop Bot
// Record scores for Great Orb Project Games
// View scores of other players, Overall hiscores

on $*:TEXT:/^[!.@]*/i:#:{
  if ($me == Gop) {
    if ($regex($1,/^[!.@]duo\b/i)) {
      writeini duoscores.ini $nick Air $readini(duoscores.ini,n,$nick,Air) $3
      writeini duoscores.ini $2 Air $readini(duoscores.ini,n,$2,Air) $3
      writeini duoscores.ini $nick Mind $readini(duoscores.ini,n,$nick,Mind) $4
      writeini duoscores.ini $2 Mind $readini(duoscores.ini,n,$2,Mind) $4
      writeini duoscores.ini $nick Water $readini(duoscores.ini,n,$nick,Water) $5
      writeini duoscores.ini $2 Water $readini(duoscores.ini,n,$2,Water) $5
      writeini duoscores.ini $nick Earth $readini(duoscores.ini,n,$nick,Earth) $6
      writeini duoscores.ini $2 Earth $readini(duoscores.ini,n,$2,Earth) $6
      writeini duoscores.ini $nick Fire $readini(duoscores.ini,n,$nick,Fire) $7
      writeini duoscores.ini $2 Fire $readini(duoscores.ini,n,$2,Fire) $7
      writeini duoscores.ini $nick Body $readini(duoscores.ini,n,$nick,Body) $8
      writeini duoscores.ini $2 Body $readini(duoscores.ini,n,$2,Body) $8
      writeini duoscores.ini $nick Total $readini(duoscores.ini,n,$nick,Total) $calc( $3 + $4 + $5 + $6 + $7 + $8 )
      writeini duoscores.ini $2 Total $readini(duoscores.ini,n,$2,Total) $calc( $3 + $4 + $5 + $6 + $7 + $8 )
      notice $nick  You have added the following for $nick and $2 $+ : Air: $3 Mind: $4 Water: $5 Earth: $6 Fire: $7 Body: $8 Total: $calc( $3 + $4 + $5 + $6 + $7 + $8 )
    }
    elseif ($regex($1,/^[!.@]gduo\b/i)) {
      writeini gduoscores.ini $nick Air $readini(gduoscores.ini,n,$nick,Air) $3
      writeini gduoscores.ini $2 Air $readini(gduoscores.ini,n,$2,Air) $3
      writeini gduoscores.ini $nick Mind $readini(gduoscores.ini,n,$nick,Mind) $4
      writeini gduoscores.ini $2 Mind $readini(gduoscores.ini,n,$2,Mind) $4
      writeini gduoscores.ini $nick Water $readini(gduoscores.ini,n,$nick,Water) $5
      writeini gduoscores.ini $2 Water $readini(gduoscores.ini,n,$2,Water) $5
      writeini gduoscores.ini $nick Earth $readini(gduoscores.ini,n,$nick,Earth) $6
      writeini gduoscores.ini $2 Earth $readini(gduoscores.ini,n,$2,Earth) $6
      writeini gduoscores.ini $nick Fire $readini(gduoscores.ini,n,$nick,Fire) $7
      writeini gduoscores.ini $2 Fire $readini(gduoscores.ini,n,$2,Fire) $7
      writeini gduoscores.ini $nick Body $readini(gduoscores.ini,n,$nick,Body) $8
      writeini gduoscores.ini $2 Body $readini(gduoscores.ini,n,$2,Body) $8
      writeini gduoscores.ini $nick Total $readini(gduoscores.ini,n,$nick,Total) $calc( $3 + $4 + $5 + $6 + $7 + $8 )
      writeini gduoscores.ini $2 Total $readini(gduoscores.ini,n,$2,Total) $calc( $3 + $4 + $5 + $6 + $7 + $8 )
      notice $nick  You have added the following for $nick and $2 $+ : Air: $3 Mind: $4 Water: $5 Earth: $6 Fire: $7 Body: $8 Total: $calc( $3 + $4 + $5 + $6 + $7 + $8 )
    }

    elseif ($regex($1,/^[!.@]solo\b/i)) {
      writeini soloscores.ini $nick Air $readini(soloscores.ini,n,$nick,Air) $2
      writeini soloscores.ini $nick Mind $readini(soloscores.ini,n,$nick,Mind) $3
      writeini soloscores.ini $nick Water $readini(soloscores.ini,n,$nick,Water) $4
      writeini soloscores.ini $nick Earth $readini(soloscores.ini,n,$nick,Earth) $5
      writeini soloscores.ini $nick Fire $readini(soloscores.ini,n,$nick,Fire) $6
      writeini soloscores.ini $nick Body $readini(soloscores.ini,n,$nick,Body) $7
      writeini soloscores.ini $nick Total $readini(soloscores.ini,n,$nick,Total) $calc( $2 + $3 + $4 + $5 + $6 + $7 )
      notice $nick  You have added the following for $nick $+ : Air: $2 Mind: $3 Water: $4 Earth: $5 Fire: $6 Body: $7 Total: $calc( $2 + $3 + $4 + $5 + $6 + $7 )

    }
    elseif ($regex($1,/^[!.@]gsolo\b/i)) {
      writeini gsoloscores.ini $nick Air $readini(gsoloscores.ini,n,$nick,Air) $2
      writeini gsoloscores.ini $nick Mind $readini(gsoloscores.ini,n,$nick,Mind) $3
      writeini gsoloscores.ini $nick Water $readini(gsoloscores.ini,n,$nick,Water) $4
      writeini gsoloscores.ini $nick Earth $readini(gsoloscores.ini,n,$nick,Earth) $5
      writeini gsoloscores.ini $nick Fire $readini(gsoloscores.ini,n,$nick,Fire) $6
      writeini gsoloscores.ini $nick Body $readini(gsoloscores.ini,n,$nick,Body) $7
      writeini gsoloscores.ini $nick Total $readini(gsoloscores.ini,n,$nick,Total) $calc( $2 + $3 + $4 + $5 + $6 + $7 )
      notice $nick  You have added the following for $nick $+ : Air: $2 Mind: $3 Water: $4 Earth: $5 Fire: $6 Body: $7 Total: $calc( $2 + $3 + $4 + $5 + $6 + $7 )

    }
    elseif ($regex($1,/^[!.@]maxsolo\b/i)) {
      writeini maxsoloscores.ini $nick Air $2
      writeini maxsoloscores.ini $nick Mind $3
      writeini maxsoloscores.ini $nick Water $4
      writeini maxsoloscores.ini $nick Earth $5
      writeini maxsoloscores.ini $nick Fire $6
      writeini maxsoloscores.ini $nick Body $7
      writeini maxsoloscores.ini $nick Total $calc( $2 + $3 + $4 + $5 + $6 + $7 )
      notice $nick You have just added the following for $nick $+ : Air: $2 Mind: $3 Water: $4 Earth: $5 Fire: $6 Body: $7 Total: $calc( $2 + $3 + $4 + $5 + $6 + $7 ) $+ !
    }
    elseif ($regex($1,/^[!.@]maxduo\b/i)) {
      writeini maxduoscores.ini $nick Air $2
      writeini maxduoscores.ini $nick Mind $3
      writeini maxduoscores.ini $nick Water $4
      writeini maxduoscores.ini $nick Earth $5
      writeini maxduoscores.ini $nick Fire $6
      writeini maxduoscores.ini $nick Body $7
      writeini maxduoscores.ini $nick Total $calc( $2 + $3 + $4 + $5 + $6 + $7 )
      notice $nick You have just added the following for $nick $+ : Air: $2 Mind: $3 Water: $4 Earth: $5 Fire: $6 Body: $7 Total: $calc( $2 + $3 + $4 + $5 + $6 + $7 ) $+ !
    }
        elseif ($regex($1,/^[!.@]maxduo\b/i)) {
      writeini maxduoscores.ini $nick Air $2
      writeini maxduoscores.ini $nick Mind $3
      writeini maxduoscores.ini $nick Water $4
      writeini maxduoscores.ini $nick Earth $5
      writeini maxduoscores.ini $nick Fire $6
      writeini maxduoscores.ini $nick Body $7
      writeini maxduoscores.ini $nick Total $calc( $2 + $3 + $4 + $5 + $6 + $7 )
      notice $nick You have just added the following for $nick $+ : Air: $2 Mind: $3 Water: $4 Earth: $5 Fire: $6 Body: $7 Total: $calc( $2 + $3 + $4 + $5 + $6 + $7 ) $+ !
    }
    elseif ($regex($1,/^[!.@]stats/i)) {
      var %who $iif($2,$2,$nick)
      msg $nick $+($chr(91),%who,$chr(93)) $chr(91) $+ Solo Avg $+ $chr(93) $chr(91) $+ Total: $round($calc(( $replace($readini(soloscores.ini,n,%who,Total),$chr(32),+) ) / $numtok($readini(soloscores.ini,n,%who,Total),32)),1) $+ / $+ $round($calc(( $replace($readini(gsoloscores.ini,n,%who,Total),$chr(32),+) ) / $numtok($readini(gsoloscores.ini,n,%who,Total),32)),1) $+ $chr(93) $chr(91) $+ Air: $round($calc(( $replace($readini(soloscores.ini,n,%who,air),$chr(32),+) ) / $numtok($readini(soloscores.ini,n,%who,air),32)),1) $+ / $+ $round($calc(( $replace($readini(gsoloscores.ini,n,%who,air),$chr(32),+) ) / $numtok($readini(gsoloscores.ini,n,%who,air),32)),1) $+ $chr(93) $chr(91) $+ Mind: $round($calc(( $replace($readini(soloscores.ini,n,%who,Mind),$chr(32),+) ) / $numtok($readini(soloscores.ini,n,%who,Mind),32)),1) $+ / $+ $round($calc(( $replace($readini(gsoloscores.ini,n,%who,Mind),$chr(32),+) ) / $numtok($readini(gsoloscores.ini,n,%who,Mind),32)),1) $+ $chr(93) $chr(91) $+ Water: $round($calc(( $replace($readini(soloscores.ini,n,%who,Water),$chr(32),+) ) / $numtok($readini(soloscores.ini,n,%who,Water),32)),1) $+ / $+ $round($calc(( $replace($readini(gsoloscores.ini,n,%who,Water),$chr(32),+) ) / $numtok($readini(gsoloscores.ini,n,%who,Water),32)),1) $+ $chr(93) $chr(91) $+ Earth: $round($calc(( $replace($readini(soloscores.ini,n,%who,Earth),$chr(32),+) ) / $numtok($readini(soloscores.ini,n,%who,Earth),32)),1) $+ / $+ $round($calc(( $replace($readini(gsoloscores.ini,n,%who,Earth),$chr(32),+) ) / $numtok($readini(gsoloscores.ini,n,%who,Earth),32)),1)$+ $chr(93) $chr(91) $+ Fire: $round($calc(( $replace($readini(soloscores.ini,n,%who,Fire),$chr(32),+) ) / $numtok($readini(soloscores.ini,n,%who,Fire),32)),1) $+ / $+ $round($calc(( $replace($readini(gsoloscores.ini,n,%who,Fire),$chr(32),+) ) / $numtok($readini(gsoloscores.ini,n,%who,Fire),32)),1) $+ $chr(93) $chr(91) $+ Body: $round($calc(( $replace($readini(soloscores.ini,n,%who,Body),$chr(32),+) ) / $numtok($readini(soloscores.ini,n,%who,Body),32)),1) $+ / $+ $round($calc(( $replace($readini(gsoloscores.ini,n,%who,Body),$chr(32),+) ) / $numtok($readini(gsoloscores.ini,n,%who,Body),32)),1) $+ $chr(93)
      msg $nick $+($chr(91),%who,$chr(93)) $chr(91) $+ Duo Avg $+ $chr(93) $chr(91) $+ Total: $round($calc(( $replace($readini(duoscores.ini,n,%who,Total),$chr(32),+) ) / $numtok($readini(duoscores.ini,n,%who,Total),32)),1) $+ / $+ $round($calc(( $replace($readini(gduoscores.ini,n,%who,Total),$chr(32),+) ) / $numtok($readini(gduoscores.ini,n,%who,Total),32)),1) $+ $chr(93) $chr(91) $+ Air: $round($calc(( $replace($readini(duoscores.ini,n,%who,air),$chr(32),+) ) / $numtok($readini(duoscores.ini,n,%who,air),32)),1) $+ / $+ $round($calc(( $replace($readini(gduoscores.ini,n,%who,air),$chr(32),+) ) / $numtok($readini(gduoscores.ini,n,%who,air),32)),1) $+ $chr(93) $chr(91) $+ Mind: $round($calc(( $replace($readini(duoscores.ini,n,%who,Mind),$chr(32),+) ) / $numtok($readini(duoscores.ini,n,%who,Mind),32)),1) $+ / $+ $round($calc(( $replace($readini(gduoscores.ini,n,%who,Mind),$chr(32),+) ) / $numtok($readini(gduoscores.ini,n,%who,Mind),32)),1) $+ $chr(93) $chr(91) $+ Water: $round($calc(( $replace($readini(duoscores.ini,n,%who,Water),$chr(32),+) ) / $numtok($readini(duoscores.ini,n,%who,Water),32)),1) $+ / $+ $round($calc(( $replace($readini(gduoscores.ini,n,%who,Water),$chr(32),+) ) / $numtok($readini(gduoscores.ini,n,%who,Water),32)),1) $+ $chr(93) $chr(91) $+ Earth: $round($calc(( $replace($readini(duoscores.ini,n,%who,Earth),$chr(32),+) ) / $numtok($readini(duoscores.ini,n,%who,Earth),32)),1) $+ / $+ $round($calc(( $replace($readini(gduoscores.ini,n,%who,Earth),$chr(32),+) ) / $numtok($readini(gduoscores.ini,n,%who,Earth),32)),1) $+ $chr(93) $chr(91) $+ Fire: $round($calc(( $replace($readini(duoscores.ini,n,%who,Fire),$chr(32),+) ) / $numtok($readini(duoscores.ini,n,%who,Fire),32)),1) $+ / $+ $round($calc(( $replace($readini(gduoscores.ini,n,%who,Fire),$chr(32),+) ) / $numtok($readini(gduoscores.ini,n,%who,Fire),32)),1) $+ $chr(93) $chr(91) $+ Body: $round($calc(( $replace($readini(duoscores.ini,n,%who,Body),$chr(32),+) ) / $numtok($readini(duoscores.ini,n,%who,Body),32)),1) $+ / $+ $round($calc(( $replace($readini(gduoscores.ini,n,%who,Body),$chr(32),+) ) / $numtok($readini(gduoscores.ini,n,%who,Body),32)),1) $+ $chr(93)
      msg $nick $+($chr(91),%who,$chr(93)) $chr(91) $+ Maxes $+ $chr(93) $chr(91) $+ Total: $iif($readini(maxsoloscores.ini,n,%who,Total),$v1,0) $+ / $+ $iif($readini(maxduoscores.ini,n,%who,Total),$v1,0) $+ $chr(93) $chr(91) $+ Air: $iif($readini(maxsoloscores.ini,n,%who,Air),$v1,0) $+ / $+ $iif($readini(maxduoscores.ini,n,%who,Air),$v1,0) $+ $chr(93) $chr(91) $+ Mind: $iif($readini(maxsoloscores.ini,n,%who,Mind),$v1,0) $+ / $+ $iif($readini(maxduoscores.ini,n,%who,Mind),$v1,0) $+ $chr(93) $chr(91) $+ Water: $iif($readini(maxsoloscores.ini,n,%who,Water),$v1,0) $+ / $+ $iif($readini(maxduoscores.ini,n,%who,Water),$v1,0) $+ $chr(93) $chr(91) $+ Earth: $iif($readini(maxsoloscores.ini,n,%who,Earth),$v1,0) $+ / $+ $iif($readini(maxduoscores.ini,n,%who,Earth),$v1,0) $+ $chr(93) $chr(91) $+ Fire: $iif($readini(maxsoloscores.ini,n,%who,Fire),$v1,0) $+ / $+ $iif($readini(maxduoscores.ini,n,%who,Fire),$v1,0) $+ $chr(93) $chr(91) $+ Body: $iif($readini(maxsoloscores.ini,n,%who,Body),$v1,0) $+ / $+ $iif($readini(maxduoscores.ini,n,%who,Body),$v1,0) $+ $chr(93)
    }
    elseif ($regex($1,/^[!.@]help/i)) {
      notice $nick Hello $nick $+ ! My commands: !solo (air) (mind) (water) (earth) (fire) (body), !duo (partner) (air) (mind) (water) (earth) (fire) (body): In both commands please use the appropriate syntax. Where it says Air your air score must go, etc. The final command is !stats, this command will display statistics for a player's averages.
      notice $nick !maxsolo (air) (mind) (water) (earth) (fire) (body) allows you to set your solo maxes!
      notice $nick If you have any bugs or suggestions, please /query IHideKeys or /query Gop, and let either know immeadiately. Thank you $nick $+ !

    }
  }
}
