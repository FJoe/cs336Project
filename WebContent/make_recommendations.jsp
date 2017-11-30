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
			String age = request.getParameter("age");
			String origAge = age;
			if(Integer.parseInt(age) >= 70)
				age = "70";
			if(Integer.parseInt(age) < 20)
				age = "20";
			int temp = ((Integer.parseInt(age))/10)*10;
			age = Integer.toString(temp);
			
			String gender = request.getParameter("gender");
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = 
					"SELECT DISTINCT co.Name AS 'Best Commercials', COUNT(w.Consumer) "+
					"FROM ((((cs336db.watches w "+
					"INNER JOIN cs336db.channel ch ON w.Channel = ch.Name)"+ 
					"INNER JOIN cs336db.consumer c ON c.Name = w.Consumer) "+
					"INNER JOIN cs336db.sees s ON s.Consumer = c.Name) "+
					"INNER JOIN cs336db.commercial co ON co.Name = s.Commercial) "+
					"WHERE " + age + " = ch.TargetAge " +
					"GROUP BY co.Name "+
					"ORDER BY COUNT(w.Consumer) desc "+ 
					"LIMIT 5";
						
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			if(!result.next()){
				out.print("<p>Sorry, no ideal commercials were found</p>");
			}
			else{
				//Make an HTML table to show the results in:
				//out.print("<center> <div style = \" background-color:#f44271; \" ><p>Here are some commercials the consumer may be interested to watch: </p>");
				out.print("<table style = \"border:solid;border-width:2px;\"><tr><th>Commercials the consumer may be interested to watch</th><th>Number of consumers around the age of <b>" + origAge + "</b> who see commercial</th></tr>");
				//parse out the results
				while(result.next()) {
					String commercial = result.getString(1);
					//out.print("<p>A commercial this consumer may be interested in is: <b><u>"+ commercial + "</u></b>" + "</p>");
					String answer = result.getString(2);
					//out.print("<p style = \"color:#0c192d;\">Number of consumers around the age of " + origAge + " interested in commercial<b>" + commercial + 
					//		"</b> is: <b><u>"+ answer + "</u></b></p>");
					out.print("<tr><td><u>" + commercial + "</u></td><td>" + answer + "</td></tr>");
				}
			}
			
			out.print("</table><br>");
			
			//Create a SQL statement
			stmt = con.createStatement();
			if(gender != "Male" || gender != "Female"){
				gender = "Male";
			}

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			str = 
				"SELECT DISTINCT p.Name AS 'Favorite Products', COUNT(w.Consumer) " +
				"FROM ((((((cs336db.consumer c " + 
				"INNER JOIN cs336db.watches w ON w.Consumer = c.Name) "+
				"INNER JOIN cs336db.channel ch ON  ch.Name = w.Channel) " +
				"INNER JOIN cs336db.airs a ON a.Channel = ch.Name)" +
				"INNER JOIN cs336db.commercial co ON co.Name = a.Commercial) " +
				"INNER JOIN cs336db.sells se ON se.Commercial_Name = co.Name) " +
				"INNER JOIN cs336db.product p ON p.Name = se.Product_Name) " +
				"WHERE c.Gender = p.Gender " +
				"AND (c.Age = ch.TargetAge) " +
				"AND c.Gender = '" + gender + "' " +
				"GROUP BY co.Name " + 
				"ORDER BY COUNT(w.Consumer) desc " +
				"LIMIT 5";
						
			//Run the query against the database.
			result = stmt.executeQuery(str);
			
			if(!result.next()){
				out.print("<p>Sorry, no ideal product were found</p>");
			}
			else{
				//Make an HTML table to show the results in:
				//out.print( " <center><div style = \"background-color:#f48342;\" ><p>Here are some Products the consumer may be interested in: </p>");
				out.print("<table style = \"border:solid;border-width:2px;\"><tr><th>Products the consumer may be interested in</th><th>Number of consumers around the age of " + origAge + " interested in product</th></tr>");
				//parse out the results
				while(result.next()){
					String product = result.getString(1);
					//out.print("<p>A product this consumer may be interested in is: <b><u>"+ product + "</u></b>" + "</p>");
					String answer = result.getString(2);
					//out.print("<p style = \"color:#0c192d;\">Number of consumers around the age of " + origAge + " interested in product <b>" + product + 
					//		"</b> is: <b><u>"+ answer + "</u></b></p>");
					out.print("<tr><td>" + product + "</td><td>" + answer + "</td></tr>");
				}
			}
	
			out.print("</table>");
			//close the connection.
			db.closeConnection(con);
		} catch(NumberFormatException e){
			out.print("Error: Invalid age inputted (either not int or is negative)");
		}
			catch (Exception e) {
			out.print(e);
		}
		
	%>
</body>
</html>