/*
 *JavaScript that dynamically updates web page based on user input and button 
 * events. Uses Asynchronous JavaScript, part of the JQuery JavaScript library
 * to appropriately handle user events. 
 *
 *APIs Implemented: 
 *	1. Custom AWS RESTful API developed by @DhairyaDesai (setURL and getDataURL)
 *	2. Third-party RESTful API used as layer of security (redirectURL)
 *
 *Copyright (c) 2020 Dhairya Desai (desaidn@miamioh.edu) 
 */

// URLs to asynchronously call third party and AWS RESTful API 
var setURL = "https://desaidn.aws.csi.miamioh.edu/hw10.php?method=setTemp&location=";
var redirectURL = "https://api.clearllc.com/api/v2/setTemp?api_key=bed859b37ac6f1dd59387829a18db84c22ac99c09ee0f5fb99cb708364858818&userid=";
var getDataURL = "https://desaidn.aws.csi.miamioh.edu/hw10.php?method=getTemp&qty=";

/*
 * sensorData() is used to distinguish between three different event calls 
 *@param i is the value associated with the calling event (button)
 */
function sensorData(i) {
	var sensor = $("#sensor").val();
	var loc = $("#location").val(); 
	var value = $("#value").val(); 
	var qty = $("#qty").val();
	
	// if i = 1 call the the AWS RESTful API to store input in database
	// if i = 2 call the third part RESTful API developed by Prof. 
	// if i = 3 call the AWS RESTful API to retrieve data from backend
	if (i == 1) {
		directSend(loc, sensor, value); 
	}
	if (i == 2) {
		reDirectSend(loc, sensor, value); 
	}
	if (i == 3) {
		getData(qty); 
	}

}

/*
 * directSend takes the user input and sends it to the php backend, which 
 * 		stores the data in the the SQL database
 * @param loc takes in the user input location, which is the location of the sensor 
 * @param sensor takes in the sensor name 
 * @param value takes in sensor value 
 */ 
function directSend(loc, sensor, value) {
	var source = "manual"; 
	var directSendURL = setURL + loc + "&sensor=" + sensor + "&value=" + value + "&source=manual";
	
	// if-statement calls the valSensorInput method which validates user input 
	// else, dynamically updates alert div with error message and prevents
	// AJAX call
	if (valSensorInput(loc, sensor, value) == true) {
	$.ajax({
		url: directSendURL,
		method: "GET"
	}).done(function(data) {
		$("#alert2").css("display", "none");
		$("#alert2").html("");
		$("#respStr").html(""); 
		var str = data.message; 
		$("#respStr").css("display", "block");
		$("#respStr").append('<h3 style="text-align:center">Congratulations! Your ' + str + '</h3>');
	}).fail(function(error) {
		alert("There was some error with the api call, please try again!");
	})}
};


/*
 * reDirectSend takes the user input and sends it to a third party RESTful API
 * 		which redirects input to the SQL database. A safety feature
 * 		that reduces exposure to the backend.
 * @param loc takes in the user input location, which is the location of the sensor 
 * @param sensor takes in the sensor name 
 * @param value takes in sensor value 
 */ 
function reDirectSend(loc, sensor, value) {
	console.log("2");
	var redirectSendURL = redirectURL + "desaidn" + "&location=" + loc + "&sensor=" + sensor + "&value=" + value;
	
	// if-statement calls the valSensorInput method which validates user input 
	// else, dynamically updates alert div with error message and prevents
	// AJAX call
	if (valSensorInput(loc, sensor, value) == true) {
	$.ajax({
		url: redirectSendURL, 
		method: "GET"
	}).done(function(data) {	
		$("#alert2").css("display", "none");
		$("#alert2").html("");
		$("#respStr").html(""); 
		var str = data.message; 
		$("#respStr").css("display", "block");
		$("#respStr").append('<h3 style="text-align:center">Congratulations! We received the following message from the ' + str + '</h3>');
	}).fail(function(error) {
		alert("There was some error with the api call, please try again!");
	})}
};

/*
 *getData dynamically loads the table based on the quantity selected by the user
 *
 * @qty number of rows to retreive from the SQL database 
 */
function getData(qty) {
	console.log(qty);
		var getReq = getDataURL + qty; 
	$.ajax({
		url: getReq, 
		method: "GET"
	}).done(function(data) {
		$("#resultSensor").css("display", "block"); 
		$("#resultTbl").html('<thead class="thead-dark"> <tr><th>Location</th><th>Sensor</th><th>Value</th><th>Date</th><th>Source</th> </tr> </thead>'); 
		// for loop that updates div as and when data is available. 
		for (var i = 0; i < data.message.length; i++) {
			var loc = data.message[i].location; 
			var sensor = data.message[i].sensor; 
			var value = data.message[i].value; 
			var date = data.message[i].date; 
			var source = data.message[i].source;
			$("#resultTbl").append('<tr><td>' + loc + '</td>' + '<td>' + sensor + '</td>' + '<td>' + value + '</td>' + '<td>' + date + '</td>' + '<td>' + source + '</td> </tr>');

		}

	}).fail(function(error) {
		alert("There was some error with the api call, please try again!");
	})};

/*
 *valSensorInput validates user input to make sure it meets certain requirements 		additional safety feature. In addtion to RegEx validation. 
 *
 * @param loc takes in the user input location, which is the location of the sensor 
 * @param sensor takes in the sensor name 
 * @param value takes in sensor value 
 */ 
function valSensorInput(loc, sensor, value) {
	
	if (isNaN(value)) {
			$("#alert2").html("");
                	$("#alert2").css("display", "block");
               		$("#alert2").append("Make sure value is numeric!");
                	return false;
	}
	if (loc == "" || sensor == "" || value == "") {

		$("#alert2").html("");
		$("#alert2").css("display", "block"); 
		$("#alert2").append("Please enter all values!"); 
		return false;
	}
	return true;
}
