/*Load all input files */
movies = LOAD '/HW_3_Data/movies_new' using PigStorage(';') AS (movieID:chararray,movieName:chararray,movieGenre:chararray);
ratings = LOAD '/HW_3_Data/ratings_new' using PigStorage(';') AS (userID:chararray,movieID:chararray,movieRating:int,timeStamp:chararray);
/* Apply COGROUP on movies and ratings with the column movieID */
coGroupMoviesRatings_1 = COGROUP movies BY movieID inner,ratings by movieID inner;
coGroupMoviesRatings_2 =  FOREACH coGroupMoviesRatings_1 GENERATE FLATTEN(movies),FLATTEN(ratings);
DESCRIBE coGroupMoviesRatings_2;
/* Display the output*/
DUMP coGroupMoviesRatings_2;