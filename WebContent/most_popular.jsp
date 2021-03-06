<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Facts - CommercialFacts</title>
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
	<!-- Prints most popular Product, Commercial, and Channel -->
	<%
    
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Gets most popular Product
		Statement stmt = con.createStatement();
		
		String str = "SELECT ProductName, Count(*) FROM cs336db.interested GROUP BY ProductName ORDER BY Count(*) DESC LIMIT 3";
		
		out.print("<center><div style = \"background-color:white;border:solid;border-radius:5px; \" ><p>Product with most people interested in: </p>");
		
		ResultSet result = stmt.executeQuery(str);
		while(result.next())
			out.print("<p><b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> interested consumers</p>");
		out.print("</div></center>");
		//Gets product with most commercials
		stmt = con.createStatement();
		
		str = "SELECT Product_Name, Count(*) FROM cs336db.sells GROUP BY Product_Name ORDER BY Count(*) DESC LIMIT 3";
		
		out.print("<br><center><div style = \"background-color:white;border:solid;border-radius:5px; \" ><p>Product with most commercials: </p>");
		
		result = stmt.executeQuery(str);
		while(result.next())
			out.print("<p><b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> commercials</p>");
		out.print("</div></center>");
		//Gets Commercial played on most channels
		stmt = con.createStatement();
		
		str = "SELECT Commercial, Count(*) FROM cs336db.airs GROUP BY Commercial ORDER BY Count(*) DESC LIMIT 3";
		out.print("<br><center><div style = \"background-color:white;border:solid;border-radius:5px; \" ><p>Commercial on most different channels: </p>");
		
		result = stmt.executeQuery(str);
		while(result.next())
			out.print("<p><b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> different channels</p>");
		out.print("</div></center>");
		//Gets Channel with most people watching 
		stmt = con.createStatement();
		
		str = "SELECT Channel, Count(*) FROM cs336db.watches GROUP BY Channel ORDER BY Count(*) DESC LIMIT 3";
		out.print("<br><center><div style = \"background-color:white;border:solid;border-radius:5px; \" ><p>Channel with most people watching: </p>");
		
		result = stmt.executeQuery(str);
		while(result.next())
			out.print("<p><b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> different Consumers watching</p>");
		out.print("</div></center>");
		//close the connection.
		db.closeConnection(con);
		con.close();
		}catch (Exception e) {
			out.print(e);
	}
	%>
	<br>
	<br>
	<center><div style="background-color:#ffbff4; border:solid;border-radius:5px;">
	<p>Select an entity table to select a specific tuple and find it's statistics</p>
	
<form class="myForm" action="make_commercial.jsp" method="get" enctype="application/x-www-form-urlencoded" action="/html/codes/html_form_handler.cfm">
		<select name="table" size=1 required>
			<option style="color:gray" value="">Choose Entity</option>
			<option value="Channel">Channel</option>
			<option value="Commercial">Commercial</option>
			<option value="Consumer">Consumer</option>
			<option value="Product">Product</option>
		</select>&nbsp;<br><input type="submit" value="Select Table">
	</form>
		
	<!-- Select Channel/Commercial/Product/Consumer to display individual stats -->
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String table = request.getParameter("table");
		if(table == null)
			table = request.getParameter("table_text");
		if(table != null){
			out.print("<p>Select an entity to find it's statistics");
			out.print("<p>Selecting from table: " + table + "</p><br>");
			out.print("<form method=\"post\" action=\"most_popular.jsp\">");
			out.print("<input type=\"text\" value=\"" + table + "\" name=\"table_text\" style=\"display:none\">");
				
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT Name FROM cs336db." + table.toLowerCase();
					
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			out.print("<select name=\"choose_name\" size=1>");
			out.print("<option value=\"DEFAULT\">Select " + table + "</option>");
			
			while(result.next()){
				String curName = result.getString(1);
				out.print("<option value=\"" + curName + "\">" + curName +"</option>");
			}
			out.print("</select>&nbsp;");
			out.print("<input type=\"submit\" value=\"Select " + table + "\">");
			out.print("</form>");
		}
		String name = request.getParameter("choose_name");
		if(name != null){
			String tableText = request.getParameter("table_text");
						
			if(tableText.equals("Product")){
				out.print("<p id=\"indent\">Product: <b>" + name + "</b></p><br>");
				
				//Gets product's consumers
				Statement stmt = con.createStatement();
				
				String str = "SELECT Count(*) FROM cs336db.interested WHERE ProductName = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Has <b>" + result.getString(1) + "</b> interested consumers</p><br>");
				
				//Gets product's commercials
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM cs336db.sells WHERE Product_Name = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">   Featured on <b>" + result.getString(1) + "</b> commercials</p><br>");
				
			}
			else if(tableText.equals("Consumer")){
				out.print("<p id=\"indent\">Consumer: <b>" + name + "</b></p><br>");
				
				//Gets consumer's products
				Statement stmt = con.createStatement();
				
				String str = "SELECT Count(*) FROM cs336db.interested WHERE Name = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Interested in <b>" + result.getString(1) + "</b> products</p><br>");
				
				//Gets consumer's channels
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM cs336db.watches WHERE consumer = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Watches <b>" + result.getString(1) + "</b> channels</p><br>");
				
				//Gets consumer's commercials
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM cs336db.sees WHERE consumer = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Seen <b>" + result.getString(1) + "</b> commercials</p><br>");
				
			}
			else if(tableText.equals("Commercial")){
				out.print("<p id=\"indent\">Commercial: <b>" + name + "</b></p><br>");
				
				//Gets Commercial's product
				Statement stmt = con.createStatement();
				
				String str = "SELECT Product_Name FROM cs336db.sells WHERE Commercial_Name = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> is sold by this commercial</p><br>");
				
				
				//Gets Commercial's Channels
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM cs336db.airs WHERE Commercial = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> channels air this commercial</p><br>");
				
				
				//Gets Commercial's viewers (consumers)
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM cs336db.sees WHERE Commercial = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> consumers have seen this</p><br>");
				
			}
			else if(tableText.equals("Channel")){
				out.print("<p id=\"indent\">Channel: <b>" + name + "</b></p><br>");	
				
				//Gets Channel's viewers (consumers)
				Statement stmt = con.createStatement();
				
				String str = "SELECT Count(*) FROM cs336db.watches WHERE channel = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> consumers watch this channel</p><br>");
				
				
				//Gets Channel's commercials
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM cs336db.airs WHERE channel = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> commercials air on this channel</p><br>");	
			}
		}
		out.print("</div></center>");
		db.closeConnection(con);
		con.close();
	}catch(Exception e){
		out.print(e);
	}
	
	%>
	
</body>
</html>