import java.util.*;

public class Population {
	
	Individual individuals[];
	int populationSize; 
	Map<String, String> popMap;
	
	public Population(Individual individuals[], int populationSize) {
		this.populationSize = populationSize; 
		this.individuals = individuals;
		popMap = new HashMap<String, String>();;
		
		for (int i = 0; i < populationSize; i++) {
			popMap.put(individuals[i].getIndividualAngle(), individuals[i].getInputData());
		}
	}
	
	public void removeUnfit() {
		int minFitness = Integer.MAX_VALUE; 
		String minKey = "";
		
		for (Map.Entry<String, String> entry : popMap.entrySet()) {
			String[] attributes = entry.getValue().split("\\s+");
			String fitness = attributes[7];
			
			if (Integer.parseInt(fitness, 2) < minFitness) {
				minFitness = Integer.parseInt(fitness, 2);
				minKey = entry.getKey();
			}
		}
		
		popMap.remove(minKey);
		String[] removed = minKey.split("\\s+");
		System.out.println("The axis angle: " + Integer.parseInt(removed[0], 2) + ", and azimuth angle: " + Integer.parseInt(removed[1], 2) 
												+ " from generation: " + Integer.parseInt(removed[2], 2) + " were removed\n");
	}
	
}
