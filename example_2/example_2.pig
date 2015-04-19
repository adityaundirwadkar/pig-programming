/*Load all input files */
movies = LOAD '/HW_3_Data/movies_new' using PigStorage(';') AS (movieID:chararray,movieName:chararray,movieGenre:chararray);
ratings = LOAD '/HW_3_Data/ratings_new' using PigStorage(';') AS (userID:chararray,movieID:chararray,movieRating:int,timeStamp:chararray);
/* Apply COGROUP on movies and ratings with the column movieID */
coGroupMoviesRatings = COGROUP movies BY movieID,ratings by movieID;
DESCRIBE coGroupMoviesRatings;
/* Display the output*/
DUMP coGroupMoviesRatings;