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
   id serial primary Key
);

--table for all matches

CREATE Table Matches
(
   id serial primary key,
   winner INTEGER REFERENCES Players(id),
   looser INTEGER REFERENCES Players(id)
); 

-- view used to make selecting players by wins concise
CREATE VIEW playersByWins AS
	SELECT * FROM Players ORDER BY wins DESC;
