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
   name text,
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
CREATE VIEW View_wins AS
	SELECT Players.id AS player, count(matches.winner) AS win FROM players, 
	Matches WHERE Players.id = Matches.winner GROUP BY Players.id,
	Matches.winner ORDER BY win;
	

CREATE VIEW View_lose AS
      SELECT Players.id AS player, count(matches.looser)	As losses From Players, 
      Matches WHERE Players.id = Matches.looser GROUP BY Players.id,
      Matches.looser ORDER BY losses;
       

CREATE VIEW View_match AS
      SELECT Players.id AS player, count(Matches) AS matches From Players, Matches
      WHERE(Players.id = Matches.winner) OR(Players.id = Matches.looser)
      GROUP BY Players.id ORDER BY Players.id ASC;
                
      
