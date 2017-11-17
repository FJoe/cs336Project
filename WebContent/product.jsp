<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Optimize Product - CommercialFacts</title>

</head>
<body>
	<div id="links" style="width:100%">
		<a class="link" href="home.jsp">Home</a>
		<a class="link" href="index.jsp">Display Table</a>
		<a class="link" href="add.jsp">Add Tuple</a>
		<a class="link" href="delete.jsp">Delete Tuple</a>
		<a class="link" href="product.jsp">Optimize Product</a>
		<a class="link" href="facts.jsp">Facts</a>
	</div>
	
	<br>
	<br>
	
<!--  Creates Form for user to input -->
	<% 
	class NoInputtedValueException extends Exception{
		NoInputtedValueException(String msg){
			super(msg);
		}
	}
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		out.print("<form method=\"post\" action=\"product.jsp\">");
		out.print("<input type=\"text\" placeholder=\"Price\" name=\"price\"><br>");
			
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String str = "SELECT DISTINCT Market FROM Project.Product";
				
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		

		out.print("<select name=\"choose_market\" size=1>");
		out.print("<option value=\"DEFAULT\">Select Market</option>");
		
		while(result.next()){
			String curMarket = result.getString(1);
			out.print("<option value=\"" + curMarket + "\">" + curMarket +"</option>");
		}
		
		out.print("</select>&nbsp;<br>");
		
		stmt = con.createStatement();
		
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		str = "SELECT DISTINCT Company FROM Project.Product";
				
		//Run the query against the database.
		result = stmt.executeQuery(str);
		

		out.print("<select name=\"choose_company\" size=1>");
		out.print("<option value=\"DEFAULT\">Select Company</option>");
		
		while(result.next()){
			String curCompany = result.getString(1);
			out.print("<option value=\"" + curCompany + "\">" + curCompany +"</option>");
		}
		
		out.print("</select>&nbsp;<br>");
		
		stmt = con.createStatement();
		
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		str = "SELECT DISTINCT Gender FROM Project.Product";
				
		//Run the query against the database.
		result = stmt.executeQuery(str);
		

		out.print("<select name=\"choose_gender\" size=1>");
		out.print("<option value=\"DEFAULT\">Select Target Gender</option>");
		
		while(result.next()){
			String curGender = result.getString(1);
			out.print("<option value=\"" + curGender + "\">" + curGender +"</option>");
		}
		
		out.print("</select>&nbsp;<br>");
		out.print("<input type=\"submit\" value=\"Optimize Product!\">");
		out.print("</form>");
		//close the connection.
		db.closeConnection(con);
		con.close();
	} catch (Exception e) {
		out.print(e);
	}
	%>
	<br>
	<br>
	<!-- Finds which commercial type to create and which channel to play it -->	
	<%
		try{
			String priceString = request.getParameter("price");
			if(priceString != null && priceString.equals(""))
				priceString = null;
			String market = request.getParameter("choose_market");
			if(market != null && market.equals("DEFAULT"))
				market = null;
			String company = request.getParameter("choose_company");
			if(company != null && company.equals("DEFAULT"))
				company = null;
			String gender = request.getParameter("choose_gender");
			if(gender != null && gender.equals("DEFAULT"))
				gender = null;
						
			//If no value inputted
			if(priceString == null && market == null && company == null && gender == null)
				throw new NoInputtedValueException("No value inputted");
			
			double price;
			if(priceString != null)
				price = Double.parseDouble(request.getParameter("price"));
			
			//ADD QUERY
			
			out.print("<p>With these attributes:<br></p>");
			if(priceString != null)
				out.print("<p id=\"indent\">Price: " + priceString + "</p>");
			if(market != null)
				out.print("<p id=\"indent\">Market: " + market + "</p>");
			if(company != null)
				out.print("<p id=\"indent\">Company: " + company + "</p>");
			if(gender != null)
				out.print("<p id=\"indent\">Target gender: " + gender+ "</p>");
			out.print("Optimal commercial type: ");
			out.print("<br>");
			out.print("Channel to air commercial: ");
		}catch(NoInputtedValueException e){
			out.print("<p>" + e.getMessage() + "</p>");	
		}catch(NumberFormatException e){
			out.print("<p>Incorrect number format</p>");
		}catch(Exception e){
			out.print(e);
		}
	%>
</body>
</html>