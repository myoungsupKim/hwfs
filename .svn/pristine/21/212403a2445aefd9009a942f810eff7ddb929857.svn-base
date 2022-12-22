package com.hwfs.sc.cmn.util;

import hone.core.util.ApplicationContextHolder;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.security.Security;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.cmn.service.PropertiesService;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

 /**
 * SFTP Utility
 * @ClassName SftpUtil.java
 * @Description SftpUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 6    ChAoS        최초생성
 * </pre>
 * @author 통합영업회계(ISA) : ChAoS
 * @since 2015. 7. 6
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SftpUtil {
	
	private final Logger LOGGER = LoggerFactory.getLogger(SftpUtil.class);
	
	private final PropertiesService propertiesService  = (PropertiesService)ApplicationContextHolder.getBean("propertiesService");
	
	private ChannelSftp channelSftp = null;
	private Session session = null;
	private Channel channel = null;
	
    /**
     * SFTP Connection 을 연결한다.
     *
     * @author ChAoS<br>
     *
     * @param String host, int port, String userid, String password 
     * @return ChannelSftp
     * @throws JSchException 
     */
	public ChannelSftp connect(String host, int port, String userid, String password) throws JSchException {

		Security.insertProviderAt(new BouncyCastleProvider(), 1);

		// 1. JSch 객체를 생성한다.
		JSch jsch = new JSch();

		// 2. 세션 객체를 생성한다(사용자 이름, 접속할 호스트, 포트를 인자로 전달한다.)
		session = jsch.getSession(userid, host, port);
		
		LOGGER.debug("password >>>> " + password);
		
		// 3. 패스워드를 설정한다.
		session.setPassword(password);

		// 4. 세션과 관련된 정보를 설정한다.
		java.util.Properties config = new java.util.Properties();
		// 4-1. 호스트 정보를 검사하지 않는다.
		config.put("StrictHostKeyChecking", "no");
		session.setConfig(config);

		// 5. 접속한다.
		session.connect();
		
		// 6. sftp 채널을 연다.
		channel = session.openChannel("sftp");

		// 7. 채널에 연결한다.
		channel.connect();

		// 8. 채널을 FTP용 채널 객체로 캐스팅한다.
		channelSftp = (ChannelSftp) channel;
		LOGGER.debug("==> Connected to {}", host);

		return channelSftp;
		
	}

    /**
     * SFTP Connection 을 통해 파일을 다운로드 한다.
     *
     * @author ChAoS<br>
     *
     * @param ChannelSftp channelSftp, String fileName, String svrPath
     * @return void
     * @throws Exception 
     */
	public void download(String fileName, String svrPath) throws Exception {
		download(fileName, svrPath, "");
	}	
	
    /**
     * SFTP Connection 을 통해 파일을 다운로드 한다.
     *
     * @author ChAoS<br>
     *
     * @param ChannelSftp channelSftp, String fileName, String svrPath, String downloadPath
     * @return void
     * @throws Exception 
     */
	public void download(String fileName, String svrPath, String downloadPath) throws Exception {
		
		LOGGER.debug("==> Downloading: {}, at {}", fileName, channelSftp.getSession().getHost());
		
		// SFTP 서버에 위치한 파일 경로를 지정한다.
		channelSftp.cd(channelSftp.getHome() + "/" + svrPath);
		
		// 다운받을 파일의 경로를 설정한다.
		String filePath = propertiesService.getString("global.filedownload.path");
		
		// 다운받을 경로의 추가 파라미터가 존재하면
		if(!StringUtil.nvl(downloadPath).equals("")) {
			// 다운로드 하려는 위치의 디렉토리를 변경한다.
			filePath = filePath + downloadPath;	
		}
		
		// 파일을 다운로드한다.
		channelSftp.get(fileName, filePath);

		LOGGER.debug("==> Downloaded: {}, at {}", fileName, channelSftp.getSession().getHost());
	}
	
    /**
     * SFTP Connection 을 통해 파일을 다운로드 한다.
     *
     * @author ChAoS<br>
     *
     * @param ChannelSftp channelSftp, String fileName, String svrPath, String downloadPath
     * @return void
     * @throws Exception 
     */
	public void download(String home, String fileName, String svrPath, String downloadPath) throws Exception {
		
		LOGGER.debug("==> Downloading: {}, at {}", fileName, channelSftp.getSession().getHost());
		
		// SFTP 서버에 위치한 파일 경로를 지정한다.
		channelSftp.cd(home + "/" + svrPath);
		
		// 다운받을 파일의 경로를 설정한다.
		String filePath = propertiesService.getString("global.filedownload.path");
		
		// 다운받을 경로의 추가 파라미터가 존재하면
		if(!StringUtil.nvl(downloadPath).equals("")) {
			// 다운로드 하려는 위치의 디렉토리를 변경한다.
			filePath = filePath + downloadPath;	
		}
		
		// 파일을 다운로드한다.
		channelSftp.get(fileName, filePath);

		LOGGER.debug("==> Downloaded: {}, at {}", fileName, channelSftp.getSession().getHost());
	}

    /**
     * SFTP Connection 을 종료한다
     *
     * @author ChAoS<br>
     *
     * @param null
     * @return void
     * @throws Exception 
     */
	public void disconnect() throws Exception {
		channelSftp.disconnect();
		session.disconnect();
	}
	
}