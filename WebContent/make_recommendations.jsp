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
				out.print("<p>Here are some commercials the consumer may be interested to watch: </p>");
		
				//parse out the results
				do{
					String commercial = result.getString(1);
					out.print("<p>A commercial this consumer may be interested in is: <b><u>"+ commercial + "</u></b>" + "</p>");
					String answer = result.getString(2);
					out.print("<p style = \"color:#0c192d;\">Number of consumers around the age of " + origAge + " that have seen a commercial AND is interested in the product is <b>" + commercial + 
							"</b> is: <b><u>"+ answer + "</u></b></center></p>");
				}while(result.next());
			}
			
			out.print("<br>");
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			str = "SELECT Name FROM cs336db.commercial WHERE EXISTS(" + 
			"SELECT * FROM cs336db.sees, cs336db.consumer WHERE sees.consumer = consumer.name AND sees.commercial = commercial.name)";
					
			//Run the query against the database.
			result = stmt.executeQuery(str);
			
			out.print("<p>Select another commercial to see how many people are interested in commercials on similar channels: ");
			out.print("<p><b>Disclaimer:</b> Not all commercials can be selected, only those that someone of similar age has seen. This still does not gurantee that that consumer watched the commercial AND was interested in that product");
			out.print("<form method=\"post\" action=\"make_recommendations.jsp\">" +
					"<select name=\"commercial\" required>");
			while(result.next()){
				out.print("<option value=\"" + result.getString(1) +"\">" + result.getString(1) + "</option>");
			}
			out.print("</select>" +
			"<input type=\"text\" value=\"" + origAge + "\" name=\"age\" style=\"display:none\">" +
			"<input type=\"text\" value=\"" + gender + "\" name=\"gender\" style=\"display:none\">" +
			"<input type=\"submit\" value=\"Select\">" +
			"</form>");
			
			String otherCommercial = request.getParameter("commercial");
			if(otherCommercial != null){
				out.print("<br>");
				if(otherCommercial.contains("'")){
					String[] parts = otherCommercial.split("'");
					for(int i = 0; i < parts.length - 1; i++){
						otherCommercial = parts[i] + "''" + parts[i+1];
					}
				}
				str = "SELECT COUNT(w.Consumer) "+
						"FROM ((((cs336db.watches w "+
						"INNER JOIN cs336db.channel ch ON w.Channel = ch.Name)"+ 
						"INNER JOIN cs336db.consumer c ON c.Name = w.Consumer) "+
						"INNER JOIN cs336db.sees s ON s.Consumer = c.Name) "+
						"INNER JOIN cs336db.commercial co ON co.Name = s.Commercial) "+
						"WHERE " + age + " = ch.TargetAge " +
						"AND co.Name = '" + otherCommercial + "'";
			
				//Run the query against the database.
				result = stmt.executeQuery(str);
				if(result.next())
					out.print("Total number of consumers of similar age who are interested in commercial <b>" + otherCommercial + "</b> is <b>" + result.getString(1) + "</b>");

			}
			
			out.print("<br>");
			
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
				"AND c.Age = " + age + " " +
				"AND c.Gender = '" + gender + "' " +
				"GROUP BY p.Name " + 
				"ORDER BY COUNT(w.Consumer) desc " +
				"LIMIT 5";
						
			//Run the query against the database.
			result = stmt.executeQuery(str);
			
			if(!result.next()){
				out.print("<p>Sorry, no ideal product were found</p>");
			}
			else{
				//Make an HTML table to show the results in:
				out.print("<p>Here are some Products the consumer may be interested in: </p>");
		
				//parse out the results
				do{
					String product = result.getString(1);
					out.print("<p>A product this consumer may be interested in is: <b><u>"+ product + "</u></b>" + "</p>");
					String answer = result.getString(2);
					out.print("<p style = \"color:#0c192d;\">Number of consumers around the age of " + origAge + " interested in product <b>" + product + 
							"</b> is: <b><u>"+ answer + "</u></b></center></p>");
				}while(result.next());
			}
			str = "SELECT DISTINCT Name FROM cs336db.product ORDER BY Name";
					
			//Run the query against the database.
			result = stmt.executeQuery(str);
			
			out.print("<p>Select another product to see how many people of similar age are interested in it: ");
			out.print("<form method=\"post\" action=\"make_recommendations.jsp\">" +
					"<select name=\"product\" required>");
			
			
			while(result.next()){
				out.print("<option value=\"" + result.getString(1) +"\">" + result.getString(1) + "</option>");
			}
			out.print("</select>" +
			"<input type=\"text\" value=\"" + origAge + "\" name=\"age\" style=\"display:none\">" +
			"<input type=\"text\" value=\"" + gender + "\" name=\"gender\" style=\"display:none\">" +
			"<input type=\"submit\" value=\"Select\">" +
			"</form>");
			
			String otherProduct = request.getParameter("product");
			if(otherProduct != null){
				out.print("<br>");
				if(otherProduct.contains("'")){
					String[] parts = otherProduct.split("'");
					for(int i = 0; i < parts.length - 1; i++){
						otherProduct = parts[i] + "''" + parts[i+1];
					}
				}
				str = 	
						"SELECT COUNT(w.Consumer) " +
						"FROM ((((((cs336db.consumer c " + 
						"INNER JOIN cs336db.watches w ON w.Consumer = c.Name) "+
						"INNER JOIN cs336db.channel ch ON  ch.Name = w.Channel) " +
						"INNER JOIN cs336db.airs a ON a.Channel = ch.Name)" +
						"INNER JOIN cs336db.commercial co ON co.Name = a.Commercial) " +
						"INNER JOIN cs336db.sells se ON se.Commercial_Name = co.Name) " +
						"INNER JOIN cs336db.product p ON p.Name = se.Product_Name) " +
						"WHERE c.Gender = p.Gender " +
						"AND (c.Age = ch.TargetAge) " +
						"AND c.Age = " + age + " " +
						"AND c.Gender = '" + gender + "' " +
						"AND p.Name = '" + otherProduct + "'";
			
				//Run the query against the database.
				result = stmt.executeQuery(str);
				if(result.next())
					out.print("Total number of consumers of similar age who are interested in product <b>" + otherProduct + "</b> is <b>" + result.getString(1) + "</b>");

			}

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