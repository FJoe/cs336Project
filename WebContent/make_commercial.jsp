<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make Commercial</title>

<style>
table {    
	font-family: arial, sans-serif;    
	border-collapse: collapse;    
	width: 100%;
}
td, th {    
	border: 1px solid #dddddd;    
	text-align: left;    
	padding: 8px;
}
tr:nth-child(even) {    
	background-color: #dddddd;
}
tr:nth-child(odd) {    
	background-color: white;
}



</style>
</head>
<body><center>
	<div id="links" style="width:100%">
		<a class="link" href="home.jsp">Home</a>
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="delete.jsp">Delete Tuple</a>
		<a class="link" href="facts.jsp">Commercial Generator</a>
		<a class="link" href="facts_channel.jsp">Viewer Favorites</a>
		<a class="link" href="facts_consumer.jsp">I want to shop</a>
		<a class="link" href="most_popular.jsp">Entity Stats</a>
		<a class="link" href="patterns.jsp">Patterns</a>
	</div></center>
	<br>
	
	<%
    
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String market = request.getParameter("market");
			String gender = request.getParameter("Gender");
			
			//Gets tactics and count
			String[] tactics = new String[5];
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = 
				"SELECT DISTINCT c.Tactic AS 'Best Tactic', COUNT(i.Name) " +
				"FROM ((((cs336db.interested i " + 
				"INNER JOIN cs336db.product p ON i.ProductName = p.Name) "+
				"INNER JOIN cs336db.sees s ON s.Consumer = i.Name) " +
				"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
				"INNER JOIN cs336db.consumer co ON co.Name = i.Name) "+
				"WHERE p.Market = '" + market + "' " +
				"AND co.Gender = '" + gender + "' "+
				"GROUP BY c.Tactic " + 
				"ORDER BY COUNT(i.Name) desc " +
				"LIMIT 5";
							
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			//out.print("<p>Ideal <b>tactics</b> to use for your commercial:</p>");

			if(!result.next()){
				out.print("<p>Sorry, an ideal tactic was not found.</p>");
			}else{
				out.print("<table style = \"border:solid;border-width:2px;\"><tr><th>Ideal tactics for this commercial</th><th>Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> and persuaded by tactic</th></tr> ");
				for(int i = 0; i < 5; i++){
					String tactic = result.getString(1);
					tactics[i] = tactic;
					//out.print("<p>The ideal tactic for this commercial is: " + "<b><u>" + tactic + "</u></b>" + "</p>");
					String answer = result.getString(2);
					//out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and persuaded by <b>" + tactic + 
					//		"</b> commercials: <b><u>"+ answer + "</u></b></p>");
					out.print("<tr><td>" + tactic + "</td><td>" + answer + "</td></tr>");
					result.next();
				}	
			}
			out.print("</table><br>");
			
			
			//Gets city and count
			String[] cities = new String[5];
			
			//out.print("<p>Ideal <b>cities</b> to produce the commercial:</p>");

			str = "SELECT DISTINCT c.City AS 'Best City', COUNT(i.Name) " +
					"FROM ((((cs336db.interested i " + 
					"INNER JOIN cs336db.product p ON i.ProductName = p.Name) "+
					"INNER JOIN cs336db.sees s ON s.Consumer = i.Name) " +
					"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
					"INNER JOIN cs336db.consumer co ON co.Name = i.Name) "+
					"WHERE p.Market = '" + market + "' " +
					"AND co.Gender = '" + gender + "' "+
					"GROUP BY c.City " +
					"ORDER BY COUNT(i.Name) desc " +
					"LIMIT 5";
			
			//Find ideal channels
			stmt = con.createStatement();
			
			//Run the query against the database.
			result = stmt.executeQuery(str);
			String[] channels = new String[5];

			if(!result.next()){
				out.print("<p>Sorry, an ideal city was not found.</p>");
			}else{
				out.print("<table style = \"border:solid;border-width:2px;\" ><tr><th>Ideal locations for this commercial</th><th>Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> and live near city</th></tr>");
				for(int i = 0; i < 5; i++){
					String city = result.getString(1);
					cities[i] = city;
					//out.print("<p>The ideal location for this commercial is: <b><u>" +city + "</u></b></p>");
					String answer = result.getString(2);
					//out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and living by <b>" + city + 
					//		"</b>: <b><u>"+ answer + "</u></b></p>");
					out.print(" <tr><td>" + city + "</td><td>" + answer + "</td></tr> ");
					result.next();
				}	
			}
			out.print("</table><br>");
			
			
			//Getting ideal Channel
			str = "SELECT DISTINCT ch.Name AS 'Best Channel', COUNT(w.Consumer) " +
					"FROM ((((((cs336db.watches w " +
					"INNER JOIN cs336db.channel ch ON w.Channel = ch.Name) " +
					"INNER JOIN cs336db.sees s ON s.Consumer = w.Consumer) " +
					"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
					"INNER JOIN cs336db.interested i ON i.Name = w.Consumer) "+
					"INNER JOIN cs336db.product p ON p.Name = i.ProductName) "+
					"INNER JOIN cs336db.consumer co ON co.Name = w.Consumer) "+
					"WHERE p.Market = '" + market + "' "+
					"AND co.Gender = '" + gender + "' "+
					"GROUP BY ch.Name " +
					"ORDER BY COUNT(w.Consumer) desc " +
					"LIMIT 5";
			
			stmt = con.createStatement();
			
			//Run the query against the database.
			result = stmt.executeQuery(str);
			
			//out.print("<center><div style = \"background-color:#c5f442;\">");
			//out.print("<p>Ideal <b>channels</b> to host your commercial:");

			if(!result.next()){
				out.print("<p>Sorry, an ideal channel was not found.</p>");
			}else{
				out.print("<table style = \"border:solid;border-width:2px;\"><tr><th>Ideal channels to air your commercial</th><th>Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and watching channel<b></th></tr>");
				for(int i = 0; i < 5; i++){
					String channel = result.getString(1);
					//out.print("<p>The ideal channel for this commercial to air is: <b><u>"+ channel + "</u></b>" + "</p>");
					String answer = result.getString(2);
					//out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and watching: <b>" + channel + 
					//		"</b>: <b><u>"+ answer + "</u></b>");
					out.print("<tr><td>" + channel + "</td><td>" + answer + "</td></tr>");
					result.next();
				}	
			}
			out.print("</table>");
			
		//close the connection.
		db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		
	%>
</body>
</html>