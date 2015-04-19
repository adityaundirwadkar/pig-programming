register ./homework_3_part_1.jar
define FORMAT_GENRE assignment_3.format_genre_pig();
/*Load all input files */
movies = LOAD '/HW_3_Data/movies_new' AS (row:chararray);
/* Apply COGROUP on movies and ratings with the column movieID */
newGenreList = FOREACH movies GENERATE flatten(FORMAT_GENRE(row)) as (movieName:chararray, movieGenre:chararray);
DESCRIBE newGenreList;
/* Display the output*/
DUMP newGenreList;