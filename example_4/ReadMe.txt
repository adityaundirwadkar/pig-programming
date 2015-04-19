Problem Statement: Using Pig Latin script, write a UDF(User Define Function) FORMAT_GENRE in Pig which basically formats the genre in movies_new in the following:

Before formatting:		Children's
After formatting:			Children's

Before formatting:		Animation|Children's
After formatting:			Animation, and Children's


Before formatting:		Adventure|Animation|Children's
After formatting:			Adventure, Animation, and Children's

Using Pig Latin script, use the FORMAT_GENRE function on movies_new dataset and  print the movie name with its genre(s).


How to execute?
Place the jar file generated from "format_genre_pig.java" in the current working directory and then execute pig script file as,
pig -x mapreduce example_3.pig