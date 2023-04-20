package action;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.ActionForward;
import dto.Feed;
import svc.SnswriteService;


public class SnsWriteAction2 implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{

		ActionForward forward=null;
		Feed feed = null;
		int fileSize=15*1024*1024;
		ServletContext context = request.getServletContext();
		String imagePath=context.getRealPath("/sns/feedPics");   	
		
		MultipartRequest multi=new MultipartRequest(request,imagePath,fileSize,
				"UTF-8",
				new DefaultFileRenamePolicy());

		feed = new Feed();
	System.out.println("txt 왔냐 "+multi.getParameter("feed_txt"));////////////////////////////////////////////////////////////
		/*객체의 값 세팅하기. cust_id는 snsWrite.jsp에서 session값을 가져와서 세팅했음*/
		feed.setCust_id(multi.getParameter("cust_id"));
		feed.setFeed_txt(multi.getParameter("feed_txt"));
		feed.setFeed_hashtag(multi.getParameter("feed_hashtag"));
		feed.setFeed_pics(
		multi.getFilesystemName((String)multi.getFileNames().nextElement())); //systemname을 가져와야 정확하다
		/* insert 화면에서 값을 주는 영역을 만들지 않았음*/
		//feed.setPro_id(multi.getParameter("pro_id"));   
		//feed.setUsed_id(multi.getParameter("used_id"));
		//feed.setMarket_id(multi.getParameter("market_id"));  //마켓 후기 올리기 위해서 마켓 아이디 몇 개 뜨도록 하는게 좋을 듯
		
		/*썸네일 파일 저장하기*/
		ParameterBlock pb=new ParameterBlock();
		pb.add(imagePath+"/"+feed.getFeed_pics());
		BufferedImage bufferedImage = ImageIO.read(new File(imagePath+"/"+feed.getFeed_pics())); 		// jpg->png로 변경하기		// read a jpeg from a inputFile
		// write the bufferedImage back to outputFile
		
	System.out.println(imagePath+"/"+feed.getFeed_pics());	
		ImageIO.write(bufferedImage, "png", new File(imagePath+"/"+feed.getFeed_pics()));
		RenderedOp rOp=JAI.create("fileload",pb);  //썸네일로 만들어질 원본이미지 이름(경로포함)
		BufferedImage bi= rOp.getAsBufferedImage(); // 지우면 일반화면은 보이고 썸네일은 보이지 않음
		BufferedImage thumb=new BufferedImage(350,350,BufferedImage.TYPE_INT_RGB);   //BufferedImage(int width, int height, int imageType)
		Graphics2D g=thumb.createGraphics();
		g.drawImage(bi,0,0,350,350,null);   //drawImage : 이미지의 일부분을 크기조절 drawImage(image, sx, sy, sWidth, sHeight)
											//sx : 이미지 왼쪽 상단 모서리가 위치할 Canvas내 X 좌표, sy : 이미지 왼쪽 상단 모서리가 위치할 Canvas내 y 좌표
		
		/*작은 이미지를 폴더 안에 저장하기*/
		File file=new File(imagePath+"/sm_"+feed.getFeed_pics());
		ImageIO.write(thumb,"jpg",file);
	System.out.println("action write action 잘 되어가는가");
	
		/*service 부르기*/
		SnswriteService scv = new SnswriteService();
		boolean isWriteSuccess = scv.registArticle(feed);
	System.out.println("insert 성공했나요? =>"+isWriteSuccess);
		if(!isWriteSuccess){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 올리기에 실패했습니다')");
			out.println("history.back();");
			out.println("</script>");
		}
		else{
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("snsListAction.bo");
		}

		return forward; //actionfoward의 객체를 리턴.

	}  	

}