package com.spring.springGroupS10.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

//@Component
@Service
public class ProjectProvide {
	
	@Autowired
	JavaMailSender mailSender;
	

	// 메일 보내기
	public String mailSend(
			String toMail,
			String title,
			String mailFlag
		) throws MessagingException {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		String content = "";
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지보관함에 저장되는 'content'변수안에 발신자의 필요한 정보를 추가로 담아준다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>SpringGroup에서 보냅니다.</h3><hr>";
		content += "<font size='5' color='red'><b>"+mailFlag+"</b></font><hr>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/cjgreen'>springGroup</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		mailSender.send(message);
		
		return "1";
	}
	
	public String saveFile(MultipartFile file, String part, HttpServletRequest request) throws IOException {
		String originalFileName = file.getOriginalFilename();
		UUID uuid = UUID.randomUUID();
		String serverFileName = uuid + "_" + originalFileName;
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/" + part + "/");
		
		File realPathFile = new File(realPath);
		if(!realPathFile.exists()) {
			realPathFile.mkdirs();
		}
		
		file.transferTo(new File(realPath + serverFileName));
		
		return serverFileName;
	}
	
	public String formatFileSize(long size) {
		if(size <= 0) return "0";
		final String[] units = new String[] {"Bytes", "KB", "MB", "GB", "TB"};
		int digitGroups = (int) (Math.log10(size) / Math.log10(1024));
		return new DecimalFormat("#,##0.#").format(size / Math.pow(1024, digitGroups)) + " " + units[digitGroups];
	}
	
	
	// 지정된 경로의 파일 삭제하기
	public void deleteFile(String serverFileName, String part, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+part+"/");
		
		File file = new File(realPath + serverFileName);
		if(file.exists()) file.delete();
	}

	public void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<String> extractImageFileNames(String content, String directory) {
		List<String> fileNames = new ArrayList<>();
		if (content == null || content.isEmpty()) {
			return fileNames;
		}
		
		// "src="/springGroupS10/data/notice/([^\"]+)" 와 같은 형태의 정규식 생성
		Pattern pattern = Pattern.compile("src=\"/springGroupS10/data/" + Pattern.quote(directory) + "/([^\"]+)\"");
		Matcher matcher = pattern.matcher(content);
		
		while(matcher.find()) {
			fileNames.add(matcher.group(1)); // 괄호 ( ) 안에 매칭된 파일명만 추출
		}
		
		return fileNames;
	}
	
	
	
	
}
