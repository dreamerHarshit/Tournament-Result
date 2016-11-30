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
CREATE VIEW standings_view AS
SELECT p1_count.id as pid,name,wins.count_wins as wins, (p1_count.n_matches + p2_count.n_matches) as matches
    FROM
    (SELECT Players.id, NAME,COUNT(winner) as n_matches
        FROM Players left join Matches on Players.id = Matches.winner
        GROUP BY Players.id) AS p1_count
    left join
    (SELECT Players.id,COUNT(looser) as n_matches
        FROM Players left join Matches on Players.id = Matches.looser
        GROUP BY Players.id) AS p2_count
    on p1_count.id = p2_count.id left join
    (SELECT Players.id as id,COUNT(winner) as count_wins
        FROM Players left join Matches on Players.id = Matches.winner
        GROUP BY players.id) AS wins
    on p2_count.id = wins.id
    ORDER BY wins DESC,p1_count.id;                
      
