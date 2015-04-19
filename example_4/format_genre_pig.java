package assignment_3;

import java.io.IOException; 
import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;

public class format_genre_pig extends EvalFunc<Tuple> {
	
	public Tuple exec(Tuple tuple) throws IOException {
		TupleFactory tupleFactory = TupleFactory.getInstance();
		//Use the tuple factory to create a new tuple                                
        Tuple returnThisTuple = tupleFactory.newTuple();
		if (tuple == null || tuple.size() == 0){
			return null;
		}
		try{
			//Get the data row
            String inputLine = (String)tuple.get(0);
            String[] splittedInput = inputLine.split(";");
            returnThisTuple.append(splittedInput[1]);
            //returnThisTuple.append(splittedInput[2]);
            returnThisTuple.append(formatGenre(splittedInput[2]));
            return returnThisTuple;
			}
		catch(Exception e){
			//throw new IOException("Caught exception processing input row ", e);
			returnThisTuple.append(new String("Something went"));
			returnThisTuple.append(new String("wrong!!!"));
			return returnThisTuple;
		}
	}
	
	public String formatGenre(String splittedInput){
		int inputLength = splittedInput.split("\\|").length;
		String[] splitGenre = splittedInput.split("\\|");
		int loopVariable =0;
		String newGenre = null;
		try{
			if(inputLength>2){
				while(loopVariable < inputLength-1){
					if(loopVariable > 0){
						newGenre = newGenre + ", " + splitGenre[loopVariable];
					}
					else{
						newGenre = splitGenre[loopVariable];
					}
					loopVariable++;			
				}
				newGenre = newGenre + ", and " + splitGenre[loopVariable];
			}
			else if(inputLength > 1){
				newGenre = splitGenre[loopVariable++] +", and "+ splitGenre[loopVariable++];
			}
			else{
				newGenre = splitGenre[loopVariable];
			}		
			return newGenre;
		}
		catch(Exception e){
			System.out.println("Found an exception ");
			return null;
		}
	}
}