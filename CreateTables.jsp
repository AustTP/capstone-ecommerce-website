<!-- 
Bellevue University
Group Pilot AllAboardToys.com project
Group 3
Gage Mikels, Jacob Nielsen, Austin Poole, Dawn Rutherford, Stephanie Shannon 
20 October 2016

This JSP creates all tables that will be used with the form. 
-->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/header" prefix="aat" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>Record</title>
		<link type="text/css" rel="stylesheet" href="style.css">
		<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
	</head>

	<%@ page import="java.io.*"%>
	<%@ page import="java.servlet.*"%>
	<%@ page import="java.net.URL" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="oracle.jdbc.OracleResultSetMetaData" %>
	<%@ page import="java.util.UUID" %>
	
	<%! Connection conn = null; %>
	<%! Statement stmt = null; %>
	<%! ResultSet resultSet = null; %>

	<%
	try {
		DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "student1", "pass");
		stmt = conn.createStatement();
	} catch (Exception e) {
		out.println(e);
	}
	%>
		
	<body>
		<aat:header />
		<%
		if(request.getMethod().equals("GET")) {
		%>
		
			<div style="margin: 35px auto 15px auto; max-width: 800px;">
				<h2 style="font-family: Raleway;">Create Tables</h2>
				<p>Do you want to create the Database?</p>
				<form method='post' action='CreateTables.jsp'>
					<input type='submit' value='Create'>
				</form>
				
		<%
		}

		if(request.getMethod().equals("POST")) {
			try {
				stmt.executeUpdate("DROP TABLE CLIENT");
			} catch(SQLException e) {
				out.println("<b>If table was there, it has been dropped</b><br />");
			}
			
			try {
				stmt.executeUpdate("CREATE TABLE CLIENT(clientID VARCHAR2(36), client VARCHAR2(100), address VARCHAR2(100), city VARCHAR2(50), state VARCHAR(50), zipCode VARCHAR2(36), phone VARCHAR2(20), emailAddress VARCHAR(50), ccNum VARCHAR2(100), expDate VARCHAR2(100), secCode VARCHAR2(100), CONSTRAINT client_pk PRIMARY KEY (clientID))");
				out.println("<b>The CLIENT table has been created.</b><br />");
			} catch(SQLException e) {
				out.println("<b> The CLIENT table failed to create.</b><br />");
			}
			
			try {
				stmt.executeUpdate("DROP TABLE PURCHASE");
			} catch(SQLException e) {
				out.println("<b>If table was there, it has been dropped</b><br />");
			}
			
			try {
				stmt.executeUpdate("CREATE TABLE PURCHASE(purchaseCode VARCHAR2(36), clientID VARCHAR2(36), productID VARCHAR2(36), qnty SMALLINT, CONSTRAINT purchase_pk PRIMARY KEY (purchaseCode))");
				out.println("<strong>The PURCHASE table has been created.</b><br />");
			} catch(SQLException e) {
				out.println(e);
				out.println("<strong>The PURCHASE table failed to create.</strong><br />");
			}
			
			try {
				stmt.executeUpdate("DROP TABLE PRODUCT");
			} catch(SQLException e) {
				out.println("<b>If table was there, it has been dropped</b><br />");
			}
			
			try {
				stmt.executeUpdate("CREATE TABLE PRODUCT(productID VARCHAR2(36), product VARCHAR2(100), price DECIMAL(18, 2), CONSTRAINT product_pk PRIMARY KEY (productID))");
				out.println("<b>The PRODUCT table has been created.</b><br />");
			} catch(SQLException e) {
				out.println(e);
				out.println("<b> The PRODUCT table failed to create.</b><br />");
			}

			try {
				String productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Engine', '50.99')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Caboose', '49.99')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Coal Car', '29.95')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Box Car', '29.95')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', '6 Inch Track', '9.99')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Roundhouse Track', '15.99')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', '180 Curved Track', '9.99')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Station House', '25.99')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Elm Tree', '3.95')");
				
				productID = UUID.randomUUID().toString();
				stmt.executeUpdate("INSERT INTO PRODUCT VALUES('" + productID + "', 'Water Tower', '5.95')");
								
				out.println("<b>Data successfully inserted.</b><br />");
			} catch(SQLException e) {
				out.println(e);
				out.println("<b>Error inserting data. </b><br />");
			}
		}
		%>
		</div>
	</body>
</html>

<%
try {
	conn.close();
} catch(SQLException e) {
	out.println(e);
}
%>