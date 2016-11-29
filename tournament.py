#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2
import bleach


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")


def deleteMatches():
   """Remove all the match records from the database."""
   con = connect()
   c = con.cursor()
   c.execute("DELETE FROM Matches")
   con.commit()
   con.close()


def deletePlayers():
   """Remove all the player records from the database."""
   con = connect()
   c = con.cursor()
   c.execute("DELETE FROM Players")
   con.commit()
   con.close()


def countPlayers():
   """Returns the number of players currently registered."""
   con = connect()
   c = con.cursor()
   c.execute("SELECT count(*) FROM Players")
   count = c.fetchall()[0][0]
   con.close()
   return count


def registerPlayer(name):
    """Adds a player to the tournament database.
  
    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)
  
    Args:
      name: the player's full name (need not be unique).
    """
    playerName = bleach.clean(playerName)
    con = connect()
    c = con.cursor()
    c.execute("INSERT INTO Players VALUES(%s)",(name,))
    con.commit()
    con.close()
    
    
def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    con=connect()
    c=con.cursor()
    c.execute("SELECT playerId, name, wins, matches FROM playersBywins")
    players = c.fetchall()
    con.close()
    return players


def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
    winner = bleach.clean(winner)
    loser = bleach.clean(loser)
    con = connect()
    c=con.cursor()
    #adding match to match table
    c.execute("INSERT INTO Matches (%s, %s)",(winner,loser,))
    #adding one point in win and increasing one match
    c.execute("UPDATE Players SET wins = wins + 1, matches = matches + 1 WHERE playerId=%s",(winner,)) 
    #for looser only number of matches will increase
    c.execute("UPDATE Players SET matches=matches+1 WHERE playerId=%s",(looser,))
    con.commit()
    con.close()
 
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """
    con = connect()
    c=con.cursor()
    c.execute("SELECT * FROM playresBywins")
    players = c.fetchall()
    pairings = []
    for player1, player2 in zip(*[iter(players)]*2):
        match = (player1[id], player1[name], player2[id], player2[name])
        pairings.append(match)
    con.close()
    return pairings




