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
			
			//Gets tactics and count
			String[] tactics = new String[3];
			
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
				"LIMIT 3";
							
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			out.print("<center>");
			out.print("<div style = \"background-color:#f48342;\"><p>Ideal tactics to use for your commercial:</p>");

			if(!result.next()){
				out.print("<p>Sorry, an ideal tactic was not found.</p>");
			}else{
				for(int i = 0; i < 3; i++){
					String tactic = result.getString(1);
					tactics[i] = tactic;
					out.print("<p>The ideal tactic for this commercial is: " + "<b><u>" + tactic + "</u></b>" + "</p>");
					String answer = result.getString(2);
					out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and persuaded by <b>" + tactic + 
							"</b> commercials: <b><u>"+ answer + "</u></b></p>");
					result.next();
				}	
			}
			
			
			//Gets city and count
			String[] cities = new String[3];
			out.print("<center>");
			out.print("<div style = \"background-color:#f44271;\"><p>Ideal cities to produce the commercial:</p>");

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
					"LIMIT 3";
			
			//Find ideal channels
			stmt = con.createStatement();
			
			//Run the query against the database.
			result = stmt.executeQuery(str);
			String[] channels = new String[3];

			if(!result.next()){
				out.print("<p>Sorry, an ideal city was not found.</p>");
			}else{
				for(int i = 0; i < 3; i++){
					String city = result.getString(1);
					cities[i] = city;
					out.print("<p>The ideal location for this commercial is: <b><u>" +city + "</u></b></p>");
					String answer = result.getString(2);
					out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and living by <b>" + city + 
							"</b>: <b><u>"+ answer + "</u></b></p>");
					result.next();
				}	
			}

			if(tactics[0] != null && cities[0] != null){
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
				
				stmt = con.createStatement();
				
				//Run the query against the database.
				result = stmt.executeQuery(str);
				
				out.print("<center>");
				out.print("<div style = \"background-color:#c5f442;\"><p>Ideal channels to host your commercial::</p>");

				if(!result.next()){
					out.print("<p>Sorry, an ideal channel was not found.</p>");
				}else{
					for(int i = 0; i < 3; i++){
						String channel = result.getString(1);
						out.print("<p>The ideal channel for this commercial to air is: ");
						String answer = result.getString(2);
						out.print("<p style = \"color:#0c192d;\">Number of <b>" + gender + "</b> consumers interested in <b>" + market + "</b> products and watching: <b>" + channel + 
								"</b>: <b><u>"+ answer + "</u></b><div></center></p>");
						result.next();
					}	
				}
			}
			else{
				out.print("An ideal tactic and city is needed to find the ideal channel.");
			}

			
			
	
			

			
			
		//close the connection.
		db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		
	%>
</body>
</html>