import java.util.Map;
import java.util.Random;
import java.util.Scanner;

// import java.util.*;

public class OptimalAngle {
	String fittestKey;
	String secondFittestKey;
	Population p;
	String childAxis; 
	String childAzimuth;

	public OptimalAngle(Population p) {
		this.p = p;
		this.fittestKey = "";
		this.secondFittestKey = "";
	}

	public void getFittest() {
		int maxFitness = Integer.MIN_VALUE; 

		for (Map.Entry<String, String> entry : p.popMap.entrySet()) {
			String[] attributes = entry.getValue().split("\\s+");
			String fitness = attributes[7];

			if (Integer.parseInt(fitness) >= maxFitness) {
				maxFitness = Integer.parseInt(fitness);
				fittestKey = entry.getKey();
			}
		}
		maxFitness = Integer.MIN_VALUE; 

		for (Map.Entry<String, String> entry : p.popMap.entrySet()) {
			String[] attributes = entry.getValue().split("\\s+");
			String fitness = attributes[7];

			if (Integer.parseInt(fitness) >= maxFitness && entry.getKey() != fittestKey) {
				maxFitness = Integer.parseInt(fitness);
				secondFittestKey = entry.getKey();
			}
		}
		
		String[] fittestKeyArr = fittestKey.split("\\s+");
		System.out.println("THE FITTEST: ");
		System.out.println("The axis angle: " + Integer.parseInt(fittestKeyArr[0], 2) + ", and azimuth angle: " + Integer.parseInt(fittestKeyArr[1], 2) 
		+ " from generation: " + Integer.parseInt(fittestKeyArr[2], 2) + " are the first fittest\n");
		
		String[] secondFittestKeyArr = secondFittestKey.split("\\s+");
		System.out.println("THE SECOND FITTEST: ");
		System.out.println("The axis angle: " + Integer.parseInt(secondFittestKeyArr[0], 2) + ", and azimuth angle: " + Integer.parseInt(secondFittestKeyArr[1], 2) 
		+ " from generation: " + Integer.parseInt(secondFittestKeyArr[2], 2) + " are the second fittest\n");
		
	}

	public void generateNewChild() {
		String[] attributesFittest = fittestKey.split("\\s+");
		String[] attributes2Fittest = secondFittestKey.split("\\s+");
		
		String[] axisFittest = getStringArray(String.format("%08d", Integer.parseInt(attributesFittest[0])));
		String[] azimuthFittest = getStringArray(String.format("%08d", Integer.parseInt(attributesFittest[1])));
		String[] axis2Fittest = getStringArray(String.format("%08d", Integer.parseInt(attributes2Fittest[0])));
		String[] azimuth2Fittest = getStringArray(String.format("%08d", Integer.parseInt(attributes2Fittest[1])));
		
		System.out.println("Crossing over parent axis angles...\nParent 1 axis angle: " + Integer.parseInt(getStringFromArray(axisFittest), 2) 
						+ "\nand\nParent 2 axis angle: " + Integer.parseInt(getStringFromArray(axis2Fittest), 2) + "\n");
		childAxis = crossover(axisFittest, axis2Fittest);
		
		System.out.println("Crossing over parent azimuth angles...\nParent 1 azimuth angle: " 
		+ Integer.parseInt(getStringFromArray(azimuthFittest), 2) 
		+ "\nand\nParent 2 azimuth angle: " + Integer.parseInt(getStringFromArray(azimuth2Fittest), 2) + "\n");
		childAzimuth = crossover(azimuthFittest, azimuth2Fittest);
	
		Random rand = new Random(); 
		int mutateOrNot = rand.nextInt(6);

		if (mutateOrNot % (rand.nextInt(5) + 1) == 0) {
			System.out.println("Implementing a random mutation...\n");
			childAxis = mutate(childAxis, mutateOrNot + 2); 
			childAzimuth = mutate(childAzimuth, mutateOrNot + 2);
		}
	}

	public String[] getStringArray(String s) {
		String ans[] = new String[8];
		for (int i = 0; i < 8; i++) {
			ans[i] = s.substring(i, i + 1);
		}
		return ans;
	}

	public String getStringFromArray(String[] s) {
		String ans = "";
		for(int i = 0; i < s.length; i++) {
			ans += s[i];
		}

		return ans; 
	}

	public String crossover(String[] parent1, String[] parent2) {
		Random rand = new Random(); 
		int crossOverPoint = rand.nextInt(8);
		
		for (int i = 0; i < crossOverPoint; i ++) {
			String temp = parent1[i];
			parent1[i] = parent2[i];
			parent2[i] = temp; 
		}

		int choose = rand.nextInt(10); 
		String ans = "";
		if (choose%2 == 0) {
			for (int i = 0; i < 8; i++) {
				ans += parent1[i];
			}
		} else {
			for (int i = 0; i < 8; i++) {
				ans += parent2[i];
			}
		}

		return ans;
	}

	public String mutate(String s, int i) {
		String ans = "";
		String temp[] = getStringArray(s);

		if (temp[i].equals("0")) {
			temp[i] = "1";
		} else {
			temp[i] = "0";
		}

		for (int k = 0; k < 8; k++) {
			ans += temp[k];
		}

		return ans;
	}


	/*
	 * We have implemented our genetic algorithm to optimize solar panel use in 4 stages: 
	 * PHASE 1: Create generation m (for m = 0 provide individuals based on assumption and test data values) of k-individuals 
	 * 			on test angles (T_Axis° T_Azimuth°) and corresponding ( t d Φ λ TEMP NE).
	 * 
	 * PHASE 2: Find the fitness index (F) of individuals based on the fitness function and sort.
	 * 
	 * PHASE 3: Crossover and mutation of individuals to create generation m+1
	 * 
	 * PHASE 4: Repeat Phases 1 - 3 until fitness index crosses a base threshold of x, or a previous best threshold or reaches 
	 * 			when net efficiency is equal to ME of the system.
	 */
	// int time, int day, int latitude, int longitude, int temp, int maxEff, int netEnergy, int t_axis, int t_azimuth, int generationNum
	public static void main(String args[]) {
		Individual individuals[] = new Individual[3];
		individuals[0] = new Individual(1440, 35, 67, 160, 40, 15, 5, 30, 60, 0);
		individuals[1] = new Individual(1440, 36, 67, 260, 42, 15, 6, 34, 62, 0);
		individuals[2] = new Individual(1440, 37, 67, 260, 35, 15, 2, 90, 95, 0);
		Population p = new Population(individuals, individuals.length);
		int  generationCount = 0;
		boolean onCondition = true;
		
		System.out.println("WELCOME TO DHAIRYA DESAI'S AND JANELLE GHANEM'S GENETIC ALGO FOR SOLAR PANEL OPTIMAZATION");
		Scanner in = new Scanner(System.in);
		System.out.println("Enter your name to begin: ");
		String name = in.nextLine();
		
		System.out.println("Hello! " + name + " lets begin\n");
		System.out.println("After Initial Data Insert: ");
		for (Map.Entry<String, String> entry : p.popMap.entrySet()) {
			String[] updatedPop = entry.getKey().split("\\s+");
			System.out.println("\nKey: \n" + "Axis Angle => " + Integer.parseInt(updatedPop[0], 2) 
					+ "\nAzimuth Angle => " + Integer.parseInt(updatedPop[1], 2) 
							+ "\nGeneration Number => " + Integer.parseInt(updatedPop[2], 2) 
									+ "\nValue: " + entry.getValue());
		}

		do {
			System.out.println("==================================== ITERATION : " + generationCount + " ====================================");
			
			p.removeUnfit();
			
			OptimalAngle a = new OptimalAngle(p);
			a.getFittest();
			
			a.generateNewChild();
			
			System.out.println("The child has an axis angle of " + Integer.parseInt(a.childAxis, 2) + " and an azimuth angle of " + Integer.parseInt(a.childAzimuth, 2) 
								+ " and belong to generation number " + generationCount + "\n");
			
			System.out.println("Please enter the net efficiency of the newly generate angles: ");
	
			int newNetEff = in.nextInt();
			
			if (newNetEff <= 0) {
				onCondition = false;
			}
			
			Individual child = new Individual(2, 0, 0, 0, 0, 15, newNetEff, Integer.parseInt(a.childAxis, 2) ,
					Integer.parseInt(a.childAzimuth, 2), generationCount);

			p.popMap.put(child.getIndividualAngle(), child.getInputData());

			for (Map.Entry<String, String> entry : p.popMap.entrySet()) {
				String[] updatedPop = entry.getKey().split("\\s+");
				System.out.println("\nKey: \n" + "Axis Angle => " + Integer.parseInt(updatedPop[0], 2) 
						+ "\nAzimuth Angle => " + Integer.parseInt(updatedPop[1], 2) 
								+ "\nGeneration Number => " + Integer.parseInt(updatedPop[2], 2) 
										+ "\nValue: " + entry.getValue());
			}
		
			generationCount++;
		} while(onCondition);
	}
}
