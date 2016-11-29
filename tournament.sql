-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS Tournament;

CREATE DATABASE tournament;

\c tournament;
-- players table
CREATE TABLE Players
(
   playerName text,
   wins int Default 0,
   matches int Default 0,
   playerId serial primary Key
);

--table for all matches

CREATE Table Matches
(
   matchId serial primary key,
   winner int foreign key references Players(playerId),
   looser int foreign key references Players(playerId)
); 

-- view used to make selecting players by wins concise
CREATE VIEW playersByWins AS
	SELECT * FROM Players ORDER BY wins DESC;
