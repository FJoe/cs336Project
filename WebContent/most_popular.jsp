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
<body>
	<div id="links" style="width:100%">
		<a class="link" href="home.jsp">Home</a>
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="delete.jsp">Delete Tuple</a>
		<a class="link" href="facts.jsp">Commercial Generator</a>
		<a class="link" href="facts_channel.jsp">Viewer Favorites</a>
		<a class="link" href="facts_commercial.jsp">Where to Advertise</a>
		<a class="link" href="facts_consumer.jsp">I want to shop</a>
		<a class="link" href="most_popular.jsp">Entity Stats</a>
		<a class="link" href="patterns.jsp">Patterns</a>
	</div>
	
	<!-- Prints most popular Product, Commercial, and Channel -->
	<%
    
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Gets most popular Product
		Statement stmt = con.createStatement();
		
		String str = "SELECT Product, Count(*) FROM Project.Interested GROUP BY Product ORDER BY Count(*) DESC LIMIT 1";
		
		out.print("<p id=\"indent\">Product with most people interested in: ");
		
		ResultSet result = stmt.executeQuery(str);
		result.next();
		out.print("<b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> interested consumers");
		//Gets product with most commercials
		stmt = con.createStatement();
		
		str = "SELECT Product, Count(*) FROM Project.Sells GROUP BY Product ORDER BY Count(*) DESC LIMIT 1";
		
		out.print("<p id=\"indent\">Product with most commercials: ");
		
		result = stmt.executeQuery(str);
		result.next();
		out.print("<b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> commercials");
		
		//Gets Commercial played on most channels
		stmt = con.createStatement();
		
		str = "SELECT Commercial, Count(*) FROM Project.Airs GROUP BY Commercial ORDER BY Count(*) DESC LIMIT 1";
		out.print("<p id=\"indent\">Commercial on most different channels: ");
		
		result = stmt.executeQuery(str);
		result.next();
		out.print("<b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> different channels");
		
		//Gets Channel with most people watching 
		stmt = con.createStatement();
		
		str = "SELECT Channel, Count(*) FROM Project.Watches GROUP BY Channel ORDER BY Count(*) DESC LIMIT 1";
		out.print("<p id=\"indent\">Channel with most people watching: ");
		
		result = stmt.executeQuery(str);
		result.next();
		out.print("<b>" + result.getString(1) + "</b> with <b>" + result.getString(2) + "</b> different Consumers watching");
		
		//close the connection.
		db.closeConnection(con);
		con.close();
		}catch (Exception e) {
			out.print(e);
	}
	%>
	<br>
	<br>
	<p>Select an entity table to select a specific tuple and find it's statistics</p>
	
	<form method="post" action="most_popular.jsp">
		<select name="table" size=1>
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
			String str = "SELECT Name FROM Project." + table;
					
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
				
				String str = "SELECT Count(*) FROM Project.Interested WHERE Product = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Has <b>" + result.getString(1) + "</b> interested consumers</p><br>");
				
				//Gets product's commercials
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM Project.Sells WHERE Product = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">   Featured on <b>" + result.getString(1) + "</b> commercials</p><br>");
				
			}
			else if(tableText.equals("Consumer")){
				out.print("<p id=\"indent\">Consumer: <b>" + name + "</b></p><br>");
				
				//Gets consumer's products
				Statement stmt = con.createStatement();
				
				String str = "SELECT Count(*) FROM Project.Interested WHERE Consumer = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Interested in <b>" + result.getString(1) + "</b> products</p><br>");
				
				//Gets consumer's channels
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM Project.Watches WHERE Consumer = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Watches <b>" + result.getString(1) + "</b> channels</p><br>");
				
				//Gets consumer's commercials
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM Project.Sees WHERE Consumer = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\">Seen <b>" + result.getString(1) + "</b> commercials</p><br>");
				
			}
			else if(tableText.equals("Commercial")){
				out.print("<p id=\"indent\">Commercial: <b>" + name + "</b></p><br>");
				
				//Gets Commercial's product
				Statement stmt = con.createStatement();
				String product = name.split("-_-")[0];
				out.print("<p id=\"indent\">Sells <b>" + product + "</b></p><br>");
				
				
				//Gets Commercial's Channels
				stmt = con.createStatement();
				
				String str = "SELECT Count(*) FROM Project.Airs WHERE Commercial = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> channels air this commercial</p><br>");
				
				
				//Gets Commercial's viewers (consumers)
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM Project.Sees WHERE Commercial = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> consumers have seen this</p><br>");
				
			}
			else if(tableText.equals("Channel")){
				out.print("<p id=\"indent\">Commercial: <b>" + name + "</b></p><br>");	
				
				//Gets Channel's viewers (consumers)
				Statement stmt = con.createStatement();
				
				String str = "SELECT Count(*) FROM Project.Watches WHERE Channel = \"" + name + "\"";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> consumers watch this channel</p><br>");
				
				
				//Gets Channel's commercials
				stmt = con.createStatement();
				
				str = "SELECT Count(*) FROM Project.Airs WHERE Channel = \"" + name + "\"";
				result = stmt.executeQuery(str);
				result.next();
				out.print("<p id=\"indent\"><b>" + result.getString(1) + "</b> commercials air on this channel</p><br>");	
			}
		}
		db.closeConnection(con);
		con.close();
	}catch(Exception e){
		out.print(e);
	}
	
	%>
	
</body>
</html>