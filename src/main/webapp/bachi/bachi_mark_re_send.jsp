 <%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Bachi_market"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.ArrayList"%>
    <%@page import="dao.Gosu_mark"%>
    <%@ page import="java.io.*" %>
    <%@ page import="java.awt.Graphics2D" %>
<%@ page import="java.awt.image.renderable.ParameterBlock" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.media.jai.JAI" %>
<%@ page import="javax.media.jai.RenderedOp" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <jsp:useBean id="market1" class="dao.Gosu_mark">
<%
ServletContext context = request.getServletContext();
String imagePath=context.getRealPath("image");

int size = 1*1024*1024 ;
String filename="";

try{
	MultipartRequest multi=	new MultipartRequest(request,
	  					  imagePath,
						  size,
						  "utf-8",
						new DefaultFileRenamePolicy());
	
	Enumeration files=multi.getFileNames();
	
	String file =(String)files.nextElement();
	filename=multi.getFilesystemName(file);
	
	Bachi_market mark = new Bachi_market();
	mark.setCust_id((String) session.getAttribute("cust_id"));
	mark.setGosu_id(multi.getParameter("gosu_id"));
	mark.setMarket_text(multi.getParameter("market_text"));
	mark.setMarket_title(multi.getParameter("market_title"));
	mark.setGosu_menu1(multi.getParameter("gosu_menu1"));
	mark.setGosu_menu2(multi.getParameter("gosu_menu2"));
	filename = multi.getFilesystemName("filename");
	mark.setMarket_picture(filename);

	dao.Gosu_mark market = new dao.Gosu_mark();
	market.gosu_mark_add(mark);
	response.sendRedirect("bachi_market.jsp");
}catch(Exception e){
	e.printStackTrace();
}

ParameterBlock pb=new ParameterBlock();
pb.add(imagePath+"/"+filename);
RenderedOp rOp=JAI.create("fileload",pb);

BufferedImage bi= rOp.getAsBufferedImage();
BufferedImage thumb=new BufferedImage(600,600,BufferedImage.TYPE_INT_RGB);

Graphics2D g=thumb.createGraphics();
g.drawImage(bi,0,0,600,600,null);

File file=new File(imagePath+"/sm_"+filename);
ImageIO.write(thumb,"jpg",file);


%>
</jsp:useBean>

</body>
</html>