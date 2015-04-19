/*Load all input files */
movies = LOAD '/HW_3_Data/movies_new' USING PigStorage(';') AS (movieID:chararray,movieName:chararray,movieGenre:chararray);
users = LOAD '/HW_3_Data/users_new' USING PigStorage(';') AS (userID:chararray,userGender:chararray,userAge:int, userOccupation:chararray,timeStamp:chararray);
ratings = LOAD '/HW_3_Data/ratings_new' USING PigStorage(';') AS (userID:chararray,movieID:chararray,movieRating:int,timeStamp:chararray);
/* Filter movies by given genre */
actionWarMovies = FILTER movies BY (movieGenre matches '.*Action.*') AND (movieGenre matches '.*War.*');
/* Get movieID for each qualifying movie */
actionWarMoviesID = FOREACH actionWarMovies GENERATE movieID;
groupedRatings = GROUP ratings BY movieID;
/* Get Average rating for each movie */
averageRating = FOREACH groupedRatings GENERATE group,AVG(ratings.movieRating) AS avgRating;
/* Now join movies with genre Action and War with their average ratings */
joinMoviesRating = JOIN actionWarMoviesID BY $0 , averageRating BY $0;
/* Arrange movies with descending order of their Average Rating*/
orderedMoviesRating_1 = ORDER joinMoviesRating BY $2 DESC; 
orderedMoviesRating_2 = FOREACH orderedMoviesRating_1 GENERATE $0 AS movieID, $2 AS avgRating;
/* Get the movie with highest rating */ 
highestMovieRating = LIMIT orderedMoviesRating_2  1;
/* Look if there are any other movies with same highest rating */
orderedMoviesRating_3 = JOIN highestMovieRating BY avgRating, orderedMoviesRating_2 BY avgRating;
/* Get the movieIDs of such movies */
highestRatedMovies = FOREACH orderedMoviesRating_3 GENERATE $0 AS movieID;
/* Join those movieIDs with ratings file */
userhighestRatedMovies = JOIN ratings BY movieID, highestRatedMovies BY movieID;
/* Get female users who have their ages between 20 and 30 */
femaleUsers = FILTER users BY (userGender == 'F') AND (userAge < 30) AND (userAge >= 20);
/* Join those users with highest rated movies if they have rated for those movies */
femaleUsersRating = JOIN femaleUsers BY userID, userhighestRatedMovies BY ratings::userID;
/* Get the userIDs of such female users */
partialAnswer = FOREACH femaleUsersRating generate $0 AS userID;
/* Get distinct female users */
answer = DISTINCT partialAnswer;
count_answer = GROUP answer ALL;
total_count = FOREACH count_answer GENERATE COUNT(answer);
/*DUMP answer;*/
DUMP total_count;