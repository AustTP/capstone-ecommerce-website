<%@ page language="Java" import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="/header" prefix="aat" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>

		<jsp:useBean id="validator" class="beans.Validator"/>
		<jsp:useBean id="save" scope="page" class="beans.purchase" >
		<jsp:setProperty name="save" property="*" />
		</jsp:useBean>

		<meta charset="UTF-8">
		<title>Record</title>
		<link href="style.css" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
	</head>

	<%@ page import="java.io.*"%>
	<%@ page import="java.servlet.*"%>
	<%@ page import="java.net.URL" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="oracle.jdbc.OracleResultSetMetaData" %>

	<%! Connection conn = null; %>
	<%! Statement stmt = null; %>
	<%! ResultSet resultSet = null; %>
	
		<%
			PreparedStatement psSelectRecord=null;
			String sqlSelectRecord=null;
			ResultSet purchaseResults = null;

			if (!validator.hasTable()) {
				response.sendRedirect("CreateTables.jsp");	
			} else {	
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "student1","pass");
				sqlSelectRecord ="SELECT purchase.qnty, product.product, client.client, client.address, client.city, client.state, client.zipCode, client.phone, client.emailAddress, client.ccNum, client.expDate, client.secCode, product.price * purchase.qnty AS TotalCost" +
				" FROM purchase, client, product" +
				" WHERE purchase.clientid = client.clientid AND purchase.productid = product.productid";
				psSelectRecord=conn.prepareStatement(sqlSelectRecord);
				purchaseResults=psSelectRecord.executeQuery();
			}
		%>
		
	<body>
		<aat:header />
		
		<div style="margin: 35px auto 15px auto; max-width: 800px;">
		
		<%
		while(purchaseResults != null && purchaseResults.next()){
		%>
		
		<h2 style="font-family: Raleway;">Customer Information - <%=purchaseResults.getString("client")%></h2>
		<table style="border: 0px; border-collapse: collapse;">
			<tr style="background-color: #4477a1; color: #FFF;">
				<th>Full Name</th>
				<th>Address</th>
				<th>City</th>
				<th>State</th>
				<th>Zip Code</th>
				<th>Phone</th>
				<th>E-mail Address</th>
			</tr>		
			<tr style="background-color: #FFF;">
				<td style="text-align: center;"><%=purchaseResults.getString("client")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("address")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("city")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("state")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("zipCode")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("phone")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("emailAddress")%></td>
			</tr>
		</table>
		
		<h2 style="font-family: Raleway;">Payment Information</h2>
		<table style="border: 0px; border-collapse: collapse;">
			<tr style="background-color: #4477a1; color: #FFF;">
				<th>Credit Card Number</th>
				<th>Expiration Date</th>
				<th>Security Code</th>
			</tr>
			<tr style="background-color: #FFF;">
				<td style="text-align: center;"><%=purchaseResults.getString("ccNum")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("expDate")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("secCode")%></td>
			</tr>
		</table>
		
		<h2 style="font-family: Raleway;">Shopping Cart</h2>		
		<table style="border: 0px; border-collapse: collapse;">
			<tr style="background-color: #4477a1; color: #FFF;">
				<th>Product</th>
				<th>Quantity</th>
				<th>Total Cost</th>
			</tr>
			<tr style="background-color: #FFF;">
				<td style="text-align: center;"><%=purchaseResults.getString("product")%></td>
				<td style="text-align: center;"><%=purchaseResults.getString("qnty")%></td>
				<td style="text-align: center;">$<%=purchaseResults.getString("TotalCost")%></td>
			</tr>
		</table><br /><br />
		<%
		}
		%>
		</table>
	</body>
</html>
