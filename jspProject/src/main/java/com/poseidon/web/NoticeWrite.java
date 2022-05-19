package com.poseidon.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.poseidon.dao.NoticeDAO;
import com.poseidon.dto.NoticeDTO;

@WebServlet("/noticeWrite")
public class NoticeWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeWrite() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//여기로 와요
		request.setCharacterEncoding("UTF-8");
		//response.setCharacterEncoding("UTF-8");
		
		//String title = request.getParameter("title");
		//System.out.println("title : " +  title);
		String url = request.getRealPath("/upload");//저장위치
		System.out.println(url);//찍어보기
		
		MultipartRequest multi = new MultipartRequest(
				//HSR    저장위치  파일크기     파일 중속시 정책
				request, url , 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("title");
		title = new String(title.getBytes("8859_1"),"utf-8");//?
		String content = multi.getParameter("content");
		System.out.println(title);
		System.out.println(content);//?
		//파일l
		String file = multi.getFilesystemName("file");
		System.out.println(file);
		String oriFileName = multi.getOriginalFileName("file");
		System.out.println(oriFileName);
		
		//DTO
		NoticeDTO dto = new NoticeDTO();
		dto.setN_title(title);
		dto.setN_content(content);
		dto.setN_orifilename(oriFileName);
		dto.setN_filename(file);
		HttpSession session = request.getSession();
		dto.setM_id((String) session.getAttribute("m_id"));
		//DAO
		NoticeDAO dao = new NoticeDAO();
		dao.noticeWrite(dto);
		
		response.sendRedirect("./notice");
		
		
	}

}
