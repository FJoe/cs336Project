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
	
	<%
    
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String market = request.getParameter("market");
			String gender = request.getParameter("Gender");
			int counter = 1;
			
			//Prints 3 sets
			while(counter < 4){
				String tactic = null;
				String city = null;
				String channel = null;
				out.print("<center>");
				if(counter == 1){
					out.print("<div style = \"background-color:#f48342;\"><p>Option 1(<b>Best</b>):</p>");
				}
				else if(counter == 2){
					out.print("<div style = \"background-color:#f44271;\"><p>Option 2:</p>");
				}
				else{
					out.print("<div style = \"background-color:#c5f442;\"><p>Option 3:</p>");
				}
				
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = 
				"SELECT DISTINCT c.Tactic AS 'Best Tactic' " +
				"FROM ((((cs336db.interested i " + 
				"INNER JOIN cs336db.product p ON i.ProductName = p.Name) "+
				"INNER JOIN cs336db.sees s ON s.Consumer = i.Name) " +
				"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
				"INNER JOIN cs336db.consumer co ON co.Name = i.Name) "+
				"WHERE p.Market = '" + market + "' " +
				"AND co.Gender = '" + gender + "' "+
				"GROUP BY c.Tactic " + 
				"ORDER BY COUNT(i.Name) desc " +
				"LIMIT 3";
						
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			if(!result.next()){
				out.print("<p>Sorry, an ideal tactic was not found.</p>");
			}else{
				if(counter == 2){
					result.next();
				}
				else if(counter == 3){
					result.next();
					result.next();
				}
				tactic = result.getString(1);
				//Make an HTML table to show the results in:
				out.print("<p>The ideal tactic for this commercial is: " + "<b><u>" + tactic + "</u></b>" + "</p>");
					
			}
			//QUERY FOR PROVING TACTIC
			stmt = con.createStatement();
			str = 
				"SELECT DISTINCT COUNT(c.Tactic) AS '# of Tactic Fans' "+
				"FROM ((((interested i "+
				"INNER JOIN product p ON i.ProductName = p.Name) "+
				"INNER JOIN sees s ON s.Consumer = i.Name) "+
				"INNER JOIN commercial c ON c.Name = s.Commercial) "+
				"INNER JOIN cs336db.consumer co ON co.Name = i.Name) "+
				"WHERE p.Market = '"+ market +"' "+
				"AND co.Gender = '" + gender + "' "+
				"AND c.Tactic = '"+ tactic +"' "+
				"GROUP BY c.Tactic "+
				"ORDER BY COUNT(i.Name) desc";
			
			result = stmt.executeQuery(str);
			if(!result.next()){
				out.print("<p>Sorry, an ideal tactic# was not found.</p>");
			}else{
			String answer = result.getString(1);
			out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and persuaded by <b>" + tactic + 
									"</b> commercials: <b><u>"+ answer + "</u></b></p>");
			}
			
			//~~~~~~~city
			stmt = con.createStatement();
			
			str = "SELECT DISTINCT c.City AS 'Best City'" +
					"FROM ((((cs336db.interested i " + 
					"INNER JOIN cs336db.product p ON i.ProductName = p.Name) "+
					"INNER JOIN cs336db.sees s ON s.Consumer = i.Name) " +
					"INNER JOIN cs336db.commercial c ON c.Name = s.Commercial) " +
					"INNER JOIN cs336db.consumer co ON co.Name = i.Name) "+
					"WHERE p.Market = '" + market + "' " +
					"AND co.Gender = '" + gender + "' "+
					"GROUP BY c.City " +
					"ORDER BY COUNT(i.Name) desc " +
					"LIMIT 3";
			
			result = stmt.executeQuery(str);
			if(!result.next()){
				out.print("<p>Sorry, an ideal location was not found.</p>");
			}
			else{
				if(counter == 2){
					result.next();
				}
				else if(counter == 3){
					result.next();
					result.next();
				}
				city = result.getString(1);
				out.print("<p>The ideal location for this commercial is: <b><u>" +city + "</u></b></p>");
			}

			//QUERY FOR PROVING CITY
			stmt = con.createStatement();	
			str = 
				"SELECT DISTINCT COUNT(c.City) AS '# of City Fans' "+
				"FROM ((((interested i "+
				"INNER JOIN product p ON i.ProductName = p.Name) "+
				"INNER JOIN sees s ON s.Consumer = i.Name) "+
				"INNER JOIN commercial c ON c.Name = s.Commercial) "+
				"INNER JOIN cs336db.consumer co ON co.Name = i.Name) "+
				"WHERE p.Market = '" + market + "'" +
				"AND co.Gender = '" + gender + "' "+
				"AND c.City = '"+ city +"' "+
				"GROUP BY c.City "+
				"ORDER BY COUNT(i.Name) desc";
			
			result = stmt.executeQuery(str);
			if(!result.next()){
				out.print("<p>Sorry, an ideal location was not found.</p>");
			}
			else{
				String answer = result.getString(1);
				out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and living by <b>" + city + 
						"</b>: <b><u>"+ answer + "</u></b></p>");
			}
			
			
			
			//~~~
			stmt = con.createStatement();
			
			if(tactic == null || city == null){
				out.print("An ideal tactic and city is needed to find the ideal channel.");
			}
			else{
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
						"LIMIT 3";
				
				result = stmt.executeQuery(str);
				out.print("<p>The ideal channel for this commercial to air is: ");
				if(!result.next()){
					out.print("<p>Sorry, an ideal channel was not found.</p>");
				}
				else{
					if(counter == 2){
						result.next();
					}
					else if(counter == 3){
						result.next();
						result.next();
					}
					channel = result.getString(1);
					out.print("<b><u>"+ channel + "</u></b>" + "</p>");
				}
			}
			
			//QUERY FOR PROVING CHANNEL
			stmt = con.createStatement();	
			str = 
				"SELECT DISTINCT COUNT(ch.Name) AS '# of consumers watching channel' "+
				"FROM ((((((watches w "+
				"INNER JOIN channel ch ON w.Channel = ch.Name) "+
				"INNER JOIN sees s ON s.Consumer = w.Consumer) "+
				"INNER JOIN commercial c ON c.Name = s.Commercial) "+
				"INNER JOIN cs336db.interested i ON i.Name = w.Consumer) "+
				"INNER JOIN cs336db.product p ON p.Name = i.ProductName) "+
				"INNER JOIN cs336db.consumer co ON co.Name = w.Consumer) "+
				"WHERE p.Market = '" + market + "' "+
				"AND co.Gender = '" + gender + "' "+
				"AND ch.Name = '" + channel + "' "+
				"GROUP BY ch.Name "+
				"ORDER BY COUNT(w.Consumer) desc";
			
			result = stmt.executeQuery(str);
			if(!result.next()){
				out.print("<p>Sorry, an ideal location was not found.</p>");
			}
			else{
				String answer = result.getString(1);
				out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and watching: <b>" + channel + 
						"</b>: <b><u>"+ answer + "</u></b><div></center></p>");
			}
			
			
			counter++;}
		//close the connection.
		db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		
	%>
</body>
</html>