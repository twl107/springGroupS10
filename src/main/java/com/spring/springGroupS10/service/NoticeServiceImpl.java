package com.spring.springGroupS10.service;

import java.io.File;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS10.common.ProjectProvide;
import com.spring.springGroupS10.dao.NoticeDAO;
import com.spring.springGroupS10.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO noticeDAO;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public int getTotRecCnt() {
		return noticeDAO.getTotRecCnt();
	}

	@Override
	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize) {
		return noticeDAO.getNoticeList(startIndexNo, pageSize);
	}

	@Override
	public NoticeVO getNoticeContent(int idx) {
		return noticeDAO.getNoticeContent(idx);
	}
	
	@Override
	public int setNoticeInput(NoticeVO vo) {
		return noticeDAO.setNoticeInput(vo);
	}
	
	@Override
	public int setNoticeUpdate(MultipartFile file, NoticeVO vo, HttpServletRequest request) {
		
		String realPathNotice = request.getSession().getServletContext().getRealPath("/resources/data/notice/");
		
		try {
			NoticeVO originalVO = noticeDAO.getNoticeContent(vo.getIdx());
			String originalContent = (originalVO != null) ? originalVO.getContent() : "";
			List<String> originalImages = projectProvide.extractImageFileNames(originalContent, "notice");
			
			String content = vo.getContent();
			if(content != null && content.indexOf("src=\"/") != -1) {
				String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
				
				Pattern pattern = Pattern.compile("src=\"/springGroupS10/data/ckeditor/([^\"]+)\"");
				Matcher matcher = pattern.matcher(content);
				
				while(matcher.find()) {
					String imgFile = matcher.group(1); // 정규식 괄호 안에 매칭된 파일명 가져옴
					
					String oriFilePath = uploadPath + "ckeditor/" + imgFile;
					String copyFilePath = uploadPath + "notice/" + imgFile;
					
					projectProvide.fileCopyCheck(oriFilePath, copyFilePath);
				}
				vo.setContent(content.replace("/data/ckeditor/", "/data/notice/"));
			}
			
			List<String> newImages = projectProvide.extractImageFileNames(vo.getContent(), "notice");
			
			for (String originalImg : originalImages) {
				if (!newImages.contains(originalImg)) {
					File deleteFile = new File(realPathNotice + originalImg);
					if (deleteFile.exists()) {
						deleteFile.delete();
					}
				}
			}
			
			return noticeDAO.setNoticeUpdate(vo);
		} 
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
	
	@Override
	public int setNoticeDelete(int idx) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPathNotice = request.getSession().getServletContext().getRealPath("resources/data/notice/");
		
		NoticeVO vo = noticeDAO.getNoticeContent(idx);
		if(vo == null || vo.getContent() == null) {
			return noticeDAO.setNoticeDelete(idx);
		}

		List<String> imagesToDelete = projectProvide.extractImageFileNames(vo.getContent(), "notice");
		for(String imgFile : imagesToDelete) {
			File deleteFile = new File(realPathNotice + imgFile);
			if(deleteFile.exists()) deleteFile.delete();
		}
		return noticeDAO.setNoticeDelete(idx);
	}
	
	@Override
	public NoticeVO readNoticeContent(int idx) {
		noticeDAO.setViewCntUpdate(idx);
		return noticeDAO.getNoticeContent(idx);
	}

	@Override
	public int noticeImgSave(MultipartFile file, NoticeVO vo, Long sMemberIdx) {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String content = vo.getContent();
		if(content != null && content.indexOf("src=\"/") != -1) {
			String uploadPath = request.getSession().getServletContext().getRealPath("resources/data/");
			
			Pattern pattern = Pattern.compile("src=\"/springGroupS10/data/ckeditor/([^\"]+)\"");
			Matcher matcher = pattern.matcher(content);
			
			while(matcher.find()) {
				String imgFile = matcher.group(1);
				
				String orFilePath = uploadPath + "ckeditor/" + imgFile;
				String copyFilePath = uploadPath + "notice/" + imgFile;
				
				projectProvide.fileCopyCheck(orFilePath, copyFilePath);
			}
			vo.setContent(content.replace("/data/ckeditor/", "/data/notice/"));
		}
		
		vo.setMemberIdx(sMemberIdx);
		int res = noticeDAO.setNoticeInput(vo);
		
		return res;
	}
	
}
