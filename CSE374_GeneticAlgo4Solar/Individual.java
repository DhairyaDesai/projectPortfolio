// import java.util.*;

public class Individual {
	
	String time; 
	String day; 
	String latitude; 
	String longitude; 
	String temp; 
	String maxEff;
	String netEnergy;
	String fitnessInd; 
	String t_axis; 
	String t_azimuth; 
	String genenrationNum; 
	String childAxis; 
	String childAzimuth; 
	
	public Individual(int time, int day, int latitude, int longitude, int temp, int maxEff, int netEnergy, int t_axis, int t_azimuth, int generationNum) {
		// Corresponding data
		this.time = Integer.toBinaryString(time);;
		this.day = Integer.toBinaryString(day);
		this.latitude = Integer.toBinaryString(latitude);
		this.longitude = Integer.toBinaryString(longitude);
		this.temp = Integer.toBinaryString(temp);
		this.maxEff = Integer.toBinaryString(maxEff);
		this.netEnergy = Integer.toBinaryString(netEnergy);
		this.fitnessInd = getFitness(maxEff, netEnergy);
		
		// Angles and generation of the angles
		this.t_axis = String.format("%08d", Integer.parseInt(Integer.toBinaryString(t_axis)));
		this.t_azimuth = String.format("%08d", Integer.parseInt(Integer.toBinaryString(t_azimuth)));
		this.genenrationNum = Integer.toBinaryString(generationNum); 	
	}
	

	public String getIndividualAngle() { 
		return t_axis + " " + t_azimuth + " " + genenrationNum;
	}
	
	
	public String getInputData() {
		return time + " " + day + " " + latitude + " " + longitude + " " + temp + " " + maxEff + " " + netEnergy + " " + fitnessInd + " " + genenrationNum;
	}
	
	public String getFitness(int maxEff, int netEnergy) {
		int fitnessVal =  (int) Math.rint((((double)netEnergy/(double)maxEff) * 10));
		return Integer.toBinaryString(fitnessVal);
	}

}
