<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h3>카테고리별 매출현황 조회</h3>
<%@ page import="java.sql.*"%>
<table border="1">
	<tr>
		<td>구매 일자</td>
		<td>총 구매 내역</td>
		<td>구매 개수</td>
	</tr>
	<%
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            Connection conn = DriverManager.getConnection
                                ("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
            
            Statement stmt = conn.createStatement();
            String query = "SELECT "+
            "category.NAME, sum(SALE.SALE_PRICE), sum(SALE.AMOUNT) "+
            "FROM "+
            "	SALE, PRODUCT, category "+
            "WHERE "+
            "	SALE.PRODUCT_ID = PRODUCT.PRODUCT_ID and "+
            "	category.CATEGORY_ID = PRODUCT.CATEGORY_ID "+
            "group by "+
            "	category.CATEGORY_ID, category.NAME ";
      	ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
            	%>
	<tr>
		<td><%=rs.getString(1) %></td>
		<td><%=rs.getInt(2) %></td>
		<td><%=rs.getInt(3) %></td>
	</tr>
	<%
            }

            stmt.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
%>
	</body>
</table>