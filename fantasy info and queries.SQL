/* fantasy_library.db */

/* views on the command prompt .mode column, .header on */



/* create the tables */

CREATE TABLE series (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, subgenre_id INTEGER);

CREATE TABLE subgenres (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, year INTEGER, series_id INTEGER);

CREATE TABLE characters (id INTEGER PRIMARY KEY, name TEXT, motto TEXT, species TEXT, author_id INTEGER);

CREATE TABLE character_books (id INTEGER PRIMARY KEY, book_id INTEGER, character_id INTEGER);



/* INSERT the data into the tables */

INSERT INTO series (id, title, author_id, subgenre_id) VALUES (1, "A Song of Ice and Fire", 1, 1), (2, "Second Series", 2, 2);

INSERT INTO subgenres (id, name) VALUES (1, "medieval"), (2, "space opera");

INSERT INTO authors (id, name) VALUES (1, "George R. R. Martin"), (2, "Second Author");

INSERT INTO books (id, title, year, series_id) VALUES (1, "Game of Thrones", 1996, 1), (2, "A Clash of Kings", 1998, 1), (3, "A Storm of Swords", 2000, 1), (4, "First Book", 2002, 2), (5, "Second Book", 2003, 2), (6, "Third Book", 2005, 2);

INSERT INTO characters (id, name, motto, species, author_id) VALUES (1, "Lady", "Woof Woof", "direwolf", 1), (2, "Tyrion Lannister", "A Lannister always pays his debts", "human", 1), (3, "Daenerys Targaryen", "If I look back I am lost", "human", 1), (4, "Eddard Stark", "Winter is coming", "human", 1);

INSERT INTO characters (id, name, motto, species, author_id) VALUES (5, "Character One", "motto one", "cylon", 2), (6, "Character Two", "motto two", "human", 2), (7, "Character Three", "motto three", "cylon", 2), (8, "Character Four", "motto four", "cylon", 2);

INSERT INTO character_books (id, book_id, character_id) VALUES (1, 1, 1), (2, 1, 2), (3, 2, 2), (4, 3, 2), (5, 1, 3), (6, 2, 3), (7, 3, 3), (8, 1, 4);

INSERT INTO character_books (id, book_id, character_id) VALUES (9, 4, 5), (10, 4, 6), (11, 5, 6), (12, 6, 6), (13, 4, 7), (14, 5, 7), (15, 6, 7), (16, 4, 8);



/* update a record on the character table to be martian species */
UPDATE characters
SET species='Martian'
WHERE id=8;



/* select_books_titles_and_years_in_first_series_order_by_year */

SELECT books.title, books.year FROM books
WHERE series_id=1
ORDER BY books.year;



/* select_name_and_motto_of_char_with_longest_motto */

SELECT characters.name, characters.motto FROM characters
ORDER BY LENGTH(characters.motto) DESC LIMIT 1;




/* select_value_and_count_of_most_prolific_species */

SELECT characters.species, COUNT(characters.species) FROM characters
GROUP BY characters.species
ORDER BY characters.species DESC LIMIT 1;



/* select_name_and_series_subgenres_of_authors */

SELECT authors.name, subgenres.name FROM authors
JOIN series ON series.author_id = authors.id
JOIN subgenres ON series.subgenre_id = subgenres.id; 



/* select_series_title_with_most_human_characters */

SELECT series.title FROM series
JOIN books ON books.series_id = series.id
JOIN character_books on character_books.book_id = books.id
JOIN characters on character_books.character_id = characters.id
WHERE characters.species = 'human'
GROUP BY series.title
ORDER BY count(*) DESC
LIMIT 1;





/* select_character_names_and_number_of_books_they_are_in


/* my solution */
SELECT characters.name, count(books.id) FROM characters
JOIN character_books ON character_books.character_id = characters.id
JOIN books ON books.id = character_books.book_id
GROUP BY characters.name
ORDER BY count(books.id) DESC;



/* the correct solution */
SELECT characters.name, COUNT(*) as book_count FROM character_books
JOIN characters ON character_books.character_id = characters.id
GROUP BY characters.name
ORDER BY book_count DESC, characters.name; 














